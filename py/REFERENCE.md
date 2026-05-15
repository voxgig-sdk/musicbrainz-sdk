# Musicbrainz Python SDK Reference

Complete API reference for the Musicbrainz Python SDK.


## MusicbrainzSDK

### Constructor

```python
from musicbrainz_sdk import MusicbrainzSDK

client = MusicbrainzSDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["apikey"]` | `str` | API key for authentication. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `MusicbrainzSDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = MusicbrainzSDK.test()
```


### Instance Methods

#### `Area(data=None)`

Create a new `AreaEntity` instance. Pass `None` for no initial data.

#### `Artist(data=None)`

Create a new `ArtistEntity` instance. Pass `None` for no initial data.

#### `Collection(data=None)`

Create a new `CollectionEntity` instance. Pass `None` for no initial data.

#### `Event(data=None)`

Create a new `EventEntity` instance. Pass `None` for no initial data.

#### `Genre(data=None)`

Create a new `GenreEntity` instance. Pass `None` for no initial data.

#### `Instrument(data=None)`

Create a new `InstrumentEntity` instance. Pass `None` for no initial data.

#### `Label(data=None)`

Create a new `LabelEntity` instance. Pass `None` for no initial data.

#### `Place(data=None)`

Create a new `PlaceEntity` instance. Pass `None` for no initial data.

#### `Rating(data=None)`

Create a new `RatingEntity` instance. Pass `None` for no initial data.

#### `Recording(data=None)`

Create a new `RecordingEntity` instance. Pass `None` for no initial data.

#### `RecordingList(data=None)`

Create a new `RecordingListEntity` instance. Pass `None` for no initial data.

#### `Release(data=None)`

Create a new `ReleaseEntity` instance. Pass `None` for no initial data.

#### `ReleaseGroup(data=None)`

Create a new `ReleaseGroupEntity` instance. Pass `None` for no initial data.

#### `ReleaseList(data=None)`

Create a new `ReleaseListEntity` instance. Pass `None` for no initial data.

#### `Series(data=None)`

Create a new `SeriesEntity` instance. Pass `None` for no initial data.

#### `Tag(data=None)`

Create a new `TagEntity` instance. Pass `None` for no initial data.

#### `Url(data=None)`

Create a new `UrlEntity` instance. Pass `None` for no initial data.

#### `Work(data=None)`

Create a new `WorkEntity` instance. Pass `None` for no initial data.

#### `WorkList(data=None)`

Create a new `WorkListEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> tuple`

Make a direct HTTP request to any API endpoint. Returns `(result, err)`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `(result_dict, err)`

#### `prepare(fetchargs=None) -> tuple`

Prepare a fetch definition without sending. Returns `(fetchdef, err)`.


---

## AreaEntity

```python
area = client.Area()
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

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Area().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Area().load({"id": "area_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `AreaEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ArtistEntity

```python
artist = client.Artist()
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

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Artist().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Artist().load({"id": "artist_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ArtistEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## CollectionEntity

```python
collection = client.Collection()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `editor` | ``$STRING`` | No |  |
| `entity_type` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `name` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Collection().list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CollectionEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## EventEntity

```python
event = client.Event()
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

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Event().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Event().load({"id": "event_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `EventEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## GenreEntity

```python
genre = client.Genre()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `name` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Genre().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Genre().load({"id": "genre_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `GenreEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## InstrumentEntity

```python
instrument = client.Instrument()
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

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Instrument().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Instrument().load({"id": "instrument_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `InstrumentEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## LabelEntity

```python
label = client.Label()
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

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Label().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Label().load({"id": "label_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `LabelEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## PlaceEntity

```python
place = client.Place()
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

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Place().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Place().load({"id": "place_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `PlaceEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## RatingEntity

```python
rating = client.Rating()
```

### Operations

#### `create(reqdata, ctrl=None) -> tuple`

Create a new entity with the given data.

```python
result, err = client.Rating().create({
})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Rating().load({"id": "rating_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `RatingEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## RecordingEntity

```python
recording = client.Recording()
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

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Recording().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Recording().load({"id": "recording_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `RecordingEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## RecordingListEntity

```python
recording_list = client.RecordingList()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `count` | ``$INTEGER`` | No |  |
| `offset` | ``$INTEGER`` | No |  |
| `recording` | ``$ARRAY`` | No |  |

### Operations

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.RecordingList().load({"id": "recording_list_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `RecordingListEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ReleaseEntity

```python
release = client.Release()
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

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Release().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Release().load({"id": "release_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ReleaseEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ReleaseGroupEntity

```python
release_group = client.ReleaseGroup()
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

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.ReleaseGroup().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.ReleaseGroup().load({"id": "release_group_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ReleaseGroupEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ReleaseListEntity

```python
release_list = client.ReleaseList()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `count` | ``$INTEGER`` | No |  |
| `offset` | ``$INTEGER`` | No |  |
| `release` | ``$ARRAY`` | No |  |

### Operations

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.ReleaseList().load({"id": "release_list_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ReleaseListEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SeriesEntity

```python
series = client.Series()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | ``$STRING`` | No |  |
| `id` | ``$STRING`` | No |  |
| `name` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Series().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Series().load({"id": "series_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SeriesEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## TagEntity

```python
tag = client.Tag()
```

### Operations

#### `create(reqdata, ctrl=None) -> tuple`

Create a new entity with the given data.

```python
result, err = client.Tag().create({
})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Tag().load({"id": "tag_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `TagEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## UrlEntity

```python
url = client.Url()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | ``$STRING`` | No |  |
| `resource` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Url().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Url().load({"id": "url_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `UrlEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## WorkEntity

```python
work = client.Work()
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

#### `list(reqmatch, ctrl=None) -> tuple`

List entities matching the given criteria. Returns an array.

```python
results, err = client.Work().list({})
```

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.Work().load({"id": "work_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `WorkEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## WorkListEntity

```python
work_list = client.WorkList()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `count` | ``$INTEGER`` | No |  |
| `offset` | ``$INTEGER`` | No |  |
| `work` | ``$ARRAY`` | No |  |

### Operations

#### `load(reqmatch, ctrl=None) -> tuple`

Load a single entity matching the given criteria.

```python
result, err = client.WorkList().load({"id": "work_list_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `WorkListEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```python
client = MusicbrainzSDK({
    "feature": {
        "test": {"active": True},
    },
})
```

