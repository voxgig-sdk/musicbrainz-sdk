# Musicbrainz Python SDK



The Python SDK for the Musicbrainz API — an entity-oriented client following Pythonic conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Area()` — each
carrying a small, uniform set of operations (`list`, `load`, `create`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to PyPI. Install it from the GitHub
release tag (`py/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/musicbrainz-sdk/releases)) or
from a source checkout:

```bash
pip install -e .
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```python
import os
from musicbrainz_sdk import MusicbrainzSDK

client = MusicbrainzSDK({
    "apikey": os.environ.get("MUSICBRAINZ_APIKEY"),
})
```

### 2. List area records

`list()` returns a `list` of records (each a `dict`) and raises on
error — iterate it directly.

```python
try:
    areas = client.Area().list()
    for area in areas:
        print(area)
except Exception as err:
    print(f"list failed: {err}")
```

### 3. Load a recordinglist

RecordingList is nested under isrc, so provide the `isrc`.
`load()` returns the ENTITY — call data_get() for the record — and raises on error.

```python
try:
    recordinglist = client.RecordingList().load({"isrc": "example_isrc"})
    print(recordinglist)
except Exception as err:
    print(f"load failed: {err}")
```


## Error handling

Entity operations raise on failure, so wrap them in `try` / `except`:

```python
try:
    seriess = client.Series().list()
    print(seriess)
except Exception as err:
    print(f"list failed: {err}")
```

`direct()` does **not** raise — it returns the result envelope. Branch
on `ok`; on failure `status` holds the HTTP status (for error responses)
and `err` holds a transport error, so read both defensively:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example_id"},
})

if not result["ok"]:
    print("request failed:", result.get("status"), result.get("err"))
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})

if result["ok"]:
    print(result["status"])  # 200
    print(result["data"])    # response body
else:
    # A non-2xx response carries status + data (the error body); a
    # transport-level failure carries err instead. Only one is present, so
    # read both with .get() rather than indexing a key that may be absent.
    print(result.get("status"), result.get("err"))
```

### Prepare a request without sending it

```python
# prepare() returns the fetch definition and raises on error.
fetchdef = client.prepare({
    "path": "/api/resource/{id}",
    "method": "DELETE",
    "params": {"id": "example"},
})

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```python
client = MusicbrainzSDK.test()

# Entity ops return the ENTITY and raises on error;
# call data_get() for the record.
series = client.Series().list()
# series contains the mock response record
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```python
def mock_fetch(url, init):
    return {
        "status": 200,
        "statusText": "OK",
        "headers": {},
        "json": lambda: {"id": "mock01"},
    }, None

client = MusicbrainzSDK({
    "base": "http://localhost:8080",
    "system": {
        "fetch": mock_fetch,
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
cd py && pytest test/
```


## Reference

### MusicbrainzSDK

```python
from musicbrainz_sdk import MusicbrainzSDK

client = MusicbrainzSDK(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `str` | API key for authentication. |
| `base` | `str` | Base URL of the API server. |
| `prefix` | `str` | URL path prefix prepended to all requests. |
| `suffix` | `str` | URL path suffix appended to all requests. |
| `feature` | `dict` | Feature activation flags. |
| `extend` | `list` | Additional Feature instances to load. |
| `system` | `dict` | System overrides (e.g. custom `fetch` function). |

### test

```python
client = MusicbrainzSDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `None`.

### MusicbrainzSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> dict` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> dict` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> dict` | Build and send an HTTP request. Returns a result dict (branch on `ok`). |
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
| `list` | `(reqmatch, ctrl) -> list` | List entities matching the criteria. Raises on error. |
| `create` | `(reqdata, ctrl) -> any` | Create a new entity. Raises on error. |
| `data_get` | `() -> dict` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> dict` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> str` | Return the entity name. |

### Result shape

Entity operations return the ENTITY (call data_get() for the record) (a `dict` for single-entity
ops, a `list` for `list`) and raise on error. Wrap calls in
`try`/`except` to handle failures.

