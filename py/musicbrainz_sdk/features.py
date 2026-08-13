# Musicbrainz SDK feature factory

from musicbrainz_sdk.feature.base_feature import MusicbrainzBaseFeature
from musicbrainz_sdk.feature.test_feature import MusicbrainzTestFeature


def _make_feature(name):
    features = {
        "base": lambda: MusicbrainzBaseFeature(),
        "test": lambda: MusicbrainzTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
