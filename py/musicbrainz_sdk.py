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


    @property
    def area(self):
        """Idiomatic facade: client.area.list() / client.area.load({"id": ...})."""
        from entity.area_entity import AreaEntity
        cached = getattr(self, "_area", None)
        if cached is None:
            cached = AreaEntity(self, None)
            self._area = cached
        return cached

    def Area(self, data=None):
        # Deprecated: use client.area instead.
        from entity.area_entity import AreaEntity
        return AreaEntity(self, data)


    @property
    def artist(self):
        """Idiomatic facade: client.artist.list() / client.artist.load({"id": ...})."""
        from entity.artist_entity import ArtistEntity
        cached = getattr(self, "_artist", None)
        if cached is None:
            cached = ArtistEntity(self, None)
            self._artist = cached
        return cached

    def Artist(self, data=None):
        # Deprecated: use client.artist instead.
        from entity.artist_entity import ArtistEntity
        return ArtistEntity(self, data)


    @property
    def collection(self):
        """Idiomatic facade: client.collection.list() / client.collection.load({"id": ...})."""
        from entity.collection_entity import CollectionEntity
        cached = getattr(self, "_collection", None)
        if cached is None:
            cached = CollectionEntity(self, None)
            self._collection = cached
        return cached

    def Collection(self, data=None):
        # Deprecated: use client.collection instead.
        from entity.collection_entity import CollectionEntity
        return CollectionEntity(self, data)


    @property
    def event(self):
        """Idiomatic facade: client.event.list() / client.event.load({"id": ...})."""
        from entity.event_entity import EventEntity
        cached = getattr(self, "_event", None)
        if cached is None:
            cached = EventEntity(self, None)
            self._event = cached
        return cached

    def Event(self, data=None):
        # Deprecated: use client.event instead.
        from entity.event_entity import EventEntity
        return EventEntity(self, data)


    @property
    def genre(self):
        """Idiomatic facade: client.genre.list() / client.genre.load({"id": ...})."""
        from entity.genre_entity import GenreEntity
        cached = getattr(self, "_genre", None)
        if cached is None:
            cached = GenreEntity(self, None)
            self._genre = cached
        return cached

    def Genre(self, data=None):
        # Deprecated: use client.genre instead.
        from entity.genre_entity import GenreEntity
        return GenreEntity(self, data)


    @property
    def instrument(self):
        """Idiomatic facade: client.instrument.list() / client.instrument.load({"id": ...})."""
        from entity.instrument_entity import InstrumentEntity
        cached = getattr(self, "_instrument", None)
        if cached is None:
            cached = InstrumentEntity(self, None)
            self._instrument = cached
        return cached

    def Instrument(self, data=None):
        # Deprecated: use client.instrument instead.
        from entity.instrument_entity import InstrumentEntity
        return InstrumentEntity(self, data)


    @property
    def label(self):
        """Idiomatic facade: client.label.list() / client.label.load({"id": ...})."""
        from entity.label_entity import LabelEntity
        cached = getattr(self, "_label", None)
        if cached is None:
            cached = LabelEntity(self, None)
            self._label = cached
        return cached

    def Label(self, data=None):
        # Deprecated: use client.label instead.
        from entity.label_entity import LabelEntity
        return LabelEntity(self, data)


    @property
    def place(self):
        """Idiomatic facade: client.place.list() / client.place.load({"id": ...})."""
        from entity.place_entity import PlaceEntity
        cached = getattr(self, "_place", None)
        if cached is None:
            cached = PlaceEntity(self, None)
            self._place = cached
        return cached

    def Place(self, data=None):
        # Deprecated: use client.place instead.
        from entity.place_entity import PlaceEntity
        return PlaceEntity(self, data)


    @property
    def rating(self):
        """Idiomatic facade: client.rating.list() / client.rating.load({"id": ...})."""
        from entity.rating_entity import RatingEntity
        cached = getattr(self, "_rating", None)
        if cached is None:
            cached = RatingEntity(self, None)
            self._rating = cached
        return cached

    def Rating(self, data=None):
        # Deprecated: use client.rating instead.
        from entity.rating_entity import RatingEntity
        return RatingEntity(self, data)


    @property
    def recording(self):
        """Idiomatic facade: client.recording.list() / client.recording.load({"id": ...})."""
        from entity.recording_entity import RecordingEntity
        cached = getattr(self, "_recording", None)
        if cached is None:
            cached = RecordingEntity(self, None)
            self._recording = cached
        return cached

    def Recording(self, data=None):
        # Deprecated: use client.recording instead.
        from entity.recording_entity import RecordingEntity
        return RecordingEntity(self, data)


    @property
    def recording_list(self):
        """Idiomatic facade: client.recording_list.list() / client.recording_list.load({"id": ...})."""
        from entity.recording_list_entity import RecordingListEntity
        cached = getattr(self, "_recording_list", None)
        if cached is None:
            cached = RecordingListEntity(self, None)
            self._recording_list = cached
        return cached

    def RecordingList(self, data=None):
        # Deprecated: use client.recording_list instead.
        from entity.recording_list_entity import RecordingListEntity
        return RecordingListEntity(self, data)


    @property
    def release(self):
        """Idiomatic facade: client.release.list() / client.release.load({"id": ...})."""
        from entity.release_entity import ReleaseEntity
        cached = getattr(self, "_release", None)
        if cached is None:
            cached = ReleaseEntity(self, None)
            self._release = cached
        return cached

    def Release(self, data=None):
        # Deprecated: use client.release instead.
        from entity.release_entity import ReleaseEntity
        return ReleaseEntity(self, data)


    @property
    def release_group(self):
        """Idiomatic facade: client.release_group.list() / client.release_group.load({"id": ...})."""
        from entity.release_group_entity import ReleaseGroupEntity
        cached = getattr(self, "_release_group", None)
        if cached is None:
            cached = ReleaseGroupEntity(self, None)
            self._release_group = cached
        return cached

    def ReleaseGroup(self, data=None):
        # Deprecated: use client.release_group instead.
        from entity.release_group_entity import ReleaseGroupEntity
        return ReleaseGroupEntity(self, data)


    @property
    def release_list(self):
        """Idiomatic facade: client.release_list.list() / client.release_list.load({"id": ...})."""
        from entity.release_list_entity import ReleaseListEntity
        cached = getattr(self, "_release_list", None)
        if cached is None:
            cached = ReleaseListEntity(self, None)
            self._release_list = cached
        return cached

    def ReleaseList(self, data=None):
        # Deprecated: use client.release_list instead.
        from entity.release_list_entity import ReleaseListEntity
        return ReleaseListEntity(self, data)


    @property
    def series(self):
        """Idiomatic facade: client.series.list() / client.series.load({"id": ...})."""
        from entity.series_entity import SeriesEntity
        cached = getattr(self, "_series", None)
        if cached is None:
            cached = SeriesEntity(self, None)
            self._series = cached
        return cached

    def Series(self, data=None):
        # Deprecated: use client.series instead.
        from entity.series_entity import SeriesEntity
        return SeriesEntity(self, data)


    @property
    def tag(self):
        """Idiomatic facade: client.tag.list() / client.tag.load({"id": ...})."""
        from entity.tag_entity import TagEntity
        cached = getattr(self, "_tag", None)
        if cached is None:
            cached = TagEntity(self, None)
            self._tag = cached
        return cached

    def Tag(self, data=None):
        # Deprecated: use client.tag instead.
        from entity.tag_entity import TagEntity
        return TagEntity(self, data)


    @property
    def url(self):
        """Idiomatic facade: client.url.list() / client.url.load({"id": ...})."""
        from entity.url_entity import UrlEntity
        cached = getattr(self, "_url", None)
        if cached is None:
            cached = UrlEntity(self, None)
            self._url = cached
        return cached

    def Url(self, data=None):
        # Deprecated: use client.url instead.
        from entity.url_entity import UrlEntity
        return UrlEntity(self, data)


    @property
    def work(self):
        """Idiomatic facade: client.work.list() / client.work.load({"id": ...})."""
        from entity.work_entity import WorkEntity
        cached = getattr(self, "_work", None)
        if cached is None:
            cached = WorkEntity(self, None)
            self._work = cached
        return cached

    def Work(self, data=None):
        # Deprecated: use client.work instead.
        from entity.work_entity import WorkEntity
        return WorkEntity(self, data)


    @property
    def work_list(self):
        """Idiomatic facade: client.work_list.list() / client.work_list.load({"id": ...})."""
        from entity.work_list_entity import WorkListEntity
        cached = getattr(self, "_work_list", None)
        if cached is None:
            cached = WorkListEntity(self, None)
            self._work_list = cached
        return cached

    def WorkList(self, data=None):
        # Deprecated: use client.work_list instead.
        from entity.work_list_entity import WorkListEntity
        return WorkListEntity(self, data)



    @classmethod
    def test(cls, testopts=None, sdkopts=None):
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
