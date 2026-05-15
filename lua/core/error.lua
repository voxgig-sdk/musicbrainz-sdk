-- Musicbrainz SDK error

local MusicbrainzError = {}
MusicbrainzError.__index = MusicbrainzError


function MusicbrainzError.new(code, msg, ctx)
  local self = setmetatable({}, MusicbrainzError)
  self.is_sdk_error = true
  self.sdk = "Musicbrainz"
  self.code = code or ""
  self.msg = msg or ""
  self.ctx = ctx
  self.result = nil
  self.spec = nil
  return self
end


function MusicbrainzError:error()
  return self.msg
end


function MusicbrainzError:__tostring()
  return self.msg
end


return MusicbrainzError
