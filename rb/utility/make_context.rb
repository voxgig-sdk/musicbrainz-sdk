# Musicbrainz SDK utility: make_context
require_relative '../core/context'
module MusicbrainzUtilities
  MakeContext = ->(ctxmap, basectx) {
    MusicbrainzContext.new(ctxmap, basectx)
  }
end
