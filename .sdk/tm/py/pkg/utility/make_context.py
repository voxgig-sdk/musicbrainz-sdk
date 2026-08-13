# Musicbrainz SDK utility: make_context

from projectname_sdk.core.context import MusicbrainzContext


def make_context_util(ctxmap, basectx):
    return MusicbrainzContext(ctxmap, basectx)