The `direct()` escape hatch never raises — it returns a result `dict`
you branch on via `result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `True` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `dict` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `False` and `err` contains the error value.

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

Create an instance: `area = client.Area()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `str` | Begin date |
| `disambiguation` | `str` | Disambiguation comment |
| `end` | `str` | End date |
| `ended` | `bool` | Whether the entity has ended |
| `id` | `str` | MusicBrainz ID |
| `lifespan` | `dict` |  |
| `name` | `str` | Area name |
| `sortname` | `str` | Sort name |
| `type` | `str` | Area type |

#### Example: Load

```python
area = client.Area().load({"id": "area_id"})
```

#### Example: List

```python
areas = client.Area().list()
```


### Artist

Create an instance: `artist = client.Artist()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `str` | Begin date |
| `country` | `str` | Country code |
| `disambiguation` | `str` | Disambiguation comment |
| `end` | `str` | End date |
| `ended` | `bool` | Whether the entity has ended |
| `gender` | `str` | Gender (for person type) |
| `id` | `str` | MusicBrainz ID |
| `lifespan` | `dict` |  |
| `name` | `str` | Artist name |
| `sortname` | `str` | Sort name |
| `type` | `str` | Artist type (person, group, etc.) |

#### Example: Load

```python
artist = client.Artist().load({"id": "artist_id"})
```

#### Example: List

```python
artists = client.Artist().list()
```


### Collection

Create an instance: `collection = client.Collection()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `editor` | `str` |  |
| `entitytype` | `str` |  |
| `id` | `str` |  |
| `name` | `str` |  |

#### Example: List

```python
collections = client.Collection().list()
```


### Event

Create an instance: `event = client.Event()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `str` | Begin date |
| `cancelled` | `bool` | Whether the event was cancelled |
| `disambiguation` | `str` | Disambiguation comment |
| `end` | `str` | End date |
| `ended` | `bool` | Whether the entity has ended |
| `id` | `str` | MusicBrainz ID |
| `lifespan` | `dict` |  |
| `name` | `str` | Event name |
| `time` | `str` | Event time |
| `type` | `str` | Event type |

#### Example: Load

```python
event = client.Event().load({"id": "event_id"})
```

#### Example: List

```python
events = client.Event().list()
```


### Genre

Create an instance: `genre = client.Genre()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `str` | Disambiguation comment |
| `id` | `str` | MusicBrainz ID |
| `name` | `str` | Genre name |

#### Example: Load

```python
genre = client.Genre().load({"id": "genre_id"})
```

#### Example: List

```python
genres = client.Genre().list()
```


### Instrument

Create an instance: `instrument = client.Instrument()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `str` | Instrument description |
| `disambiguation` | `str` | Disambiguation comment |
| `id` | `str` | MusicBrainz ID |
| `name` | `str` | Instrument name |
| `type` | `str` | Instrument type |

#### Example: Load

```python
instrument = client.Instrument().load({"id": "instrument_id"})
```

#### Example: List

```python
instruments = client.Instrument().list()
```


### Label

Create an instance: `label = client.Label()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `str` | Begin date |
| `country` | `str` | Country code |
| `disambiguation` | `str` | Disambiguation comment |
| `end` | `str` | End date |
| `ended` | `bool` | Whether the entity has ended |
| `id` | `str` | MusicBrainz ID |
| `labelcode` | `int` | Label code |
| `lifespan` | `dict` |  |
| `name` | `str` | Label name |
| `sortname` | `str` | Sort name |
| `type` | `str` | Label type |

#### Example: Load

```python
label = client.Label().load({"id": "label_id"})
```

#### Example: List

```python
labels = client.Label().list()
```


### Place

Create an instance: `place = client.Place()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `str` | Place address |
| `coordinates` | `dict` |  |
| `disambiguation` | `str` | Disambiguation comment |
| `id` | `str` | MusicBrainz ID |
| `lifespan` | `dict` |  |
| `name` | `str` | Place name |
| `type` | `str` | Place type |

#### Example: Load

```python
place = client.Place().load({"id": "place_id"})
```

#### Example: List

```python
places = client.Place().list()
```


### Rating

Create an instance: `rating = client.Rating()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```python
rating = client.Rating().load()
```

#### Example: Create

```python
rating = client.Rating().create({
})
```


### Recording

