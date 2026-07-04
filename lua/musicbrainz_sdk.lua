-- Musicbrainz SDK

local vs = require("utility.struct.struct")
local Utility = require("core.utility_type")
local Spec = require("core.spec")
local helpers = require("core.helpers")

-- Load utility registration (populates Utility._registrar)
require("utility.register")

-- Load features
local BaseFeature = require("feature.base_feature")
local features_factory = require("features")


local MusicbrainzSDK = {}
MusicbrainzSDK.__index = MusicbrainzSDK


local function _make_feature(name)
  local factory = features_factory[name]
  if factory ~= nil then
    return factory()
  end
  return features_factory.base()
end

MusicbrainzSDK._make_feature = _make_feature


function MusicbrainzSDK.new(options)
  local self = setmetatable({}, MusicbrainzSDK)
  self.mode = "live"
  self.features = {}
  self.options = nil

  local utility = Utility.new()
  self._utility = utility

  local config = require("config")()

  self._rootctx = utility.make_context({
    client = self,
    utility = utility,
    config = config,
    options = options or {},
    shared = {},
  }, nil)

  self.options = utility.make_options(self._rootctx)

  if vs.getpath(self.options, "feature.test.active") == true then
    self.mode = "test"
  end

  self._rootctx.options = self.options

  -- Add features from config.
  local feature_opts = helpers.to_map(vs.getprop(self.options, "feature"))
  if feature_opts ~= nil then
    local feature_items = vs.items(feature_opts)
    if feature_items ~= nil then
      for _, item in ipairs(feature_items) do
        local fname = item[1]
        local fopts = helpers.to_map(item[2])
        if fopts ~= nil and fopts["active"] == true then
          utility.feature_add(self._rootctx, _make_feature(fname))
        end
      end
    end
  end

  -- Add extension features.
  local extend = vs.getprop(self.options, "extend")
  if type(extend) == "table" then
    for _, f in ipairs(extend) do
      if type(f) == "table" and type(f.get_name) == "function" then
        utility.feature_add(self._rootctx, f)
      end
    end
  end

  -- Initialize features.
  for _, f in ipairs(self.features) do
    utility.feature_init(self._rootctx, f)
  end

  utility.feature_hook(self._rootctx, "PostConstruct")

  -- #BuildFeatures

  return self
end


function MusicbrainzSDK:options_map()
  local out = vs.clone(self.options)
  if type(out) == "table" then
    return out
  end
  return {}
end


function MusicbrainzSDK:get_utility()
  return Utility.copy(self._utility)
end


function MusicbrainzSDK:get_root_ctx()
  return self._rootctx
end


function MusicbrainzSDK:prepare(fetchargs)
  local utility = self._utility

  fetchargs = fetchargs or {}

  local ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl")) or {}

  local ctx = utility.make_context({
    opname = "prepare",
    ctrl = ctrl,
  }, self._rootctx)

  local options = self.options

  local path = vs.getprop(fetchargs, "path") or ""
  if type(path) ~= "string" then path = "" end

  local method = vs.getprop(fetchargs, "method") or "GET"
  if type(method) ~= "string" then method = "GET" end

  local params = helpers.to_map(vs.getprop(fetchargs, "params")) or {}
  local query = helpers.to_map(vs.getprop(fetchargs, "query")) or {}

  local headers = utility.prepare_headers(ctx)

  local base = vs.getprop(options, "base") or ""
  if type(base) ~= "string" then base = "" end
  local prefix = vs.getprop(options, "prefix") or ""
  if type(prefix) ~= "string" then prefix = "" end
  local suffix = vs.getprop(options, "suffix") or ""
  if type(suffix) ~= "string" then suffix = "" end

  ctx.spec = Spec.new({
    base = base,
    prefix = prefix,
    suffix = suffix,
    path = path,
    method = method,
    params = params,
    query = query,
    headers = headers,
    body = vs.getprop(fetchargs, "body"),
    step = "start",
  })

  -- Merge user-provided headers.
  local uh = vs.getprop(fetchargs, "headers")
  if type(uh) == "table" then
    for k, v in pairs(uh) do
      ctx.spec.headers[k] = v
    end
  end

  local _, err = utility.prepare_auth(ctx)
  if err ~= nil then
    return nil, err
  end

  return utility.make_fetch_def(ctx)
end


