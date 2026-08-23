# Musicbrainz Lua SDK



The Lua SDK for the Musicbrainz API — an entity-oriented client using Lua conventions.

It exposes the API as capitalised, semantic **Entities** — e.g. `client:Area()` — each with the same small set of operations (`list`, `load`, `create`) instead of raw URL paths and query strings. You call meaning, not endpoints, which keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to LuaRocks. Install it from the
GitHub release tag (`lua/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/musicbrainz-sdk/releases)),
or add the source directory to your `LUA_PATH`:

```bash
export LUA_PATH="path/to/lua/?.lua;path/to/lua/?/init.lua;;"
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```lua
local sdk = require("musicbrainz_sdk")

local client = sdk.new({
  apikey = os.getenv("MUSICBRAINZ_APIKEY"),
})
```

### 2. List area records

Entity operations return `(value, err)`. For `list`, `value` is the
array of records itself — iterate it directly (there is no wrapper).

```lua
local areas, err = client:Area():list()
if err then error(err) end

for _, item in ipairs(areas) do
  print(item["id"], item["begin"])
end
```

### 3. Load a recordinglist

RecordingList is nested under isrc, so provide the `isrc`.

```lua
local recordinglist, err = client:RecordingList():load({ isrc = "example_isrc" })
if err then error(err) end
print(recordinglist)
```


## Error handling

Entity operations return `(value, err)`. Check `err` before using
the value:

```lua
local seriess, err = client:Series():list()
if err then error(err) end
```

`direct` follows the same `(value, err)` convention:

```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example_id" },
})
if err then error(err) end
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
if err then error(err) end

if result["ok"] then
  print(result["status"])  -- 200
  print(result["data"])    -- response body
end
```

### Prepare a request without sending it

```lua
local fetchdef, err = client:prepare({
  path = "/api/resource/{id}",
  method = "DELETE",
  params = { id = "example" },
})
if err then error(err) end

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```lua
local client = sdk.test()

local result, err = client:Series():list()
-- result is the returned data; err is set on failure
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```lua
local function mock_fetch(url, init)
  return {
    status = 200,
    statusText = "OK",
    headers = {},
    json = function()
      return { id = "mock01" }
    end,
  }, nil
end

local client = sdk.new({
  base = "http://localhost:8080",
  system = {
    fetch = mock_fetch,
  },
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
MUSICBRAINZ_TEST_LIVE=TRUE
MUSICBRAINZ_APIKEY=<your-key>
```

Then run:

```bash
cd lua && busted test/
```


## Reference

### MusicbrainzSDK

```lua
local sdk = require("musicbrainz_sdk")
local client = sdk.new(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `table` | Feature activation flags. |
| `extend` | `table` | Additional Feature instances to load. |
| `system` | `table` | System overrides (e.g. custom `fetch` function). |

### test

```lua
local client = sdk.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### MusicbrainzSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> table` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> table, err` | Build an HTTP request definition without sending. |
| `direct` | `(fetchargs) -> table, err` | Build and send an HTTP request. |
| `Area` | `(data) -> AreaEntity` | Create an Area entity instance. |
| `Artist` | `(data) -> ArtistEntity` | Create an Artist entity instance. |
| `Collection` | `(data) -> CollectionEntity` | Create a Collection entity instance. |
| `Event` | `(data) -> EventEntity` | Create an Event entity instance. |
| `Genre` | `(data) -> GenreEntity` | Create a Genre entity instance. |
| `Instrument` | `(data) -> InstrumentEntity` | Create an Instrument entity instance. |
| `Label` | `(data) -> LabelEntity` | Create a Label entity instance. |
| `Place` | `(data) -> PlaceEntity` | Create a Place entity instance. |
| `Rating` | `(data) -> RatingEntity` | Create a Rating entity instance. |
| `Recording` | `(data) -> RecordingEntity` | Create a Recording entity instance. |
| `RecordingList` | `(data) -> RecordingListEntity` | Create a RecordingList entity instance. |
| `Release` | `(data) -> ReleaseEntity` | Create a Release entity instance. |
| `ReleaseGroup` | `(data) -> ReleaseGroupEntity` | Create a ReleaseGroup entity instance. |
| `ReleaseList` | `(data) -> ReleaseListEntity` | Create a ReleaseList entity instance. |
| `Series` | `(data) -> SeriesEntity` | Create a Series entity instance. |
| `Tag` | `(data) -> TagEntity` | Create a Tag entity instance. |
| `Url` | `(data) -> UrlEntity` | Create an Url entity instance. |
| `Work` | `(data) -> WorkEntity` | Create a Work entity instance. |
| `WorkList` | `(data) -> WorkListEntity` | Create a WorkList entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> any, err` | Load a single entity by match criteria. |
| `list` | `(reqmatch, ctrl) -> any, err` | List entities matching the criteria. |
| `create` | `(reqdata, ctrl) -> any, err` | Create a new entity. |
| `data_get` | `() -> table` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> table` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> string` | Return the entity name. |

### Result shape

Entity operations return `(value, err)`. The `value` is the operation's
data **directly** — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `load` / `create` | the entity record (a `table`) |
| `list` | an array (`table`) of entity records |

Check `err` first (it is non-`nil` on failure), then use `value`:

    local area, err = client:Area():load({ id = "example_id" })
    if err then error(err) end
    -- area is the loaded record

Only `direct()` returns a response envelope — a `table` with `ok`,
`status`, `headers`, and `data` keys.

### Entities

#### Area

| Field | Description |
| --- | --- |
| `begin` | Begin date |
| `disambiguation` | Disambiguation comment |
| `end` | End date |
| `ended` | Whether the entity has ended |
| `id` | MusicBrainz ID |
| `lifespan` |  |
| `name` | Area name |
| `sortname` | Sort name |
| `type` | Area type |

Operations: List, Load.

API path: `/area`

#### Artist

| Field | Description |
| --- | --- |
| `begin` | Begin date |
| `country` | Country code |
| `disambiguation` | Disambiguation comment |
| `end` | End date |
| `ended` | Whether the entity has ended |
| `gender` | Gender (for person type) |
| `id` | MusicBrainz ID |
| `lifespan` |  |
| `name` | Artist name |
| `sortname` | Sort name |
| `type` | Artist type (person, group, etc.) |

Operations: List, Load.

API path: `/artist`

#### Collection

| Field | Description |
| --- | --- |
| `editor` |  |
| `entitytype` |  |
| `id` |  |
| `name` |  |

Operations: List.

API path: `/collection`

#### Event

| Field | Description |
| --- | --- |
| `begin` | Begin date |
| `cancelled` | Whether the event was cancelled |
| `disambiguation` | Disambiguation comment |
| `end` | End date |
| `ended` | Whether the entity has ended |
| `id` | MusicBrainz ID |
| `lifespan` |  |
| `name` | Event name |
| `time` | Event time |
| `type` | Event type |

Operations: List, Load.

API path: `/event`

#### Genre

| Field | Description |
| --- | --- |
| `disambiguation` | Disambiguation comment |
| `id` | MusicBrainz ID |
| `name` | Genre name |

Operations: List, Load.

API path: `/genre/all`

#### Instrument

| Field | Description |
| --- | --- |
| `description` | Instrument description |
| `disambiguation` | Disambiguation comment |
| `id` | MusicBrainz ID |
| `name` | Instrument name |
| `type` | Instrument type |

Operations: List, Load.

API path: `/instrument`

#### Label

| Field | Description |
| --- | --- |
| `begin` | Begin date |
| `country` | Country code |
| `disambiguation` | Disambiguation comment |
| `end` | End date |
| `ended` | Whether the entity has ended |
| `id` | MusicBrainz ID |
| `labelcode` | Label code |
| `lifespan` |  |
| `name` | Label name |
| `sortname` | Sort name |
| `type` | Label type |

Operations: List, Load.

API path: `/label`

#### Place

| Field | Description |
| --- | --- |
| `address` | Place address |
| `coordinates` |  |
| `disambiguation` | Disambiguation comment |
| `id` | MusicBrainz ID |
| `lifespan` |  |
| `name` | Place name |
| `type` | Place type |

Operations: List, Load.

API path: `/place`

#### Rating

| Field | Description |
| --- | --- |

Operations: Create, Load.

API path: `/rating`

#### Recording

| Field | Description |
| --- | --- |
| `disambiguation` | Disambiguation comment |
| `id` | MusicBrainz ID |
| `length` | Duration in milliseconds |
| `title` | Recording title |
| `video` | Whether this is a video recording |

Operations: List, Load.

API path: `/recording`

#### RecordingList

| Field | Description |
| --- | --- |
| `count` |  |
| `offset` |  |
| `recordings` |  |

Operations: Load.

API path: `/isrc/{isrc}`

#### Release

| Field | Description |
| --- | --- |
| `barcode` | Barcode |
| `country` | Release country |
| `date` | Release date |
| `disambiguation` | Disambiguation comment |
| `id` | MusicBrainz ID |
| `packaging` | Packaging type |
| `status` | Release status (official, promotion, bootleg, pseudo-release) |
| `title` | Release title |

Operations: List, Load.

API path: `/release`

#### ReleaseGroup

| Field | Description |
| --- | --- |
| `disambiguation` | Disambiguation comment |
| `firstreleasedate` | Date of first release |
| `id` | MusicBrainz ID |
| `primarytype` | Primary type (album, single, ep, broadcast, other) |
| `secondarytypes` | Secondary types (compilation, soundtrack, etc.) |
| `title` | Release group title |

Operations: List, Load.

API path: `/release-group`

#### ReleaseList

| Field | Description |
| --- | --- |
| `count` |  |
| `offset` |  |
| `releases` |  |

Operations: Load.

API path: `/discid/{discid}`

#### Series

| Field | Description |
| --- | --- |
| `disambiguation` | Disambiguation comment |
| `id` | MusicBrainz ID |
| `name` | Series name |
| `type` | Series type |

Operations: List, Load.

API path: `/series`

#### Tag

| Field | Description |
| --- | --- |

Operations: Create, Load.

API path: `/tag`

#### Url

| Field | Description |
| --- | --- |
| `id` | MusicBrainz ID |
| `resource` | The URL resource |

Operations: List, Load.

API path: `/url`

#### Work

| Field | Description |
| --- | --- |
| `disambiguation` | Disambiguation comment |
| `id` | MusicBrainz ID |
| `language` | Language code |
| `title` | Work title |
| `type` | Work type |

Operations: List, Load.

API path: `/work`

#### WorkList

| Field | Description |
| --- | --- |
| `count` |  |
| `offset` |  |
| `works` |  |

Operations: Load.

API path: `/iswc/{iswc}`



## Entities


### Area

Create an instance: `local area = client:Area(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `string` | Begin date |
| `disambiguation` | `string` | Disambiguation comment |
| `end` | `string` | End date |
| `ended` | `boolean` | Whether the entity has ended |
| `id` | `string` | MusicBrainz ID |
| `lifespan` | `table` |  |
| `name` | `string` | Area name |
| `sortname` | `string` | Sort name |
| `type` | `string` | Area type |

#### Example: Load

```lua
local area, err = client:Area():load({ id = "area_id" })
```

#### Example: List

```lua
local areas, err = client:Area():list()
```


### Artist

Create an instance: `local artist = client:Artist(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `string` | Begin date |
| `country` | `string` | Country code |
| `disambiguation` | `string` | Disambiguation comment |
| `end` | `string` | End date |
| `ended` | `boolean` | Whether the entity has ended |
| `gender` | `string` | Gender (for person type) |
| `id` | `string` | MusicBrainz ID |
| `lifespan` | `table` |  |
| `name` | `string` | Artist name |
| `sortname` | `string` | Sort name |
| `type` | `string` | Artist type (person, group, etc.) |

#### Example: Load

```lua
local artist, err = client:Artist():load({ id = "artist_id" })
```

#### Example: List

```lua
local artists, err = client:Artist():list()
```


### Collection

Create an instance: `local collection = client:Collection(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `editor` | `string` |  |
| `entitytype` | `string` |  |
| `id` | `string` |  |
| `name` | `string` |  |

#### Example: List

```lua
local collections, err = client:Collection():list()
```


### Event

Create an instance: `local event = client:Event(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `string` | Begin date |
| `cancelled` | `boolean` | Whether the event was cancelled |
| `disambiguation` | `string` | Disambiguation comment |
| `end` | `string` | End date |
| `ended` | `boolean` | Whether the entity has ended |
| `id` | `string` | MusicBrainz ID |
| `lifespan` | `table` |  |
| `name` | `string` | Event name |
| `time` | `string` | Event time |
| `type` | `string` | Event type |

#### Example: Load

```lua
local event, err = client:Event():load({ id = "event_id" })
```

#### Example: List

```lua
local events, err = client:Event():list()
```


### Genre

Create an instance: `local genre = client:Genre(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `name` | `string` | Genre name |

#### Example: Load

```lua
local genre, err = client:Genre():load({ id = "genre_id" })
```

#### Example: List

```lua
local genres, err = client:Genre():list()
```


### Instrument

Create an instance: `local instrument = client:Instrument(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `string` | Instrument description |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `name` | `string` | Instrument name |
| `type` | `string` | Instrument type |

#### Example: Load

```lua
local instrument, err = client:Instrument():load({ id = "instrument_id" })
```

#### Example: List

```lua
local instruments, err = client:Instrument():list()
```


### Label

Create an instance: `local label = client:Label(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `string` | Begin date |
| `country` | `string` | Country code |
| `disambiguation` | `string` | Disambiguation comment |
| `end` | `string` | End date |
| `ended` | `boolean` | Whether the entity has ended |
| `id` | `string` | MusicBrainz ID |
| `labelcode` | `number` | Label code |
| `lifespan` | `table` |  |
| `name` | `string` | Label name |
| `sortname` | `string` | Sort name |
| `type` | `string` | Label type |

#### Example: Load

```lua
local label, err = client:Label():load({ id = "label_id" })
```

#### Example: List

```lua
local labels, err = client:Label():list()
```


### Place

Create an instance: `local place = client:Place(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `string` | Place address |
| `coordinates` | `table` |  |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `lifespan` | `table` |  |
| `name` | `string` | Place name |
| `type` | `string` | Place type |

#### Example: Load

```lua
local place, err = client:Place():load({ id = "place_id" })
```

#### Example: List

```lua
local places, err = client:Place():list()
```


### Rating

Create an instance: `local rating = client:Rating(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```lua
local rating, err = client:Rating():load()
```

#### Example: Create

```lua
local rating, err = client:Rating():create({
})
```


### Recording

Create an instance: `local recording = client:Recording(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `length` | `number` | Duration in milliseconds |
| `title` | `string` | Recording title |
| `video` | `boolean` | Whether this is a video recording |

#### Example: Load

```lua
local recording, err = client:Recording():load({ id = "recording_id" })
```

#### Example: List

```lua
local recordings, err = client:Recording():list()
```


### RecordingList

Create an instance: `local recording_list = client:RecordingList(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `number` |  |
| `offset` | `number` |  |
| `recordings` | `table` |  |

#### Example: Load

```lua
local recording_list, err = client:RecordingList():load({ isrc = "isrc" })
```


### Release

Create an instance: `local release = client:Release(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `barcode` | `string` | Barcode |
| `country` | `string` | Release country |
| `date` | `string` | Release date |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `packaging` | `string` | Packaging type |
| `status` | `string` | Release status (official, promotion, bootleg, pseudo-release) |
| `title` | `string` | Release title |

#### Example: Load

```lua
local release, err = client:Release():load({ id = "release_id" })
```

#### Example: List

```lua
local releases, err = client:Release():list()
```


### ReleaseGroup

Create an instance: `local release_group = client:ReleaseGroup(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` | Disambiguation comment |
| `firstreleasedate` | `string` | Date of first release |
| `id` | `string` | MusicBrainz ID |
| `primarytype` | `string` | Primary type (album, single, ep, broadcast, other) |
| `secondarytypes` | `table` | Secondary types (compilation, soundtrack, etc.) |
| `title` | `string` | Release group title |

#### Example: Load

```lua
local release_group, err = client:ReleaseGroup():load({ id = "release_group_id" })
```

#### Example: List

```lua
local release_groups, err = client:ReleaseGroup():list()
```


### ReleaseList

Create an instance: `local release_list = client:ReleaseList(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `number` |  |
| `offset` | `number` |  |
| `releases` | `table` |  |

#### Example: Load

```lua
local release_list, err = client:ReleaseList():load({ discid = "discid" })
```


### Series

Create an instance: `local series = client:Series(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `name` | `string` | Series name |
| `type` | `string` | Series type |

#### Example: Load

```lua
local series, err = client:Series():load({ id = "series_id" })
```

#### Example: List

```lua
local seriess, err = client:Series():list()
```


### Tag

Create an instance: `local tag = client:Tag(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```lua
local tag, err = client:Tag():load()
```

#### Example: Create

```lua
local tag, err = client:Tag():create({
})
```


### Url

Create an instance: `local url = client:Url(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` | MusicBrainz ID |
| `resource` | `string` | The URL resource |

#### Example: Load

```lua
local url, err = client:Url():load({ id = "url_id" })
```

#### Example: List

```lua
local urls, err = client:Url():list()
```


### Work

Create an instance: `local work = client:Work(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `language` | `string` | Language code |
| `title` | `string` | Work title |
| `type` | `string` | Work type |

#### Example: Load

```lua
local work, err = client:Work():load({ id = "work_id" })
```

#### Example: List

```lua
local works, err = client:Work():list()
```


### WorkList

Create an instance: `local work_list = client:WorkList(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `number` |  |
| `offset` | `number` |  |
| `works` | `table` |  |

#### Example: Load

```lua
local work_list, err = client:WorkList():load({ iswc = "iswc" })
```


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is a Lua table
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as tables

The Lua SDK uses plain Lua tables throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a table.

### Module structure

```
lua/
├── musicbrainz_sdk.lua    -- Main SDK module
├── config.lua               -- Configuration
├── features.lua             -- Feature factory
├── core/                    -- Core types and context
├── entity/                  -- Entity implementations
├── feature/                 -- Built-in features (Base, Test, Log)
├── utility/                 -- Utility functions and struct library
└── test/                    -- Test suites
```

The main module (`musicbrainz_sdk`) exports the SDK constructor
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```lua
local series = client:Series()
series:list()

-- series:data_get() now returns the series data from the last list
-- series:match_get() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
