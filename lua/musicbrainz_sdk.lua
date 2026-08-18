-- Musicbrainz SDK

local vs = require("utility.struct.struct")
local Utility = require("core.utility_type")
local Spec = require("core.spec")
local helpers = require("core.helpers")

-- Load utility registration (populates Utility._registrar)
require("utility.register")

-- Typed-model annotations (LuaLS ---@class); empty at runtime.
require("musicbrainz_types")

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

  local config = require("config_shared")()

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

  -- Add features in the resolved order (make_options puts an explicit list
  -- order first, else defaults to test-first). Ordering matters: the `test`
  -- feature installs the base mock transport and the transport features
  -- (retry/cache/netsim/proxy/ratelimit) wrap whatever is current, so `test`
  -- must be added before them to sit at the base of the chain.
  local feature_opts = helpers.to_map(vs.getprop(self.options, "feature"))
  if feature_opts ~= nil then
    local featureorder = vs.getpath(self.options, "__derived__.featureorder")
    if type(featureorder) == "table" then
      for _, fname in ipairs(featureorder) do
        local fopts = helpers.to_map(feature_opts[fname])
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

    -- feature: test


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


-- Raw endpoint access is operator-controllable, like every entity op.
-- Blocking it means denying BOTH the 'direct' and 'graphql' tokens, since
-- either one reaches the same endpoint.
function MusicbrainzSDK:direct(fetchargs)
  if not self:_op_allowed("direct") then
    return self:_op_denied("direct"), nil
  end

  return self:_raw_request(fetchargs)
end


-- Is this raw-access op permitted by the SDK's allow.op option?
function MusicbrainzSDK:_op_allowed(op)
  local allow = vs.getpath(self.options, "allow.op")
  return type(allow) == "string" and allow:find(op, 1, true) ~= nil
end


function MusicbrainzSDK:_op_denied(op)
  local allow = vs.getpath(self.options, "allow.op")
  if type(allow) ~= "string" then allow = "" end
  return {
    ok = false,
    err = "MusicbrainzSDK: " .. op .. ": operation not allowed by" ..
      " SDK option allow.op value: \"" .. allow .. "\"",
  }
end


-- Ungated request path shared by direct and graphql, each of which checks its
-- own allow.op token first. Private, rather than a flag on fetchargs: a
-- caller-supplied marker would let anyone opt straight back out of the gate
-- by passing it.
function MusicbrainzSDK:_raw_request(fetchargs)
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


-- Raw GraphQL access: the pressure valve that makes the generated surface's
-- deliberate omissions (per-call selection sets, typed filter builders,
-- batching, subscriptions) livable — the whole schema stays reachable.
--
-- Thin wrapper over the same prepare/fetch path direct uses, with the one
-- thing raw direct cannot do for GraphQL: a GraphQL failure rides HTTP 200 as
-- a top-level `errors` array, so status alone would report a failed query as
-- ok.
--
-- NOTE: like direct, this bypasses the feature pipeline — no retry, ratelimit
-- or paging features apply.
function MusicbrainzSDK:graphql(query, variables, ctrl)
  if not self:_op_allowed("graphql") then
    return self:_op_denied("graphql"), nil
  end

  local res, err = self:_raw_request({
    method = "POST",
    headers = { ["content-type"] = "application/json" },
    body = {
      query = query,
      variables = type(variables) == "table" and variables or {},
    },
    ctrl = type(ctrl) == "table" and ctrl or {},
  })

  if err ~= nil or type(res) ~= "table" then
    return res, err
  end

  -- Errors are read BEFORE any status check: a GraphQL parse or validation
  -- failure comes back as HTTP 400 carrying the standard { errors = {...} }
  -- body, and the raw path represents a non-2xx as ok=false with no err — so
  -- returning early on status would discard the server's own diagnostics,
  -- which are the only useful part of that response.
  local errors = vs.getpath(res, "data.errors")

  if type(errors) == "table" and 0 < #errors then
    local msg = vs.getprop(errors[1], "message")
    if type(msg) ~= "string" or msg == "" then
      msg = "graphql error"
    end
    res.ok = false
    res.err = "MusicbrainzSDK: graphql: " .. msg
    res.graphql = errors
  end

  return res, nil
end