function MusicbrainzSDK:direct(fetchargs)
  local utility = self._utility

  local fetchdef, err = self:prepare(fetchargs)
  if err ~= nil then
    return { ok = false, err = err }, nil
  end

  fetchargs = fetchargs or {}
  local ctrl = helpers.to_map(vs.getprop(fetchargs, "ctrl")) or {}

  local ctx = utility.make_context({
    opname = "direct",
    ctrl = ctrl,
  }, self._rootctx)

  local url = fetchdef["url"] or ""
  local fetched, fetch_err = utility.fetcher(ctx, url, fetchdef)

  if fetch_err ~= nil then
    return { ok = false, err = fetch_err }, nil
  end

  if fetched == nil then
    return {
      ok = false,
      err = ctx:make_error("direct_no_response", "response: undefined"),
    }, nil
  end

  if type(fetched) == "table" then
    local status = helpers.to_int(vs.getprop(fetched, "status"))
    local headers = vs.getprop(fetched, "headers") or {}

    -- No-body responses (204, 304) and explicit zero content-length
    -- must skip JSON parsing — calling json() on an empty body errors.
    local content_length = nil
    if type(headers) == "table" then
      content_length = headers["content-length"]
    end
    local no_body = status == 204 or status == 304 or tostring(content_length) == "0"

    local json_data = nil
    if not no_body then
      local jf = vs.getprop(fetched, "json")
      if type(jf) == "function" then
        local ok, result = pcall(jf)
        if ok then
          json_data = result
        end
        -- Non-JSON body: json_data stays nil, status/headers preserved.
      end
    end

    return {
      ok = status >= 200 and status < 300,
      status = status,
      headers = headers,
      data = json_data,
    }, nil
  end

  return {
    ok = false,
    err = ctx:make_error("direct_invalid", "invalid response type"),
  }, nil
end



