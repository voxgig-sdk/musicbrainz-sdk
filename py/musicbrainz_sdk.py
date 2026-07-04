# Musicbrainz SDK

from utility.voxgig_struct import voxgig_struct as vs
from core.utility_type import MusicbrainzUtility
from core.spec import MusicbrainzSpec
from core import helpers

# Load utility registration (populates Utility._registrar)
from utility import register

# Load features
from feature.base_feature import MusicbrainzBaseFeature
from features import _make_feature


class MusicbrainzSDK:

    def __init__(self, options=None):
        self.mode = "live"
        self.features = []
        self.options = None

        utility = MusicbrainzUtility()
        self._utility = utility

        from config import make_config
        config = make_config()

        self._rootctx = utility.make_context({
            "client": self,
            "utility": utility,
            "config": config,
            "options": options if options is not None else {},
            "shared": {},
        }, None)

        self.options = utility.make_options(self._rootctx)

        if vs.getpath(self.options, "feature.test.active") is True:
            self.mode = "test"

        self._rootctx.options = self.options

        # Add features from config.
        feature_opts = helpers.to_map(vs.getprop(self.options, "feature"))
        if feature_opts is not None:
            feature_items = vs.items(feature_opts)
            if feature_items is not None:
                for item in feature_items:
                    fname = item[0]
                    fopts = helpers.to_map(item[1])
                    if fopts is not None and fopts.get("active") is True:
                        utility.feature_add(self._rootctx, _make_feature(fname))

        # Add extension features.
        extend = vs.getprop(self.options, "extend")
        if isinstance(extend, list):
            for f in extend:
                if isinstance(f, dict) or (hasattr(f, "get_name") and callable(f.get_name)):
                    utility.feature_add(self._rootctx, f)

        # Initialize features.
        for f in self.features:
            utility.feature_init(self._rootctx, f)

        utility.feature_hook(self._rootctx, "PostConstruct")

        # #BuildFeatures

    def options_map(self):
        out = vs.clone(self.options)
        if isinstance(out, dict):
            return out
        return {}

    def get_utility(self):
        return MusicbrainzUtility.copy(self._utility)

    def get_root_ctx(self):
        return self._rootctx

    def prepare(self, fetchargs=None):
        utility = self._utility

        if fetchargs is None:
            fetchargs = {}

        ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl"))
        if ctrl is None:
            ctrl = {}

        ctx = utility.make_context({
            "opname": "prepare",
            "ctrl": ctrl,
        }, self._rootctx)

        options = self.options

        path = vs.getprop(fetchargs, "path") or ""
        if not isinstance(path, str):
            path = ""

        method = vs.getprop(fetchargs, "method") or "GET"
        if not isinstance(method, str):
            method = "GET"

        params = helpers.to_map(vs.getprop(fetchargs, "params"))
        if params is None:
            params = {}
        query = helpers.to_map(vs.getprop(fetchargs, "query"))
        if query is None:
            query = {}

        headers = utility.prepare_headers(ctx)

        base = vs.getprop(options, "base") or ""
        if not isinstance(base, str):
            base = ""
        prefix = vs.getprop(options, "prefix") or ""
        if not isinstance(prefix, str):
            prefix = ""
        suffix = vs.getprop(options, "suffix") or ""
        if not isinstance(suffix, str):
            suffix = ""

        ctx.spec = MusicbrainzSpec({
            "base": base,
            "prefix": prefix,
            "suffix": suffix,
            "path": path,
            "method": method,
            "params": params,
            "query": query,
            "headers": headers,
            "body": vs.getprop(fetchargs, "body"),
            "step": "start",
        })

        # Merge user-provided headers.
        uh = vs.getprop(fetchargs, "headers")
        if isinstance(uh, dict):
            for k, v in uh.items():
                ctx.spec.headers[k] = v

        _, err = utility.prepare_auth(ctx)
        if err is not None:
            raise err

        fetchdef, err = utility.make_fetch_def(ctx)
        if err is not None:
            raise err

        return fetchdef

    def direct(self, fetchargs=None):
        utility = self._utility

        try:
            fetchdef = self.prepare(fetchargs)
        except Exception as err:
            # direct() is the raw-HTTP escape hatch: it never raises, it
            # returns a result object callers branch on via result["ok"].
            return {"ok": False, "err": err}

        if fetchargs is None:
            fetchargs = {}
        ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl"))
        if ctrl is None:
            ctrl = {}

        ctx = utility.make_context({
            "opname": "direct",
            "ctrl": ctrl,
        }, self._rootctx)

        url = fetchdef.get("url", "")
        fetched, fetch_err = utility.fetcher(ctx, url, fetchdef)

        if fetch_err is not None:
            return {"ok": False, "err": fetch_err}

        if fetched is None:
            return {
                "ok": False,
                "err": ctx.make_error("direct_no_response", "response: undefined"),
            }

        if isinstance(fetched, dict):
            status = helpers.to_int(vs.getprop(fetched, "status"))
            headers = vs.getprop(fetched, "headers") or {}

            # No-body responses (204, 304) and explicit zero content-length
            # must skip JSON parsing — calling json() on an empty body raises.
            content_length = None
            if isinstance(headers, dict):
                content_length = headers.get("content-length")
            no_body = status in (204, 304) or str(content_length) == "0"

            json_data = None
            if not no_body:
                jf = vs.getprop(fetched, "json")
                if callable(jf):
                    try:
                        json_data = jf()
                    except Exception:
                        # Non-JSON body (e.g. text/plain, text/html). Surface
                        # status + headers but leave data as None.
                        json_data = None

            return {
                "ok": status >= 200 and status < 300,
                "status": status,
                "headers": headers,
                "data": json_data,
            }

        return {
            "ok": False,
            "err": ctx.make_error("direct_invalid", "invalid response type"),
        }


    def Area(self, data=None) -> "AreaEntity":
        """Entity factory: client.Area().list({}) / client.Area().load({"id": ...})."""
        from entity.area_entity import AreaEntity
        return AreaEntity(self, data)


    def Artist(self, data=None) -> "ArtistEntity":
        """Entity factory: client.Artist().list({}) / client.Artist().load({"id": ...})."""
        from entity.artist_entity import ArtistEntity
        return ArtistEntity(self, data)


    def Collection(self, data=None) -> "CollectionEntity":
        """Entity factory: client.Collection().list({}) / client.Collection().load({"id": ...})."""
        from entity.collection_entity import CollectionEntity
        return CollectionEntity(self, data)


    def Event(self, data=None) -> "EventEntity":
        """Entity factory: client.Event().list({}) / client.Event().load({"id": ...})."""
        from entity.event_entity import EventEntity
        return EventEntity(self, data)


    def Genre(self, data=None) -> "GenreEntity":
        """Entity factory: client.Genre().list({}) / client.Genre().load({"id": ...})."""
        from entity.genre_entity import GenreEntity
        return GenreEntity(self, data)


    def Instrument(self, data=None) -> "InstrumentEntity":
        """Entity factory: client.Instrument().list({}) / client.Instrument().load({"id": ...})."""
        from entity.instrument_entity import InstrumentEntity
        return InstrumentEntity(self, data)


    def Label(self, data=None) -> "LabelEntity":
        """Entity factory: client.Label().list({}) / client.Label().load({"id": ...})."""
        from entity.label_entity import LabelEntity
        return LabelEntity(self, data)


    def Place(self, data=None) -> "PlaceEntity":
        """Entity factory: client.Place().list({}) / client.Place().load({"id": ...})."""
        from entity.place_entity import PlaceEntity
        return PlaceEntity(self, data)


    def Rating(self, data=None) -> "RatingEntity":
        """Entity factory: client.Rating().list({}) / client.Rating().load({"id": ...})."""
        from entity.rating_entity import RatingEntity
        return RatingEntity(self, data)


    def Recording(self, data=None) -> "RecordingEntity":
        """Entity factory: client.Recording().list({}) / client.Recording().load({"id": ...})."""
        from entity.recording_entity import RecordingEntity
        return RecordingEntity(self, data)


    def RecordingList(self, data=None) -> "RecordingListEntity":
        """Entity factory: client.RecordingList().list({}) / client.RecordingList().load({"id": ...})."""
        from entity.recording_list_entity import RecordingListEntity
        return RecordingListEntity(self, data)


    def Release(self, data=None) -> "ReleaseEntity":
        """Entity factory: client.Release().list({}) / client.Release().load({"id": ...})."""
        from entity.release_entity import ReleaseEntity
        return ReleaseEntity(self, data)


    def ReleaseGroup(self, data=None) -> "ReleaseGroupEntity":
        """Entity factory: client.ReleaseGroup().list({}) / client.ReleaseGroup().load({"id": ...})."""
        from entity.release_group_entity import ReleaseGroupEntity
        return ReleaseGroupEntity(self, data)


    def ReleaseList(self, data=None) -> "ReleaseListEntity":
        """Entity factory: client.ReleaseList().list({}) / client.ReleaseList().load({"id": ...})."""
        from entity.release_list_entity import ReleaseListEntity
        return ReleaseListEntity(self, data)


    def Series(self, data=None) -> "SeriesEntity":
        """Entity factory: client.Series().list({}) / client.Series().load({"id": ...})."""
        from entity.series_entity import SeriesEntity
        return SeriesEntity(self, data)


    def Tag(self, data=None) -> "TagEntity":
        """Entity factory: client.Tag().list({}) / client.Tag().load({"id": ...})."""
        from entity.tag_entity import TagEntity
        return TagEntity(self, data)


    def Url(self, data=None) -> "UrlEntity":
        """Entity factory: client.Url().list({}) / client.Url().load({"id": ...})."""
        from entity.url_entity import UrlEntity
        return UrlEntity(self, data)


    def Work(self, data=None) -> "WorkEntity":
        """Entity factory: client.Work().list({}) / client.Work().load({"id": ...})."""
        from entity.work_entity import WorkEntity
        return WorkEntity(self, data)


    def WorkList(self, data=None) -> "WorkListEntity":
        """Entity factory: client.WorkList().list({}) / client.WorkList().load({"id": ...})."""
        from entity.work_list_entity import WorkListEntity
        return WorkListEntity(self, data)



    @classmethod
    def test(cls, testopts=None, sdkopts=None) -> "MusicbrainzSDK":
        if sdkopts is None:
            sdkopts = {}
        sdkopts = vs.clone(sdkopts)
        if not isinstance(sdkopts, dict):
            sdkopts = {}

        if testopts is None:
            testopts = {}
        testopts = vs.clone(testopts)
        if not isinstance(testopts, dict):
            testopts = {}
        testopts["active"] = True

        vs.setpath(sdkopts, "feature.test", testopts)

        sdk = cls(sdkopts)
        sdk.mode = "test"

        return sdk


from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from entity.area_entity import AreaEntity
    from entity.artist_entity import ArtistEntity
    from entity.collection_entity import CollectionEntity
    from entity.event_entity import EventEntity
    from entity.genre_entity import GenreEntity
    from entity.instrument_entity import InstrumentEntity
    from entity.label_entity import LabelEntity
    from entity.place_entity import PlaceEntity
    from entity.rating_entity import RatingEntity
    from entity.recording_entity import RecordingEntity
    from entity.recording_list_entity import RecordingListEntity
    from entity.release_entity import ReleaseEntity
    from entity.release_group_entity import ReleaseGroupEntity
    from entity.release_list_entity import ReleaseListEntity
    from entity.series_entity import SeriesEntity
    from entity.tag_entity import TagEntity
    from entity.url_entity import UrlEntity
    from entity.work_entity import WorkEntity
    from entity.work_list_entity import WorkListEntity
