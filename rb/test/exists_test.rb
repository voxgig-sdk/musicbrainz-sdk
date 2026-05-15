# Musicbrainz SDK exists test

require "minitest/autorun"
require_relative "../Musicbrainz_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = MusicbrainzSDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
