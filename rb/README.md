# Musicbrainz Ruby SDK



The Ruby SDK for the Musicbrainz API — an entity-oriented client using idiomatic Ruby conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Area` — with named operations (`list`/`load`/`create`) instead of raw URL paths and query strings. Working with resources and verbs keeps call sites self-describing and reduces cognitive load.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to RubyGems. Install it from the
GitHub release tag (`rb/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/musicbrainz-sdk/releases](https://github.com/voxgig-sdk/musicbrainz-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ruby
require_relative "Musicbrainz_sdk"

client = MusicbrainzSDK.new({
  "apikey" => ENV["MUSICBRAINZ_APIKEY"],
})
```

### 2. List area records

```ruby
begin
  # list returns an Array of Area records — iterate directly.
  areas = client.Area.list
  areas.each do |item|
    puts "#{item["id"]} #{item["begin"]}"
  end
rescue => err
  warn "list failed: #{err}"
end
```

### 3. Load a recordinglist

RecordingList is nested under isrc, so provide the `isrc`.

```ruby
begin
  # load returns the ENTITY — call data_get for the RecordingList record (raises on error).
  recordinglist = client.RecordingList.load({ "isrc" => "example_isrc" })
  puts recordinglist
rescue => err
  warn "load failed: #{err}"
end
```


## Error handling

Entity operations raise on failure, so rescue them:

```ruby
begin
  seriess = client.Series.list()
rescue => err
  warn "list failed: #{err}"
end
```

`direct` does **not** raise — it returns the result hash. Branch on
`ok`; on failure `status` holds the HTTP status (for error responses) and
`err` holds a transport error, so read both defensively:

```ruby
result = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example_id" },
})

warn "request failed: #{result["err"] || "HTTP #{result["status"]}"}" unless result["ok"]
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ruby
result = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})

if result["ok"]
  puts result["status"]  # 200
  puts result["data"]    # response body
else
  # On an HTTP error status there is no err (only a transport failure sets
  # it), so fall back to the status code.
  warn(result["err"] || "HTTP #{result["status"]}")
end
```

### Prepare a request without sending it

```ruby
begin
  fetchdef = client.prepare({
    "path" => "/api/resource/{id}",
    "method" => "DELETE",
    "params" => { "id" => "example" },
  })
  puts fetchdef["url"]
  puts fetchdef["method"]
  puts fetchdef["headers"]
rescue => err
  warn "prepare failed: #{err}"
end
```

### Use test mode

Create a mock client for unit testing — no server required. Seed fixture
data via the `entity` option so offline calls resolve without a live server:

```ruby
client = MusicbrainzSDK.test({
  "entity" => { "series" => { "test01" => { "id" => "test01" } } },
})

# Entity ops return the ENTITY (raises on error);
# call data_get for the mock record.
series = client.Series.list()
puts series
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```ruby
mock_fetch = ->(url, init) {
  return {
    "status" => 200,
    "statusText" => "OK",
    "headers" => {},
    "json" => ->() { { "id" => "mock01" } },
  }, nil
}

client = MusicbrainzSDK.new({
  "base" => "http://localhost:8080",
  "system" => {
    "fetch" => mock_fetch,
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
cd rb && ruby -Itest -e "Dir['test/*_test.rb'].each { |f| require_relative f }"
```


## Reference

### MusicbrainzSDK

```ruby
require_relative "Musicbrainz_sdk"
client = MusicbrainzSDK.new(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `String` | API key for authentication. |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Hash` | Feature activation flags. |
| `extend` | `Hash` | Additional Feature instances to load. |
| `system` | `Hash` | System overrides (e.g. custom `fetch` lambda). |

### test

```ruby
client = MusicbrainzSDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### MusicbrainzSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> Hash` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Hash` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> Hash` | Build and send an HTTP request. Returns a result hash (`result["ok"]`); does not raise. |
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
| `load` | `(reqmatch, ctrl) -> any` | Load a single entity by match criteria. Raises on error. |
| `list` | `(reqmatch = nil, ctrl) -> Array` | List entities matching the criteria (call with no argument to list all). Raises on error. |
| `create` | `(reqdata, ctrl) -> any` | Create a new entity. Raises on error. |
| `data_get` | `() -> Hash` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> Hash` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the result data directly. On failure they
raise a `MusicbrainzError` (a `StandardError` subclass), so wrap
calls in `begin`/`rescue` where you need to handle errors.

The `direct` escape hatch is the exception: it never raises and instead
returns a result `Hash` with these keys:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Boolean` | `true` if the HTTP status is 2xx. |
| `status` | `Integer` | HTTP status code. |
| `headers` | `Hash` | Response headers. |
| `data` | `any` | Parsed JSON response body. |
| `err` | `Error` | Present when `ok` is `false`. |

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

