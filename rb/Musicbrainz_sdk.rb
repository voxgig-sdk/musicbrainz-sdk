# Musicbrainz SDK

require_relative 'utility/struct/voxgig_struct'
require_relative 'core/utility_type'
require_relative 'core/spec'
require_relative 'core/helpers'

# Load utility registration
require_relative 'utility/register'

# Load config and features
require_relative 'config'
require_relative 'feature/base_feature'
require_relative 'features'

# Load typed models (Struct value objects).
require_relative 'Musicbrainz_types'


class MusicbrainzSDK
  attr_accessor :mode, :features, :options

  def initialize(options = {})
    @mode = "live"
    @features = []
    @options = nil

    utility = MusicbrainzUtility.new
    @_utility = utility

    config = MusicbrainzConfig.make_config

    @_rootctx = utility.make_context.call({
      "client" => self,
      "utility" => utility,
      "config" => config,
      "options" => options || {},
      "shared" => {},
    }, nil)

    @options = utility.make_options.call(@_rootctx)

    if VoxgigStruct.getpath(@options, "feature.test.active") == true
      @mode = "test"
    end

    @_rootctx.options = @options

    # Add features from config.
    feature_opts = MusicbrainzHelpers.to_map(VoxgigStruct.getprop(@options, "feature"))
    if feature_opts
      items = VoxgigStruct.items(feature_opts)
      if items
        items.each do |item|
          fname = item[0]
          fopts = MusicbrainzHelpers.to_map(item[1])
          if fopts && fopts["active"] == true
            utility.feature_add.call(@_rootctx, MusicbrainzFeatures.make_feature(fname))
          end
        end
      end
    end

    # Add extension features.
    extend_val = VoxgigStruct.getprop(@options, "extend")
    if extend_val.is_a?(Array)
      extend_val.each do |f|
        if f.respond_to?(:get_name)
          utility.feature_add.call(@_rootctx, f)
        end
      end
    end

    # Initialize features.
    @features.each do |f|
      utility.feature_init.call(@_rootctx, f)
    end

    utility.feature_hook.call(@_rootctx, "PostConstruct")
  end

  def options_map
    out = VoxgigStruct.clone(@options)
    out.is_a?(Hash) ? out : {}
  end

  def get_utility
    MusicbrainzUtility.copy(@_utility)
  end

  def get_root_ctx
    @_rootctx
  end

  def prepare(fetchargs = {})
    utility = @_utility
    fetchargs ||= {}

    ctrl = MusicbrainzHelpers.to_map(VoxgigStruct.getprop(fetchargs, "ctrl")) || {}

    ctx = utility.make_context.call({
      "opname" => "prepare",
      "ctrl" => ctrl,
    }, @_rootctx)

    opts = @options
    path = VoxgigStruct.getprop(fetchargs, "path") || ""
    path = "" unless path.is_a?(String)
    method_val = VoxgigStruct.getprop(fetchargs, "method") || "GET"
    method_val = "GET" unless method_val.is_a?(String)
    params = MusicbrainzHelpers.to_map(VoxgigStruct.getprop(fetchargs, "params")) || {}
    query = MusicbrainzHelpers.to_map(VoxgigStruct.getprop(fetchargs, "query")) || {}
    headers = utility.prepare_headers.call(ctx)

    base = VoxgigStruct.getprop(opts, "base") || ""
    base = "" unless base.is_a?(String)
    prefix = VoxgigStruct.getprop(opts, "prefix") || ""
    prefix = "" unless prefix.is_a?(String)
    suffix = VoxgigStruct.getprop(opts, "suffix") || ""
    suffix = "" unless suffix.is_a?(String)

    ctx.spec = MusicbrainzSpec.new({
      "base" => base, "prefix" => prefix, "suffix" => suffix,
      "path" => path, "method" => method_val,
      "params" => params, "query" => query, "headers" => headers,
      "body" => VoxgigStruct.getprop(fetchargs, "body"),
      "step" => "start",
    })

    # Merge user-provided headers.
    uh = VoxgigStruct.getprop(fetchargs, "headers")
    if uh.is_a?(Hash)
      uh.each { |k, v| ctx.spec.headers[k] = v }
    end

    _, err = utility.prepare_auth.call(ctx)
    raise err if err

    utility.make_fetch_def.call(ctx)
  end

  def direct(fetchargs = {})
    utility = @_utility

    # direct() is the raw-HTTP escape hatch: it always returns a result hash
    # ({ "ok" => ..., ... }) and never raises. prepare() raises on error, so
    # trap that and surface it in the hash.
    begin
      fetchdef = prepare(fetchargs)
    rescue MusicbrainzError => err
      return { "ok" => false, "err" => err }
    end

    fetchargs ||= {}
    ctrl = MusicbrainzHelpers.to_map(VoxgigStruct.getprop(fetchargs, "ctrl")) || {}

    ctx = utility.make_context.call({
      "opname" => "direct",
      "ctrl" => ctrl,
    }, @_rootctx)

    url = fetchdef["url"] || ""
    fetched, fetch_err = utility.fetcher.call(ctx, url, fetchdef)

    return { "ok" => false, "err" => fetch_err } if fetch_err

    if fetched.nil?
      return {
        "ok" => false,
        "err" => ctx.make_error("direct_no_response", "response: undefined"),
      }
    end

    if fetched.is_a?(Hash)
      status = MusicbrainzHelpers.to_int(VoxgigStruct.getprop(fetched, "status"))
      headers = VoxgigStruct.getprop(fetched, "headers") || {}

      # No-body responses (204, 304) and explicit zero content-length must
      # skip JSON parsing — calling json() on an empty body errors.
      content_length = headers.is_a?(Hash) ? headers["content-length"] : nil
      no_body = status == 204 || status == 304 || content_length.to_s == "0"

      json_data = nil
      unless no_body
        jf = VoxgigStruct.getprop(fetched, "json")
        if jf.is_a?(Proc)
          begin
            json_data = jf.call
          rescue StandardError
            # Non-JSON body — leave data nil, keep status/headers.
            json_data = nil
          end
        end
      end

      return {
        "ok" => status >= 200 && status < 300,
        "status" => status,
        "headers" => headers,
        "data" => json_data,
      }
    end

    return {
      "ok" => false,
      "err" => ctx.make_error("direct_invalid", "invalid response type"),
    }
  end


  # Idiomatic facade: client.area.list / client.area.load({ "id" => ... })
  def area
    require_relative 'entity/area_entity'
    @area ||= AreaEntity.new(self, nil)
  end

  # Deprecated: use client.area instead.
  def Area(data = nil)
    require_relative 'entity/area_entity'
    AreaEntity.new(self, data)
  end


  # Idiomatic facade: client.artist.list / client.artist.load({ "id" => ... })
  def artist
    require_relative 'entity/artist_entity'
    @artist ||= ArtistEntity.new(self, nil)
  end

  # Deprecated: use client.artist instead.
  def Artist(data = nil)
    require_relative 'entity/artist_entity'
    ArtistEntity.new(self, data)
  end


  # Idiomatic facade: client.collection.list / client.collection.load({ "id" => ... })
  def collection
    require_relative 'entity/collection_entity'
    @collection ||= CollectionEntity.new(self, nil)
  end

  # Deprecated: use client.collection instead.
  def Collection(data = nil)
    require_relative 'entity/collection_entity'
    CollectionEntity.new(self, data)
  end


  # Idiomatic facade: client.event.list / client.event.load({ "id" => ... })
  def event
    require_relative 'entity/event_entity'
    @event ||= EventEntity.new(self, nil)
  end

  # Deprecated: use client.event instead.
  def Event(data = nil)
    require_relative 'entity/event_entity'
    EventEntity.new(self, data)
  end


  # Idiomatic facade: client.genre.list / client.genre.load({ "id" => ... })
  def genre
    require_relative 'entity/genre_entity'
    @genre ||= GenreEntity.new(self, nil)
  end

  # Deprecated: use client.genre instead.
  def Genre(data = nil)
    require_relative 'entity/genre_entity'
    GenreEntity.new(self, data)
  end


  # Idiomatic facade: client.instrument.list / client.instrument.load({ "id" => ... })
  def instrument
    require_relative 'entity/instrument_entity'
    @instrument ||= InstrumentEntity.new(self, nil)
  end

  # Deprecated: use client.instrument instead.
  def Instrument(data = nil)
    require_relative 'entity/instrument_entity'
    InstrumentEntity.new(self, data)
  end


  # Idiomatic facade: client.label.list / client.label.load({ "id" => ... })
  def label
    require_relative 'entity/label_entity'
    @label ||= LabelEntity.new(self, nil)
  end

  # Deprecated: use client.label instead.
  def Label(data = nil)
    require_relative 'entity/label_entity'
    LabelEntity.new(self, data)
  end


  # Idiomatic facade: client.place.list / client.place.load({ "id" => ... })
  def place
    require_relative 'entity/place_entity'
    @place ||= PlaceEntity.new(self, nil)
  end

  # Deprecated: use client.place instead.
  def Place(data = nil)
    require_relative 'entity/place_entity'
    PlaceEntity.new(self, data)
  end


  # Idiomatic facade: client.rating.list / client.rating.load({ "id" => ... })
  def rating
    require_relative 'entity/rating_entity'
    @rating ||= RatingEntity.new(self, nil)
  end

  # Deprecated: use client.rating instead.
  def Rating(data = nil)
    require_relative 'entity/rating_entity'
    RatingEntity.new(self, data)
  end


  # Idiomatic facade: client.recording.list / client.recording.load({ "id" => ... })
  def recording
    require_relative 'entity/recording_entity'
    @recording ||= RecordingEntity.new(self, nil)
  end

  # Deprecated: use client.recording instead.
  def Recording(data = nil)
    require_relative 'entity/recording_entity'
    RecordingEntity.new(self, data)
  end


  # Idiomatic facade: client.recording_list.list / client.recording_list.load({ "id" => ... })
  def recording_list
    require_relative 'entity/recording_list_entity'
    @recording_list ||= RecordingListEntity.new(self, nil)
  end

  # Deprecated: use client.recording_list instead.
  def RecordingList(data = nil)
    require_relative 'entity/recording_list_entity'
    RecordingListEntity.new(self, data)
  end


  # Idiomatic facade: client.release.list / client.release.load({ "id" => ... })
  def release
    require_relative 'entity/release_entity'
    @release ||= ReleaseEntity.new(self, nil)
  end

  # Deprecated: use client.release instead.
  def Release(data = nil)
    require_relative 'entity/release_entity'
    ReleaseEntity.new(self, data)
  end


  # Idiomatic facade: client.release_group.list / client.release_group.load({ "id" => ... })
  def release_group
    require_relative 'entity/release_group_entity'
    @release_group ||= ReleaseGroupEntity.new(self, nil)
  end

  # Deprecated: use client.release_group instead.
  def ReleaseGroup(data = nil)
    require_relative 'entity/release_group_entity'
    ReleaseGroupEntity.new(self, data)
  end


  # Idiomatic facade: client.release_list.list / client.release_list.load({ "id" => ... })
  def release_list
    require_relative 'entity/release_list_entity'
    @release_list ||= ReleaseListEntity.new(self, nil)
  end

  # Deprecated: use client.release_list instead.
  def ReleaseList(data = nil)
    require_relative 'entity/release_list_entity'
    ReleaseListEntity.new(self, data)
  end


  # Idiomatic facade: client.series.list / client.series.load({ "id" => ... })
  def series
    require_relative 'entity/series_entity'
    @series ||= SeriesEntity.new(self, nil)
  end

  # Deprecated: use client.series instead.
  def Series(data = nil)
    require_relative 'entity/series_entity'
    SeriesEntity.new(self, data)
  end


  # Idiomatic facade: client.tag.list / client.tag.load({ "id" => ... })
  def tag
    require_relative 'entity/tag_entity'
    @tag ||= TagEntity.new(self, nil)
  end

  # Deprecated: use client.tag instead.
  def Tag(data = nil)
    require_relative 'entity/tag_entity'
    TagEntity.new(self, data)
  end


  # Idiomatic facade: client.url.list / client.url.load({ "id" => ... })
  def url
    require_relative 'entity/url_entity'
    @url ||= UrlEntity.new(self, nil)
  end

  # Deprecated: use client.url instead.
  def Url(data = nil)
    require_relative 'entity/url_entity'
    UrlEntity.new(self, data)
  end


  # Idiomatic facade: client.work.list / client.work.load({ "id" => ... })
  def work
    require_relative 'entity/work_entity'
    @work ||= WorkEntity.new(self, nil)
  end

  # Deprecated: use client.work instead.
  def Work(data = nil)
    require_relative 'entity/work_entity'
    WorkEntity.new(self, data)
  end


  # Idiomatic facade: client.work_list.list / client.work_list.load({ "id" => ... })
  def work_list
    require_relative 'entity/work_list_entity'
    @work_list ||= WorkListEntity.new(self, nil)
  end

  # Deprecated: use client.work_list instead.
  def WorkList(data = nil)
    require_relative 'entity/work_list_entity'
    WorkListEntity.new(self, data)
  end



  def self.test(testopts = nil, sdkopts = nil)
    sdkopts = sdkopts || {}
    sdkopts = VoxgigStruct.clone(sdkopts)
    sdkopts = {} unless sdkopts.is_a?(Hash)

    testopts = testopts || {}
    testopts = VoxgigStruct.clone(testopts)
    testopts = {} unless testopts.is_a?(Hash)
    testopts["active"] = true

    VoxgigStruct.setpath(sdkopts, "feature.test", testopts)

    sdk = MusicbrainzSDK.new(sdkopts)
    sdk.mode = "test"
    sdk
  end
end