Create an instance: `recording = client.Recording()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `str` | Disambiguation comment |
| `id` | `str` | MusicBrainz ID |
| `length` | `int` | Duration in milliseconds |
| `title` | `str` | Recording title |
| `video` | `bool` | Whether this is a video recording |

#### Example: Load

```python
recording = client.Recording().load({"id": "recording_id"})
```

#### Example: List

```python
recordings = client.Recording().list()
```


### RecordingList

Create an instance: `recording_list = client.RecordingList()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `int` |  |
| `offset` | `int` |  |
| `recordings` | `list` |  |

#### Example: Load

```python
recording_list = client.RecordingList().load({"isrc": "isrc"})
```


### Release

Create an instance: `release = client.Release()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `barcode` | `str` | Barcode |
| `country` | `str` | Release country |
| `date` | `str` | Release date |
| `disambiguation` | `str` | Disambiguation comment |
| `id` | `str` | MusicBrainz ID |
| `packaging` | `str` | Packaging type |
| `status` | `str` | Release status (official, promotion, bootleg, pseudo-release) |
| `title` | `str` | Release title |

#### Example: Load

```python
release = client.Release().load({"id": "release_id"})
```

#### Example: List

```python
releases = client.Release().list()
```


### ReleaseGroup

Create an instance: `release_group = client.ReleaseGroup()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `str` | Disambiguation comment |
| `firstreleasedate` | `str` | Date of first release |
| `id` | `str` | MusicBrainz ID |
| `primarytype` | `str` | Primary type (album, single, ep, broadcast, other) |
| `secondarytypes` | `list` | Secondary types (compilation, soundtrack, etc.) |
| `title` | `str` | Release group title |

#### Example: Load

```python
release_group = client.ReleaseGroup().load({"id": "release_group_id"})
```

#### Example: List

```python
release_groups = client.ReleaseGroup().list()
```


### ReleaseList

Create an instance: `release_list = client.ReleaseList()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `int` |  |
| `offset` | `int` |  |
| `releases` | `list` |  |

#### Example: Load

```python
release_list = client.ReleaseList().load({"discid": "discid"})
```


### Series

Create an instance: `series = client.Series()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `str` | Disambiguation comment |
| `id` | `str` | MusicBrainz ID |
| `name` | `str` | Series name |
| `type` | `str` | Series type |

#### Example: Load

```python
series = client.Series().load({"id": "series_id"})
```

#### Example: List

```python
seriess = client.Series().list()
```


### Tag

Create an instance: `tag = client.Tag()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```python
tag = client.Tag().load()
```

#### Example: Create

```python
tag = client.Tag().create({
})
```


### Url

Create an instance: `url = client.Url()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `str` | MusicBrainz ID |
| `resource` | `str` | The URL resource |

#### Example: Load

```python
url = client.Url().load({"id": "url_id"})
```

#### Example: List

```python
urls = client.Url().list()
```


### Work

Create an instance: `work = client.Work()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `str` | Disambiguation comment |
| `id` | `str` | MusicBrainz ID |
| `language` | `str` | Language code |
| `title` | `str` | Work title |
| `type` | `str` | Work type |

#### Example: Load

```python
work = client.Work().load({"id": "work_id"})
```

#### Example: List

```python
works = client.Work().list()
```


### WorkList

Create an instance: `work_list = client.WorkList()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `int` |  |
| `offset` | `int` |  |
| `works` | `list` |  |

#### Example: Load

```python
work_list = client.WorkList().load({"iswc": "iswc"})
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

Features are the extension mechanism. A feature is a Python class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as dicts

The Python SDK uses plain dicts throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a dict.

### Module structure

```
py/
├── musicbrainz_sdk.py         -- Main SDK module
├── config.py                    -- Configuration
├── features.py                  -- Feature factory
├── core/                        -- Core types and context
├── entity/                      -- Entity implementations
├── feature/                     -- Built-in features (Base, Test, Log)
├── utility/                     -- Utility functions and struct library
└── test/                        -- Test suites
```

The main module (`musicbrainz_sdk`) exports the SDK class.
Import entity or utility modules directly only when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```python
series = client.Series()
series.list()

# series.data_get() now returns the series data from the last list
# series.match_get() returns the last match criteria
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
