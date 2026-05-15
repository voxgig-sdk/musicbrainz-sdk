# Musicbrainz SDK feature factory

from feature.base_feature import MusicbrainzBaseFeature
from feature.test_feature import MusicbrainzTestFeature


def _make_feature(name):
    features = {
        "base": lambda: MusicbrainzBaseFeature(),
        "test": lambda: MusicbrainzTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
