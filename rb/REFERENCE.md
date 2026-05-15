# Musicbrainz Ruby SDK Reference

Complete API reference for the Musicbrainz Ruby SDK.


## MusicbrainzSDK

### Constructor

```ruby
require_relative 'musicbrainz_sdk'

client = MusicbrainzSDK.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Hash` | SDK configuration options. |
| `options["apikey"]` | `String` | API key for authentication. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Hash` | Custom headers for all requests. |
| `options["feature"]` | `Hash` | Feature configuration. |
| `options["system"]` | `Hash` | System overrides (e.g. custom fetch). |


### Static Methods

#### `MusicbrainzSDK.test(testopts = nil, sdkopts = nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```ruby
client = MusicbrainzSDK.test
```


### Instance Methods

#### `Area(data = nil)`

Create a new `Area` entity instance. Pass `nil` for no initial data.

#### `Artist(data = nil)`

Create a new `Artist` entity instance. Pass `nil` for no initial data.

#### `Collection(data = nil)`

Create a new `Collection` entity instance. Pass `nil` for no initial data.

#### `Event(data = nil)`

Create a new `Event` entity instance. Pass `nil` for no initial data.

#### `Genre(data = nil)`

Create a new `Genre` entity instance. Pass `nil` for no initial data.

#### `Instrument(data = nil)`

Create a new `Instrument` entity instance. Pass `nil` for no initial data.

#### `Label(data = nil)`

Create a new `Label` entity instance. Pass `nil` for no initial data.

#### `Place(data = nil)`

Create a new `Place` entity instance. Pass `nil` for no initial data.

#### `Rating(data = nil)`

Create a new `Rating` entity instance. Pass `nil` for no initial data.

#### `Recording(data = nil)`

Create a new `Recording` entity instance. Pass `nil` for no initial data.

#### `RecordingList(data = nil)`

Create a new `RecordingList` entity instance. Pass `nil` for no initial data.

#### `Release(data = nil)`

Create a new `Release` entity instance. Pass `nil` for no initial data.

#### `ReleaseGroup(data = nil)`

Create a new `ReleaseGroup` entity instance. Pass `nil` for no initial data.

#### `ReleaseList(data = nil)`

Create a new `ReleaseList` entity instance. Pass `nil` for no initial data.

#### `Series(data = nil)`

Create a new `Series` entity instance. Pass `nil` for no initial data.

#### `Tag(data = nil)`

Create a new `Tag` entity instance. Pass `nil` for no initial data.

#### `Url(data = nil)`

Create a new `Url` entity instance. Pass `nil` for no initial data.

#### `Work(data = nil)`

Create a new `Work` entity instance. Pass `nil` for no initial data.

#### `WorkList(data = nil)`

Create a new `WorkList` entity instance. Pass `nil` for no initial data.

#### `options_map -> Hash`

Return a deep copy of the current SDK options.

#### `get_utility -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs = {}) -> Hash, err`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Hash` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `Hash` | Query string parameters. |
| `fetchargs["headers"]` | `Hash` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (hashes are JSON-serialized). |
| `fetchargs["ctrl"]` | `Hash` | Control options (e.g. `{ "explain" => true }`). |

**Returns:** `Hash, err`

#### `prepare(fetchargs = {}) -> Hash, err`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `Hash, err`


---

## AreaEntity

```ruby
area = client.Area
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `life_span` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `sort_name` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Area.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Area.load({ "id" => "area_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `AreaEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ArtistEntity

```ruby
artist = client.Artist
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country` | ``$STRING`` | No |  |
| `disambiguation` | ``$STRING`` | No |  |
| `gender` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `life_span` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `sort_name` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Artist.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Artist.load({ "id" => "artist_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ArtistEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## CollectionEntity

```ruby
collection = client.Collection
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `editor` | ``$STRING`` | No |  |
| `entity_type` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `name` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Collection.list(nil)
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `CollectionEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## EventEntity

```ruby
event = client.Event
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `cancelled` | ``$BOOLEAN`` | No |  |
| `disambiguation` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `life_span` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `time` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Event.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Event.load({ "id" => "event_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `EventEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## GenreEntity

```ruby
genre = client.Genre
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `name` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Genre.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Genre.load({ "id" => "genre_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `GenreEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## InstrumentEntity

```ruby
instrument = client.Instrument
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | ``$STRING`` | No |  |
| `disambiguation` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `name` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Instrument.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Instrument.load({ "id" => "instrument_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `InstrumentEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## LabelEntity

```ruby
label = client.Label
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country` | ``$STRING`` | No |  |
| `disambiguation` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `label_code` | ``$INTEGER`` | No |  |
| `life_span` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `sort_name` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Label.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Label.load({ "id" => "label_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `LabelEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## PlaceEntity

```ruby
place = client.Place
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | ``$STRING`` | No |  |
| `coordinate` | ``$OBJECT`` | No |  |
| `disambiguation` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `life_span` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Place.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Place.load({ "id" => "place_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `PlaceEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## RatingEntity

```ruby
rating = client.Rating
```

### Operations

#### `create(reqdata, ctrl = nil) -> result, err`

Create a new entity with the given data.

```ruby
result, err = client.Rating.create({
})
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Rating.load({ "id" => "rating_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `RatingEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## RecordingEntity

```ruby
recording = client.Recording
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `length` | ``$INTEGER`` | No |  |
| `title` | ``$STRING`` | No |  |
| `video` | ``$BOOLEAN`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Recording.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Recording.load({ "id" => "recording_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `RecordingEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## RecordingListEntity

```ruby
recording_list = client.RecordingList
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `count` | ``$INTEGER`` | No |  |
| `offset` | ``$INTEGER`` | No |  |
| `recording` | ``$ARRAY`` | No |  |

### Operations

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.RecordingList.load({ "id" => "recording_list_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `RecordingListEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ReleaseEntity

```ruby
release = client.Release
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `barcode` | ``$STRING`` | No |  |
| `country` | ``$STRING`` | No |  |
| `date` | ``$STRING`` | No |  |
| `disambiguation` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `packaging` | ``$STRING`` | No |  |
| `status` | ``$STRING`` | No |  |
| `title` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Release.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Release.load({ "id" => "release_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ReleaseEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ReleaseGroupEntity

```ruby
release_group = client.ReleaseGroup
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | ``$STRING`` | No |  |
| `first_release_date` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `primary_type` | ``$STRING`` | No |  |
| `secondary_type` | ``$ARRAY`` | No |  |
| `title` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.ReleaseGroup.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.ReleaseGroup.load({ "id" => "release_group_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ReleaseGroupEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ReleaseListEntity

```ruby
release_list = client.ReleaseList
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `count` | ``$INTEGER`` | No |  |
| `offset` | ``$INTEGER`` | No |  |
| `release` | ``$ARRAY`` | No |  |

### Operations

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.ReleaseList.load({ "id" => "release_list_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ReleaseListEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SeriesEntity

```ruby
series = client.Series
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `name` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Series.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Series.load({ "id" => "series_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SeriesEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## TagEntity

```ruby
tag = client.Tag
```

### Operations

#### `create(reqdata, ctrl = nil) -> result, err`

Create a new entity with the given data.

```ruby
result, err = client.Tag.create({
})
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Tag.load({ "id" => "tag_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `TagEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## UrlEntity

```ruby
url = client.Url
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | ``$STRING`` | No |  |
| `resource` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Url.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Url.load({ "id" => "url_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `UrlEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## WorkEntity

```ruby
work = client.Work
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `language` | ``$STRING`` | No |  |
| `title` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl = nil) -> result, err`

List entities matching the given criteria. Returns an array.

```ruby
results, err = client.Work.list(nil)
```

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.Work.load({ "id" => "work_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `WorkEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## WorkListEntity

```ruby
work_list = client.WorkList
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `count` | ``$INTEGER`` | No |  |
| `offset` | ``$INTEGER`` | No |  |
| `work` | ``$ARRAY`` | No |  |

### Operations

#### `load(reqmatch, ctrl = nil) -> result, err`

Load a single entity matching the given criteria.

```ruby
result, err = client.WorkList.load({ "id" => "work_list_id" })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `WorkListEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ruby
client = MusicbrainzSDK.new({
  "feature" => {
    "test" => { "active" => true },
  },
})
```

