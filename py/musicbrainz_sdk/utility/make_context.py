# Musicbrainz SDK utility: make_context

from musicbrainz_sdk.core.context import MusicbrainzContext


def make_context_util(ctxmap, basectx):
    return MusicbrainzContext(ctxmap, basectx)
