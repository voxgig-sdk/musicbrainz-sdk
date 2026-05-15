# Musicbrainz SDK utility: feature_add
module MusicbrainzUtilities
  FeatureAdd = ->(ctx, f) {
    ctx.client.features << f
  }
end
