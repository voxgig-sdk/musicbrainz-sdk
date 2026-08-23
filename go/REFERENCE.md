# Musicbrainz Golang SDK Reference

Complete API reference for the Musicbrainz Golang SDK.


## MusicbrainzSDK

### Constructor

```go
func NewMusicbrainzSDK(options map[string]any) *MusicbrainzSDK
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `map[string]any` | SDK configuration options. |
| `options["apikey"]` | `string` | API key for authentication. |
| `options["base"]` | `string` | Base URL for API requests. |
| `options["prefix"]` | `string` | URL prefix appended after base. |
| `options["suffix"]` | `string` | URL suffix appended after path. |
| `options["headers"]` | `map[string]any` | Custom headers for all requests. |
| `options["feature"]` | `map[string]any` | Feature configuration. |
| `options["system"]` | `map[string]any` | System overrides (e.g. custom fetch). |


### Static Methods

#### `Test() *MusicbrainzSDK`

No-arg convenience constructor for the common no-options test case.

```go
client := sdk.Test()
```

#### `TestSDK(testopts, sdkopts map[string]any) *MusicbrainzSDK`

Test client with options. Both arguments may be `nil`.

```go
client := sdk.TestSDK(testopts, sdkopts)
```


### Instance Methods

#### `Area(data map[string]any) MusicbrainzEntity`

Create a new `Area` entity instance. Pass `nil` for no initial data.

#### `Artist(data map[string]any) MusicbrainzEntity`

Create a new `Artist` entity instance. Pass `nil` for no initial data.

#### `Collection(data map[string]any) MusicbrainzEntity`

Create a new `Collection` entity instance. Pass `nil` for no initial data.

#### `Event(data map[string]any) MusicbrainzEntity`

Create a new `Event` entity instance. Pass `nil` for no initial data.

#### `Genre(data map[string]any) MusicbrainzEntity`

Create a new `Genre` entity instance. Pass `nil` for no initial data.

#### `Instrument(data map[string]any) MusicbrainzEntity`

Create a new `Instrument` entity instance. Pass `nil` for no initial data.

#### `Label(data map[string]any) MusicbrainzEntity`

Create a new `Label` entity instance. Pass `nil` for no initial data.

#### `Place(data map[string]any) MusicbrainzEntity`

Create a new `Place` entity instance. Pass `nil` for no initial data.

#### `Rating(data map[string]any) MusicbrainzEntity`

Create a new `Rating` entity instance. Pass `nil` for no initial data.

#### `Recording(data map[string]any) MusicbrainzEntity`

Create a new `Recording` entity instance. Pass `nil` for no initial data.

#### `RecordingList(data map[string]any) MusicbrainzEntity`

Create a new `RecordingList` entity instance. Pass `nil` for no initial data.

#### `Release(data map[string]any) MusicbrainzEntity`

Create a new `Release` entity instance. Pass `nil` for no initial data.

#### `ReleaseGroup(data map[string]any) MusicbrainzEntity`

Create a new `ReleaseGroup` entity instance. Pass `nil` for no initial data.

#### `ReleaseList(data map[string]any) MusicbrainzEntity`

Create a new `ReleaseList` entity instance. Pass `nil` for no initial data.

#### `Series(data map[string]any) MusicbrainzEntity`

Create a new `Series` entity instance. Pass `nil` for no initial data.

#### `Tag(data map[string]any) MusicbrainzEntity`

Create a new `Tag` entity instance. Pass `nil` for no initial data.

#### `Url(data map[string]any) MusicbrainzEntity`

Create a new `Url` entity instance. Pass `nil` for no initial data.

#### `Work(data map[string]any) MusicbrainzEntity`

Create a new `Work` entity instance. Pass `nil` for no initial data.

#### `WorkList(data map[string]any) MusicbrainzEntity`

Create a new `WorkList` entity instance. Pass `nil` for no initial data.

#### `OptionsMap() map[string]any`

Return a deep copy of the current SDK options.

#### `GetUtility() *Utility`

Return a copy of the SDK utility object.

#### `Direct(fetchargs map[string]any) (map[string]any, error)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `map[string]any` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `map[string]any` | Query string parameters. |
| `fetchargs["headers"]` | `map[string]any` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (maps are JSON-serialized). |
| `fetchargs["ctrl"]` | `map[string]any` | Control options (e.g. `map[string]any{"explain": true}`). |

**Returns:** `(map[string]any, error)`

