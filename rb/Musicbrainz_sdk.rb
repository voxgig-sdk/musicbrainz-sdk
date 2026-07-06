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

    # make_fetch_def returns a (fetchdef, err) tuple; destructure it and
    # return just the fetchdef Hash (raising on error) so callers — including
    # direct(), which indexes fetchdef["url"] — receive a Hash, mirroring the
    # ts/py prepare().
    fetchdef, fd_err = utility.make_fetch_def.call(ctx)
    raise fd_err if fd_err

    fetchdef
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


  # Canonical facade: client.Area.list / client.Area.load({ "id" => ... })
  def Area(data = nil)
    require_relative 'entity/area_entity'
    AreaEntity.new(self, data)
  end


  # Canonical facade: client.Artist.list / client.Artist.load({ "id" => ... })
  def Artist(data = nil)
    require_relative 'entity/artist_entity'
    ArtistEntity.new(self, data)
  end


  # Canonical facade: client.Collection.list / client.Collection.load({ "id" => ... })
  def Collection(data = nil)
    require_relative 'entity/collection_entity'
    CollectionEntity.new(self, data)
  end


  # Canonical facade: client.Event.list / client.Event.load({ "id" => ... })
  def Event(data = nil)
    require_relative 'entity/event_entity'
    EventEntity.new(self, data)
  end


  # Canonical facade: client.Genre.list / client.Genre.load({ "id" => ... })
  def Genre(data = nil)
    require_relative 'entity/genre_entity'
    GenreEntity.new(self, data)
  end


  # Canonical facade: client.Instrument.list / client.Instrument.load({ "id" => ... })
  def Instrument(data = nil)
    require_relative 'entity/instrument_entity'
    InstrumentEntity.new(self, data)
  end


  # Canonical facade: client.Label.list / client.Label.load({ "id" => ... })
  def Label(data = nil)
    require_relative 'entity/label_entity'
    LabelEntity.new(self, data)
  end


  # Canonical facade: client.Place.list / client.Place.load({ "id" => ... })
  def Place(data = nil)
    require_relative 'entity/place_entity'
    PlaceEntity.new(self, data)
  end


  # Canonical facade: client.Rating.list / client.Rating.load({ "id" => ... })
  def Rating(data = nil)
    require_relative 'entity/rating_entity'
    RatingEntity.new(self, data)
  end


  # Canonical facade: client.Recording.list / client.Recording.load({ "id" => ... })
  def Recording(data = nil)
    require_relative 'entity/recording_entity'
    RecordingEntity.new(self, data)
  end


  # Canonical facade: client.RecordingList.list / client.RecordingList.load({ "id" => ... })
  def RecordingList(data = nil)
    require_relative 'entity/recording_list_entity'
    RecordingListEntity.new(self, data)
  end


  # Canonical facade: client.Release.list / client.Release.load({ "id" => ... })
  def Release(data = nil)
    require_relative 'entity/release_entity'
    ReleaseEntity.new(self, data)
  end


  # Canonical facade: client.ReleaseGroup.list / client.ReleaseGroup.load({ "id" => ... })
  def ReleaseGroup(data = nil)
    require_relative 'entity/release_group_entity'
    ReleaseGroupEntity.new(self, data)
  end


  # Canonical facade: client.ReleaseList.list / client.ReleaseList.load({ "id" => ... })
  def ReleaseList(data = nil)
    require_relative 'entity/release_list_entity'
    ReleaseListEntity.new(self, data)
  end


  # Canonical facade: client.Series.list / client.Series.load({ "id" => ... })
  def Series(data = nil)
    require_relative 'entity/series_entity'
    SeriesEntity.new(self, data)
  end


  # Canonical facade: client.Tag.list / client.Tag.load({ "id" => ... })
  def Tag(data = nil)
    require_relative 'entity/tag_entity'
    TagEntity.new(self, data)
  end


  # Canonical facade: client.Url.list / client.Url.load({ "id" => ... })
  def Url(data = nil)
    require_relative 'entity/url_entity'
    UrlEntity.new(self, data)
  end


  # Canonical facade: client.Work.list / client.Work.load({ "id" => ... })
  def Work(data = nil)
    require_relative 'entity/work_entity'
    WorkEntity.new(self, data)
  end


  # Canonical facade: client.WorkList.list / client.WorkList.load({ "id" => ... })
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
