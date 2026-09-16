# Musicbrainz SDK feature factory

from musicbrainz_sdk.feature.base_feature import MusicbrainzBaseFeature
from musicbrainz_sdk.feature.ratelimit_feature import MusicbrainzRatelimitFeature
from musicbrainz_sdk.feature.retry_feature import MusicbrainzRetryFeature
from musicbrainz_sdk.feature.test_feature import MusicbrainzTestFeature
from musicbrainz_sdk.feature.timeout_feature import MusicbrainzTimeoutFeature


_FEATURES = {
    "base": lambda: MusicbrainzBaseFeature(),
    "ratelimit": lambda: MusicbrainzRatelimitFeature(),
    "retry": lambda: MusicbrainzRetryFeature(),
    "test": lambda: MusicbrainzTestFeature(),
    "timeout": lambda: MusicbrainzTimeoutFeature(),
}


def _make_feature(name):
    factory = _FEATURES.get(name)
    if factory is not None:
        return factory()
    return _FEATURES["base"]()


# True when this SDK was generated with the named feature class - the
# constructor's tolerance for extend-carried features reads this (an
# active name with no generated class must not become a BaseFeature
# stray when an extend instance carries it).
def _has_feature(name):
    return name in _FEATURES