Create an instance: `area = client.Area`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `String` | Begin date |
| `disambiguation` | `String` | Disambiguation comment |
| `end` | `String` | End date |
| `ended` | `Boolean` | Whether the entity has ended |
| `id` | `String` | MusicBrainz ID |
| `lifespan` | `Hash` |  |
| `name` | `String` | Area name |
| `sortname` | `String` | Sort name |
| `type` | `String` | Area type |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Area record (raises on error).
area = client.Area.load({ "id" => "area_id" })
```

#### Example: List

```ruby
# list returns an Array of Area records (raises on error).
areas = client.Area.list
```


### Artist

Create an instance: `artist = client.Artist`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `String` | Begin date |
| `country` | `String` | Country code |
| `disambiguation` | `String` | Disambiguation comment |
| `end` | `String` | End date |
| `ended` | `Boolean` | Whether the entity has ended |
| `gender` | `String` | Gender (for person type) |
| `id` | `String` | MusicBrainz ID |
| `lifespan` | `Hash` |  |
| `name` | `String` | Artist name |
| `sortname` | `String` | Sort name |
| `type` | `String` | Artist type (person, group, etc.) |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Artist record (raises on error).
artist = client.Artist.load({ "id" => "artist_id" })
```

#### Example: List

```ruby
# list returns an Array of Artist records (raises on error).
artists = client.Artist.list
```


### Collection

Create an instance: `collection = client.Collection`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `editor` | `String` |  |
| `entitytype` | `String` |  |
| `id` | `String` |  |
| `name` | `String` |  |

#### Example: List

```ruby
# list returns an Array of Collection records (raises on error).
collections = client.Collection.list
```


### Event

Create an instance: `event = client.Event`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `String` | Begin date |
| `cancelled` | `Boolean` | Whether the event was cancelled |
| `disambiguation` | `String` | Disambiguation comment |
| `end` | `String` | End date |
| `ended` | `Boolean` | Whether the entity has ended |
| `id` | `String` | MusicBrainz ID |
| `lifespan` | `Hash` |  |
| `name` | `String` | Event name |
| `time` | `String` | Event time |
| `type` | `String` | Event type |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Event record (raises on error).
event = client.Event.load({ "id" => "event_id" })
```

#### Example: List

```ruby
# list returns an Array of Event records (raises on error).
events = client.Event.list
```


### Genre

Create an instance: `genre = client.Genre`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `String` | Disambiguation comment |
| `id` | `String` | MusicBrainz ID |
| `name` | `String` | Genre name |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Genre record (raises on error).
genre = client.Genre.load({ "id" => "genre_id" })
```

#### Example: List

```ruby
# list returns an Array of Genre records (raises on error).
genres = client.Genre.list
```


### Instrument

Create an instance: `instrument = client.Instrument`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `String` | Instrument description |
| `disambiguation` | `String` | Disambiguation comment |
| `id` | `String` | MusicBrainz ID |
| `name` | `String` | Instrument name |
| `type` | `String` | Instrument type |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Instrument record (raises on error).
instrument = client.Instrument.load({ "id" => "instrument_id" })
```

#### Example: List

```ruby
# list returns an Array of Instrument records (raises on error).
instruments = client.Instrument.list
```


### Label

Create an instance: `label = client.Label`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `String` | Begin date |
| `country` | `String` | Country code |
| `disambiguation` | `String` | Disambiguation comment |
| `end` | `String` | End date |
| `ended` | `Boolean` | Whether the entity has ended |
| `id` | `String` | MusicBrainz ID |
| `labelcode` | `Integer` | Label code |
| `lifespan` | `Hash` |  |
| `name` | `String` | Label name |
| `sortname` | `String` | Sort name |
| `type` | `String` | Label type |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Label record (raises on error).
label = client.Label.load({ "id" => "label_id" })
```

#### Example: List

```ruby
# list returns an Array of Label records (raises on error).
labels = client.Label.list
```


### Place

Create an instance: `place = client.Place`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `String` | Place address |
| `coordinates` | `Hash` |  |
| `disambiguation` | `String` | Disambiguation comment |
| `id` | `String` | MusicBrainz ID |
| `lifespan` | `Hash` |  |
| `name` | `String` | Place name |
| `type` | `String` | Place type |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Place record (raises on error).
place = client.Place.load({ "id" => "place_id" })
```

#### Example: List

```ruby
# list returns an Array of Place records (raises on error).
places = client.Place.list
```


### Rating

Create an instance: `rating = client.Rating`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Rating record (raises on error).
rating = client.Rating.load()
```

#### Example: Create

```ruby
rating = client.Rating.create({
})
```


### Recording