-- Idiomatic facade: client:Area():list() / client:Area():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Area(data)
  local EntityMod = require("entity.area_entity")
  if data == nil then
    if self._area == nil then
      self._area = EntityMod.new(self, nil)
    end
    return self._area
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Artist():list() / client:Artist():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Artist(data)
  local EntityMod = require("entity.artist_entity")
  if data == nil then
    if self._artist == nil then
      self._artist = EntityMod.new(self, nil)
    end
    return self._artist
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Collection():list() / client:Collection():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Collection(data)
  local EntityMod = require("entity.collection_entity")
  if data == nil then
    if self._collection == nil then
      self._collection = EntityMod.new(self, nil)
    end
    return self._collection
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Event():list() / client:Event():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Event(data)
  local EntityMod = require("entity.event_entity")
  if data == nil then
    if self._event == nil then
      self._event = EntityMod.new(self, nil)
    end
    return self._event
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Genre():list() / client:Genre():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Genre(data)
  local EntityMod = require("entity.genre_entity")
  if data == nil then
    if self._genre == nil then
      self._genre = EntityMod.new(self, nil)
    end
    return self._genre
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Instrument():list() / client:Instrument():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Instrument(data)
  local EntityMod = require("entity.instrument_entity")
  if data == nil then
    if self._instrument == nil then
      self._instrument = EntityMod.new(self, nil)
    end
    return self._instrument
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Label():list() / client:Label():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Label(data)
  local EntityMod = require("entity.label_entity")
  if data == nil then
    if self._label == nil then
      self._label = EntityMod.new(self, nil)
    end
    return self._label
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Place():list() / client:Place():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Place(data)
  local EntityMod = require("entity.place_entity")
  if data == nil then
    if self._place == nil then
      self._place = EntityMod.new(self, nil)
    end
    return self._place
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Rating():list() / client:Rating():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Rating(data)
  local EntityMod = require("entity.rating_entity")
  if data == nil then
    if self._rating == nil then
      self._rating = EntityMod.new(self, nil)
    end
    return self._rating
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Recording():list() / client:Recording():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Recording(data)
  local EntityMod = require("entity.recording_entity")
  if data == nil then
    if self._recording == nil then
      self._recording = EntityMod.new(self, nil)
    end
    return self._recording
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:RecordingList():list() / client:RecordingList():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:RecordingList(data)
  local EntityMod = require("entity.recording_list_entity")
  if data == nil then
    if self._recording_list == nil then
      self._recording_list = EntityMod.new(self, nil)
    end
    return self._recording_list
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Release():list() / client:Release():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Release(data)
  local EntityMod = require("entity.release_entity")
  if data == nil then
    if self._release == nil then
      self._release = EntityMod.new(self, nil)
    end
    return self._release
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:ReleaseGroup():list() / client:ReleaseGroup():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:ReleaseGroup(data)
  local EntityMod = require("entity.release_group_entity")
  if data == nil then
    if self._release_group == nil then
      self._release_group = EntityMod.new(self, nil)
    end
    return self._release_group
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:ReleaseList():list() / client:ReleaseList():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:ReleaseList(data)
  local EntityMod = require("entity.release_list_entity")
  if data == nil then
    if self._release_list == nil then
      self._release_list = EntityMod.new(self, nil)
    end
    return self._release_list
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Series():list() / client:Series():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Series(data)
  local EntityMod = require("entity.series_entity")
  if data == nil then
    if self._series == nil then
      self._series = EntityMod.new(self, nil)
    end
    return self._series
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Tag():list() / client:Tag():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Tag(data)
  local EntityMod = require("entity.tag_entity")
  if data == nil then
    if self._tag == nil then
      self._tag = EntityMod.new(self, nil)
    end
    return self._tag
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Url():list() / client:Url():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Url(data)
  local EntityMod = require("entity.url_entity")
  if data == nil then
    if self._url == nil then
      self._url = EntityMod.new(self, nil)
    end
    return self._url
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:Work():list() / client:Work():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:Work(data)
  local EntityMod = require("entity.work_entity")
  if data == nil then
    if self._work == nil then
      self._work = EntityMod.new(self, nil)
    end
    return self._work
  end
  return EntityMod.new(self, data)
end


-- Idiomatic facade: client:WorkList():list() / client:WorkList():load({ id = ... })
-- Entity access is capitalised (PascalCase) for parity with the other SDKs.
function MusicbrainzSDK:WorkList(data)
  local EntityMod = require("entity.work_list_entity")
  if data == nil then
    if self._work_list == nil then
      self._work_list = EntityMod.new(self, nil)
    end
    return self._work_list
  end
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
