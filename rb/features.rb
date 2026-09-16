# Musicbrainz SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'


module MusicbrainzFeatures
  def self.make_feature(name)
    case name
    when "base"
      MusicbrainzBaseFeature.new
    when "ratelimit"
      MusicbrainzRatelimitFeature.new
    when "retry"
      MusicbrainzRetryFeature.new
    when "test"
      MusicbrainzTestFeature.new
    when "timeout"
      MusicbrainzTimeoutFeature.new
    else
      MusicbrainzBaseFeature.new
    end
  end
end