Create an instance: `recording = client.Recording`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `String` | Disambiguation comment |
| `id` | `String` | MusicBrainz ID |
| `length` | `Integer` | Duration in milliseconds |
| `title` | `String` | Recording title |
| `video` | `Boolean` | Whether this is a video recording |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Recording record (raises on error).
recording = client.Recording.load({ "id" => "recording_id" })
```

#### Example: List

```ruby
# list returns an Array of Recording records (raises on error).
recordings = client.Recording.list
```


### RecordingList

Create an instance: `recording_list = client.RecordingList`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `Integer` |  |
| `offset` | `Integer` |  |
| `recordings` | `Array` |  |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the RecordingList record (raises on error).
recording_list = client.RecordingList.load({ "isrc" => "isrc" })
```


### Release

Create an instance: `release = client.Release`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `barcode` | `String` | Barcode |
| `country` | `String` | Release country |
| `date` | `String` | Release date |
| `disambiguation` | `String` | Disambiguation comment |
| `id` | `String` | MusicBrainz ID |
| `packaging` | `String` | Packaging type |
| `status` | `String` | Release status (official, promotion, bootleg, pseudo-release) |
| `title` | `String` | Release title |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Release record (raises on error).
release = client.Release.load({ "id" => "release_id" })
```

#### Example: List

```ruby
# list returns an Array of Release records (raises on error).
releases = client.Release.list
```


### ReleaseGroup

Create an instance: `release_group = client.ReleaseGroup`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `String` | Disambiguation comment |
| `firstreleasedate` | `String` | Date of first release |
| `id` | `String` | MusicBrainz ID |
| `primarytype` | `String` | Primary type (album, single, ep, broadcast, other) |
| `secondarytypes` | `Array` | Secondary types (compilation, soundtrack, etc.) |
| `title` | `String` | Release group title |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the ReleaseGroup record (raises on error).
release_group = client.ReleaseGroup.load({ "id" => "release_group_id" })
```

#### Example: List

```ruby
# list returns an Array of ReleaseGroup records (raises on error).
release_groups = client.ReleaseGroup.list
```


### ReleaseList

Create an instance: `release_list = client.ReleaseList`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `Integer` |  |
| `offset` | `Integer` |  |
| `releases` | `Array` |  |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the ReleaseList record (raises on error).
release_list = client.ReleaseList.load({ "discid" => "discid" })
```


### Series

Create an instance: `series = client.Series`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `String` | Disambiguation comment |
| `id` | `String` | MusicBrainz ID |
| `name` | `String` | Series name |
| `type` | `String` | Series type |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Series record (raises on error).
series = client.Series.load({ "id" => "series_id" })
```

#### Example: List

```ruby
# list returns an Array of Series records (raises on error).
seriess = client.Series.list
```


### Tag

Create an instance: `tag = client.Tag`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Tag record (raises on error).
tag = client.Tag.load()
```

#### Example: Create

```ruby
tag = client.Tag.create({
})
```


### Url

Create an instance: `url = client.Url`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `String` | MusicBrainz ID |
| `resource` | `String` | The URL resource |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Url record (raises on error).
url = client.Url.load({ "id" => "url_id" })
```

#### Example: List

```ruby
# list returns an Array of Url records (raises on error).
urls = client.Url.list
```


### Work

Create an instance: `work = client.Work`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `String` | Disambiguation comment |
| `id` | `String` | MusicBrainz ID |
| `language` | `String` | Language code |
| `title` | `String` | Work title |
| `type` | `String` | Work type |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Work record (raises on error).
work = client.Work.load({ "id" => "work_id" })
```

#### Example: List

```ruby
# list returns an Array of Work records (raises on error).
works = client.Work.list
```


### WorkList

Create an instance: `work_list = client.WorkList`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `Integer` |  |
| `offset` | `Integer` |  |
| `works` | `Array` |  |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the WorkList record (raises on error).
work_list = client.WorkList.load({ "iswc" => "iswc" })
```

## Features

This SDK ships 1 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`test`](#test) | In-memory mock transport for testing without a live server |

### test

In-memory mock transport for testing without a live server.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.


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

Features are the extension mechanism. A feature is a Ruby class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as hashes

The Ruby SDK uses plain Ruby hashes throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `Helpers.to_map()` to safely validate that a value is a hash.

### Module structure

```
rb/
├── Musicbrainz_sdk.rb       -- Main SDK module
├── config.rb                  -- Configuration
├── features.rb                -- Feature factory
├── core/                      -- Core types and context
├── entity/                    -- Entity implementations
├── feature/                   -- Built-in features (Base, Test, Log)
├── utility/                   -- Utility functions and struct library
└── test/                      -- Test suites
```

The main module (`Musicbrainz_sdk`) exports the SDK class
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```ruby
series = client.Series
series.list()

# series.data_get now returns the series data from the last list
# series.match_get returns the last match criteria
```

Call `make` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
