package = "voxgig-sdk-musicbrainz"
version = "0.0-1"
source = {
  url = "git://github.com/voxgig-sdk/musicbrainz-sdk.git"
}
description = {
  summary = "Musicbrainz SDK for Lua",
  license = "MIT"
}
dependencies = {
  "lua >= 5.3",
  "dkjson >= 2.5",
  "dkjson >= 2.5",
}
build = {
  type = "builtin",
  modules = {
    ["musicbrainz_sdk"] = "musicbrainz_sdk.lua",
    ["config"] = "config.lua",
    ["features"] = "features.lua",
  }
}