-- Idiomatic facade: client:area():list() / client:area():load({ id = ... })
function MusicbrainzSDK:area(data)
  local EntityMod = require("entity.area_entity")
  if data == nil then
    if self._area == nil then
      self._area = EntityMod.new(self, nil)
    end
    return self._area
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:area() instead.
function MusicbrainzSDK:Area(data)
  local EntityMod = require("entity.area_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:artist():list() / client:artist():load({ id = ... })
function MusicbrainzSDK:artist(data)
  local EntityMod = require("entity.artist_entity")
  if data == nil then
    if self._artist == nil then
      self._artist = EntityMod.new(self, nil)
    end
    return self._artist
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:artist() instead.
function MusicbrainzSDK:Artist(data)
  local EntityMod = require("entity.artist_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:collection():list() / client:collection():load({ id = ... })
function MusicbrainzSDK:collection(data)
  local EntityMod = require("entity.collection_entity")
  if data == nil then
    if self._collection == nil then
      self._collection = EntityMod.new(self, nil)
    end
    return self._collection
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:collection() instead.
function MusicbrainzSDK:Collection(data)
  local EntityMod = require("entity.collection_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:event():list() / client:event():load({ id = ... })
function MusicbrainzSDK:event(data)
  local EntityMod = require("entity.event_entity")
  if data == nil then
    if self._event == nil then
      self._event = EntityMod.new(self, nil)
    end
    return self._event
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:event() instead.
function MusicbrainzSDK:Event(data)
  local EntityMod = require("entity.event_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:genre():list() / client:genre():load({ id = ... })
function MusicbrainzSDK:genre(data)
  local EntityMod = require("entity.genre_entity")
  if data == nil then
    if self._genre == nil then
      self._genre = EntityMod.new(self, nil)
    end
    return self._genre
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:genre() instead.
function MusicbrainzSDK:Genre(data)
  local EntityMod = require("entity.genre_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:instrument():list() / client:instrument():load({ id = ... })
function MusicbrainzSDK:instrument(data)
  local EntityMod = require("entity.instrument_entity")
  if data == nil then
    if self._instrument == nil then
      self._instrument = EntityMod.new(self, nil)
    end
    return self._instrument
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:instrument() instead.
function MusicbrainzSDK:Instrument(data)
  local EntityMod = require("entity.instrument_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:label():list() / client:label():load({ id = ... })
function MusicbrainzSDK:label(data)
  local EntityMod = require("entity.label_entity")
  if data == nil then
    if self._label == nil then
      self._label = EntityMod.new(self, nil)
    end
    return self._label
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:label() instead.
function MusicbrainzSDK:Label(data)
  local EntityMod = require("entity.label_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:place():list() / client:place():load({ id = ... })
function MusicbrainzSDK:place(data)
  local EntityMod = require("entity.place_entity")
  if data == nil then
    if self._place == nil then
      self._place = EntityMod.new(self, nil)
    end
    return self._place
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:place() instead.
function MusicbrainzSDK:Place(data)
  local EntityMod = require("entity.place_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:rating():list() / client:rating():load({ id = ... })
function MusicbrainzSDK:rating(data)
  local EntityMod = require("entity.rating_entity")
  if data == nil then
    if self._rating == nil then
      self._rating = EntityMod.new(self, nil)
    end
    return self._rating
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:rating() instead.
function MusicbrainzSDK:Rating(data)
  local EntityMod = require("entity.rating_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:recording():list() / client:recording():load({ id = ... })
function MusicbrainzSDK:recording(data)
  local EntityMod = require("entity.recording_entity")
  if data == nil then
    if self._recording == nil then
      self._recording = EntityMod.new(self, nil)
    end
    return self._recording
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:recording() instead.
function MusicbrainzSDK:Recording(data)
  local EntityMod = require("entity.recording_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:recording_list():list() / client:recording_list():load({ id = ... })
function MusicbrainzSDK:recording_list(data)
  local EntityMod = require("entity.recording_list_entity")
  if data == nil then
    if self._recording_list == nil then
      self._recording_list = EntityMod.new(self, nil)
    end
    return self._recording_list
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:recording_list() instead.
function MusicbrainzSDK:RecordingList(data)
  local EntityMod = require("entity.recording_list_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:release():list() / client:release():load({ id = ... })
function MusicbrainzSDK:release(data)
  local EntityMod = require("entity.release_entity")
  if data == nil then
    if self._release == nil then
      self._release = EntityMod.new(self, nil)
    end
    return self._release
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:release() instead.
function MusicbrainzSDK:Release(data)
  local EntityMod = require("entity.release_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:release_group():list() / client:release_group():load({ id = ... })
function MusicbrainzSDK:release_group(data)
  local EntityMod = require("entity.release_group_entity")
  if data == nil then
    if self._release_group == nil then
      self._release_group = EntityMod.new(self, nil)
    end
    return self._release_group
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:release_group() instead.
function MusicbrainzSDK:ReleaseGroup(data)
  local EntityMod = require("entity.release_group_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:release_list():list() / client:release_list():load({ id = ... })
function MusicbrainzSDK:release_list(data)
  local EntityMod = require("entity.release_list_entity")
  if data == nil then
    if self._release_list == nil then
      self._release_list = EntityMod.new(self, nil)
    end
    return self._release_list
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:release_list() instead.
function MusicbrainzSDK:ReleaseList(data)
  local EntityMod = require("entity.release_list_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:series():list() / client:series():load({ id = ... })
function MusicbrainzSDK:series(data)
  local EntityMod = require("entity.series_entity")
  if data == nil then
    if self._series == nil then
      self._series = EntityMod.new(self, nil)
    end
    return self._series
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:series() instead.
function MusicbrainzSDK:Series(data)
  local EntityMod = require("entity.series_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:tag():list() / client:tag():load({ id = ... })
function MusicbrainzSDK:tag(data)
  local EntityMod = require("entity.tag_entity")
  if data == nil then
    if self._tag == nil then
      self._tag = EntityMod.new(self, nil)
    end
    return self._tag
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:tag() instead.
function MusicbrainzSDK:Tag(data)
  local EntityMod = require("entity.tag_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:url():list() / client:url():load({ id = ... })
function MusicbrainzSDK:url(data)
  local EntityMod = require("entity.url_entity")
  if data == nil then
    if self._url == nil then
      self._url = EntityMod.new(self, nil)
    end
    return self._url
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:url() instead.
function MusicbrainzSDK:Url(data)
  local EntityMod = require("entity.url_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:work():list() / client:work():load({ id = ... })
function MusicbrainzSDK:work(data)
  local EntityMod = require("entity.work_entity")
  if data == nil then
    if self._work == nil then
      self._work = EntityMod.new(self, nil)
    end
    return self._work
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:work() instead.
function MusicbrainzSDK:Work(data)
  local EntityMod = require("entity.work_entity")
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:work_list():list() / client:work_list():load({ id = ... })
function MusicbrainzSDK:work_list(data)
  local EntityMod = require("entity.work_list_entity")
  if data == nil then
    if self._work_list == nil then
      self._work_list = EntityMod.new(self, nil)
    end
    return self._work_list
  end
  return EntityMod.new(self, data)
end

-- Deprecated: use client:work_list() instead.
function MusicbrainzSDK:WorkList(data)
  local EntityMod = require("entity.work_list_entity")
  return EntityMod.new(self, data)
end




function MusicbrainzSDK.test(testopts, sdkopts)
  sdkopts = sdkopts or {}
  sdkopts = vs.clone(sdkopts)
  if type(sdkopts) ~= "table" then
    sdkopts = {}
  end

  testopts = testopts or {}
  testopts = vs.clone(testopts)
  if type(testopts) ~= "table" then
    testopts = {}
  end
  testopts["active"] = true

  vs.setpath(sdkopts, "feature.test", testopts)

  local sdk = MusicbrainzSDK.new(sdkopts)
  sdk.mode = "test"

  return sdk
end


return MusicbrainzSDK