#### `Prepare(fetchargs map[string]any) (map[string]any, error)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `Direct()`.

**Returns:** `(map[string]any, error)`


---

## AreaEntity

```go
area := client.Area(nil)
fmt.Println(area.GetName()) // "area"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `begin` | `string` | No | Begin date |
| `disambiguation` | `string` | No | Disambiguation comment |
| `end` | `string` | No | End date |
| `ended` | `bool` | No | Whether the entity has ended |
| `id` | `string` | No | MusicBrainz ID |
| `lifespan` | `map[string]any` | No |  |
| `name` | `string` | No | Area name |
| `sortname` | `string` | No | Sort name |
| `type` | `string` | No | Area type |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Area(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Area(nil).Load(map[string]any{"id": "area_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `AreaEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ArtistEntity

```go
artist := client.Artist(nil)
fmt.Println(artist.GetName()) // "artist"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `begin` | `string` | No | Begin date |
| `country` | `string` | No | Country code |
| `disambiguation` | `string` | No | Disambiguation comment |
| `end` | `string` | No | End date |
| `ended` | `bool` | No | Whether the entity has ended |
| `gender` | `string` | No | Gender (for person type) |
| `id` | `string` | No | MusicBrainz ID |
| `lifespan` | `map[string]any` | No |  |
| `name` | `string` | No | Artist name |
| `sortname` | `string` | No | Sort name |
| `type` | `string` | No | Artist type (person, group, etc.) |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Artist(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Artist(nil).Load(map[string]any{"id": "artist_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ArtistEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## CollectionEntity

```go
collection := client.Collection(nil)
fmt.Println(collection.GetName()) // "collection"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `editor` | `string` | No |  |
| `entitytype` | `string` | No |  |
| `id` | `string` | No |  |
| `name` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Collection(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `CollectionEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## EventEntity

```go
event := client.Event(nil)
fmt.Println(event.GetName()) // "event"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `begin` | `string` | No | Begin date |
| `cancelled` | `bool` | No | Whether the event was cancelled |
| `disambiguation` | `string` | No | Disambiguation comment |
| `end` | `string` | No | End date |
| `ended` | `bool` | No | Whether the entity has ended |
| `id` | `string` | No | MusicBrainz ID |
| `lifespan` | `map[string]any` | No |  |
| `name` | `string` | No | Event name |
| `time` | `string` | No | Event time |
| `type` | `string` | No | Event type |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Event(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Event(nil).Load(map[string]any{"id": "event_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `EventEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## GenreEntity

```go
genre := client.Genre(nil)
fmt.Println(genre.GetName()) // "genre"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | `string` | No | Disambiguation comment |
| `id` | `string` | No | MusicBrainz ID |
| `name` | `string` | No | Genre name |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Genre(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Genre(nil).Load(map[string]any{"id": "genre_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `GenreEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## InstrumentEntity

```go
instrument := client.Instrument(nil)
fmt.Println(instrument.GetName()) // "instrument"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `description` | `string` | No | Instrument description |
| `disambiguation` | `string` | No | Disambiguation comment |
| `id` | `string` | No | MusicBrainz ID |
| `name` | `string` | No | Instrument name |
| `type` | `string` | No | Instrument type |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Instrument(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Instrument(nil).Load(map[string]any{"id": "instrument_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `InstrumentEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## LabelEntity

```go
label := client.Label(nil)
fmt.Println(label.GetName()) // "label"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `begin` | `string` | No | Begin date |
| `country` | `string` | No | Country code |
| `disambiguation` | `string` | No | Disambiguation comment |
| `end` | `string` | No | End date |
| `ended` | `bool` | No | Whether the entity has ended |
| `id` | `string` | No | MusicBrainz ID |
| `labelcode` | `int` | No | Label code |
| `lifespan` | `map[string]any` | No |  |
| `name` | `string` | No | Label name |
| `sortname` | `string` | No | Sort name |
| `type` | `string` | No | Label type |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Label(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Label(nil).Load(map[string]any{"id": "label_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `LabelEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## PlaceEntity

```go
place := client.Place(nil)
fmt.Println(place.GetName()) // "place"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | `string` | No | Place address |
| `coordinates` | `map[string]any` | No |  |
| `disambiguation` | `string` | No | Disambiguation comment |
| `id` | `string` | No | MusicBrainz ID |
| `lifespan` | `map[string]any` | No |  |
| `name` | `string` | No | Place name |
| `type` | `string` | No | Place type |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Place(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Place(nil).Load(map[string]any{"id": "place_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `PlaceEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## RatingEntity

```go
rating := client.Rating(nil)
fmt.Println(rating.GetName()) // "rating"
```

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Rating(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.Rating(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `RatingEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## RecordingEntity

```go
recording := client.Recording(nil)
fmt.Println(recording.GetName()) // "recording"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | `string` | No | Disambiguation comment |
| `id` | `string` | No | MusicBrainz ID |
| `length` | `int` | No | Duration in milliseconds |
| `title` | `string` | No | Recording title |
| `video` | `bool` | No | Whether this is a video recording |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Recording(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Recording(nil).Load(map[string]any{"id": "recording_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `RecordingEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## RecordingListEntity

```go
recordingList := client.RecordingList(nil)
fmt.Println(recordingList.GetName()) // "recording_list"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `count` | `int` | No |  |
| `offset` | `int` | No |  |
| `recordings` | `[]any` | No |  |

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.RecordingList(nil).Load(map[string]any{"isrc": "isrc"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `RecordingListEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ReleaseEntity

```go
release := client.Release(nil)
fmt.Println(release.GetName()) // "release"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `barcode` | `string` | No | Barcode |
| `country` | `string` | No | Release country |
| `date` | `string` | No | Release date |
| `disambiguation` | `string` | No | Disambiguation comment |
| `id` | `string` | No | MusicBrainz ID |
| `packaging` | `string` | No | Packaging type |
| `status` | `string` | No | Release status (official, promotion, bootleg, pseudo-release) |
| `title` | `string` | No | Release title |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Release(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Release(nil).Load(map[string]any{"id": "release_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ReleaseEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ReleaseGroupEntity

```go
releaseGroup := client.ReleaseGroup(nil)
fmt.Println(releaseGroup.GetName()) // "release_group"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | `string` | No | Disambiguation comment |
| `firstreleasedate` | `string` | No | Date of first release |
| `id` | `string` | No | MusicBrainz ID |
| `primarytype` | `string` | No | Primary type (album, single, ep, broadcast, other) |
| `secondarytypes` | `[]any` | No | Secondary types (compilation, soundtrack, etc.) |
| `title` | `string` | No | Release group title |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.ReleaseGroup(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.ReleaseGroup(nil).Load(map[string]any{"id": "release_group_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ReleaseGroupEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ReleaseListEntity

```go
releaseList := client.ReleaseList(nil)
fmt.Println(releaseList.GetName()) // "release_list"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `count` | `int` | No |  |
| `offset` | `int` | No |  |
| `releases` | `[]any` | No |  |

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.ReleaseList(nil).Load(map[string]any{"discid": "discid"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ReleaseListEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## SeriesEntity

```go
series := client.Series(nil)
fmt.Println(series.GetName()) // "series"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | `string` | No | Disambiguation comment |
| `id` | `string` | No | MusicBrainz ID |
| `name` | `string` | No | Series name |
| `type` | `string` | No | Series type |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Series(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Series(nil).Load(map[string]any{"id": "series_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `SeriesEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## TagEntity

```go
tag := client.Tag(nil)
fmt.Println(tag.GetName()) // "tag"
```

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Tag(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

#### `Create(reqdata, ctrl map[string]any) (any, error)`

Create a new entity with the given data.

```go
result, err := client.Tag(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `TagEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## UrlEntity

```go
url := client.Url(nil)
fmt.Println(url.GetName()) // "url"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No | MusicBrainz ID |
| `resource` | `string` | No | The URL resource |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Url(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Url(nil).Load(map[string]any{"id": "url_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `UrlEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## WorkEntity

```go
work := client.Work(nil)
fmt.Println(work.GetName()) // "work"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | `string` | No | Disambiguation comment |
| `id` | `string` | No | MusicBrainz ID |
| `language` | `string` | No | Language code |
| `title` | `string` | No | Work title |
| `type` | `string` | No | Work type |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Work(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Work(nil).Load(map[string]any{"id": "work_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `WorkEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## WorkListEntity

```go
workList := client.WorkList(nil)
fmt.Println(workList.GetName()) // "work_list"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `count` | `int` | No |  |
| `offset` | `int` | No |  |
| `works` | `[]any` | No |  |

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.WorkList(nil).Load(map[string]any{"iswc": "iswc"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `WorkListEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```go
client := sdk.NewMusicbrainzSDK(map[string]any{
    "feature": map[string]any{
        "test": map[string]any{"active": true},
    },
})
```

