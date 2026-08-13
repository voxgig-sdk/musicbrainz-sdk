# Musicbrainz SDK exists test

import pytest
from musicbrainz_sdk import MusicbrainzSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = MusicbrainzSDK.test(None, None)
        assert testsdk is not None
