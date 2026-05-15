# Musicbrainz SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module MusicbrainzFeatures
  def self.make_feature(name)
    case name
    when "base"
      MusicbrainzBaseFeature.new
    when "test"
      MusicbrainzTestFeature.new
    else
      MusicbrainzBaseFeature.new
    end
  end
end
