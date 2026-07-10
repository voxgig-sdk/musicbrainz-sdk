# Musicbrainz PHP SDK



The PHP SDK for the Musicbrainz API — an entity-oriented client using PHP conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `$client->Area()` — with named operations (`list`/`load`/`create`) instead of raw URL paths and query strings. Working with resources and verbs keeps call sites self-describing and reduces cognitive load.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Packagist. Install it from the
GitHub release tag (`php/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/musicbrainz-sdk/releases](https://github.com/voxgig-sdk/musicbrainz-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```php
<?php
require_once 'musicbrainz_sdk.php';

$client = new MusicbrainzSDK([
    "apikey" => getenv("MUSICBRAINZ_APIKEY"),
]);
```

### 2. List area records

```php
try {
    // list() returns an array of Area records — iterate directly.
    $areas = $client->Area()->list();
    foreach ($areas as $item) {
        echo $item["id"] . " " . $item["disambiguation"] . "\n";
    }
} catch (\Throwable $err) {
    echo "Error: " . $err->getMessage();
}
```

### 3. Load a recordinglist

RecordingList is nested under isrc, so provide the `isrc`.

```php
try {
    // load() returns the bare RecordingList record (throws on error).
    $recordinglist = $client->RecordingList()->load(["isrc" => "example_isrc"]);
    print_r($recordinglist);
} catch (\Throwable $err) {
    echo "Error: " . $err->getMessage();
}
```


## Error handling

Entity operations throw a `\Throwable` on failure, so wrap them in
`try` / `catch`:

```php
try {
    $areas = $client->Area()->list();
} catch (\Throwable $err) {
    echo "Error: " . $err->getMessage();
}
```

`direct()` does **not** throw — it returns the result array. Branch on
`ok`; on failure `status` holds the HTTP status (for error responses) and
`err` holds a transport error, so read both defensively:

```php
$result = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example_id"],
]);

if (! $result["ok"]) {
    $err = $result["err"] ?? null;
    echo "request failed: " . ($err ? $err->getMessage() : "HTTP " . $result["status"]);
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```php
// direct() is the raw-HTTP escape hatch: it returns a result array
// (it does not throw). Branch on $result["ok"].
$result = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);

if ($result["ok"]) {
    echo $result["status"];  // 200
    print_r($result["data"]);  // response body
} else {
    // On an HTTP error status there is no err (only a transport failure sets
    // it), so fall back to the status code.
    $err = $result["err"] ?? null;
    echo "Error: " . ($err ? $err->getMessage() : "HTTP " . $result["status"]);
}
```

### Prepare a request without sending it

```php
// prepare() throws on error and returns the fetch definition.
$fetchdef = $client->prepare([
    "path" => "/api/resource/{id}",
    "method" => "DELETE",
    "params" => ["id" => "example"],
]);

echo $fetchdef["url"];
echo $fetchdef["method"];
print_r($fetchdef["headers"]);
```

### Use test mode

Create a mock client for unit testing — no server required. Seed fixture
data via the `entity` option so offline calls resolve without a live server:

```php
$client = MusicbrainzSDK::test([
    "entity" => ["area" => ["test01" => ["id" => "test01"]]],
]);

// Entity ops return the bare mock record (throws on error).
$area = $client->Area()->list();
print_r($area);
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```php
$mock_fetch = function ($url, $init) {
    return [
        [
            "status" => 200,
            "statusText" => "OK",
            "headers" => [],
            "json" => function () { return ["id" => "mock01"]; },
        ],
        null,
    ];
};

$client = new MusicbrainzSDK([
    "base" => "http://localhost:8080",
    "system" => [
        "fetch" => $mock_fetch,
    ],
]);
```

### Run live tests

Create a `.env.local` file at the project root:

```
MUSICBRAINZ_TEST_LIVE=TRUE
MUSICBRAINZ_APIKEY=<your-key>
```

Then run:

```bash
cd php && ./vendor/bin/phpunit test/
```


## Reference

### MusicbrainzSDK

```php
require_once 'musicbrainz_sdk.php';
$client = new MusicbrainzSDK($options);
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `array` | Feature activation flags. |
| `extend` | `array` | Additional Feature instances to load. |
| `system` | `array` | System overrides (e.g. custom `fetch` callable). |

### test

```php
$client = MusicbrainzSDK::test($testopts, $sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### MusicbrainzSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `(): array` | Deep copy of current SDK options. |
| `get_utility` | `(): Utility` | Copy of the SDK utility object. |
| `prepare` | `(array $fetchargs): array` | Build an HTTP request definition without sending. |
| `direct` | `(array $fetchargs): array` | Build and send an HTTP request. |
| `Area` | `($data): AreaEntity` | Create an Area entity instance. |
| `Artist` | `($data): ArtistEntity` | Create an Artist entity instance. |
| `Collection` | `($data): CollectionEntity` | Create a Collection entity instance. |
| `Event` | `($data): EventEntity` | Create an Event entity instance. |
| `Genre` | `($data): GenreEntity` | Create a Genre entity instance. |
| `Instrument` | `($data): InstrumentEntity` | Create an Instrument entity instance. |
| `Label` | `($data): LabelEntity` | Create a Label entity instance. |
| `Place` | `($data): PlaceEntity` | Create a Place entity instance. |
| `Rating` | `($data): RatingEntity` | Create a Rating entity instance. |
| `Recording` | `($data): RecordingEntity` | Create a Recording entity instance. |
| `RecordingList` | `($data): RecordingListEntity` | Create a RecordingList entity instance. |
| `Release` | `($data): ReleaseEntity` | Create a Release entity instance. |
| `ReleaseGroup` | `($data): ReleaseGroupEntity` | Create a ReleaseGroup entity instance. |
| `ReleaseList` | `($data): ReleaseListEntity` | Create a ReleaseList entity instance. |
| `Series` | `($data): SeriesEntity` | Create a Series entity instance. |
| `Tag` | `($data): TagEntity` | Create a Tag entity instance. |
| `Url` | `($data): UrlEntity` | Create an Url entity instance. |
| `Work` | `($data): WorkEntity` | Create a Work entity instance. |
| `WorkList` | `($data): WorkListEntity` | Create a WorkList entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `($reqmatch, $ctrl): array` | Load a single entity by match criteria. |
| `list` | `(?array $reqmatch = null, $ctrl): array` | List entities matching the criteria (call with no argument to list all). |
| `create` | `($reqdata, $ctrl): array` | Create a new entity. |
| `data_get` | `(): array` | Get entity data. |
| `data_set` | `($data): void` | Set entity data. |
| `match_get` | `(): array` | Get entity match criteria. |
| `match_set` | `($match): void` | Set entity match criteria. |
| `make` | `(): Entity` | Create a new instance with the same options. |
| `get_name` | `(): string` | Return the entity name. |

### Result shape

Entity operations return the bare result data (an `array` for single-entity
ops, a `list` for `list`) and throw on error. Wrap calls in
`try`/`catch` to handle failures.

The `direct()` escape hatch never throws — it returns a result `array`
you branch on via `$result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `array` | Response headers. |
| `data` | `mixed` | Parsed JSON response body. |

On error, `ok` is `false` and `$err` contains the error value.

### Entities

#### Area

| Field | Description |
| --- | --- |
| `disambiguation` |  |
| `id` |  |
| `life_span` |  |
| `name` |  |
| `sort_name` |  |
| `type` |  |

Operations: List, Load.

API path: `/area`

#### Artist

| Field | Description |
| --- | --- |
| `country` |  |
| `disambiguation` |  |
| `gender` |  |
| `id` |  |
| `life_span` |  |
| `name` |  |
| `sort_name` |  |
| `type` |  |

Operations: List, Load.

API path: `/artist`

#### Collection

| Field | Description |
| --- | --- |
| `editor` |  |
| `entity_type` |  |
| `id` |  |
| `name` |  |

Operations: List.

API path: `/collection`

#### Event

| Field | Description |
| --- | --- |
| `cancelled` |  |
| `disambiguation` |  |
| `id` |  |
| `life_span` |  |
| `name` |  |
| `time` |  |
| `type` |  |

Operations: List, Load.

API path: `/event`

#### Genre

| Field | Description |
| --- | --- |
| `disambiguation` |  |
| `id` |  |
| `name` |  |

Operations: List, Load.

API path: `/genre/all`

#### Instrument

| Field | Description |
| --- | --- |
| `description` |  |
| `disambiguation` |  |
| `id` |  |
| `name` |  |
| `type` |  |

Operations: List, Load.

API path: `/instrument`

#### Label

| Field | Description |
| --- | --- |
| `country` |  |
| `disambiguation` |  |
| `id` |  |
| `label_code` |  |
| `life_span` |  |
| `name` |  |
| `sort_name` |  |
| `type` |  |

Operations: List, Load.

API path: `/label`

#### Place

| Field | Description |
| --- | --- |
| `address` |  |
| `coordinate` |  |
| `disambiguation` |  |
| `id` |  |
| `life_span` |  |
| `name` |  |
| `type` |  |

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
| `disambiguation` |  |
| `id` |  |
| `length` |  |
| `title` |  |
| `video` |  |

Operations: List, Load.

API path: `/recording`

#### RecordingList

| Field | Description |
| --- | --- |
| `count` |  |
| `offset` |  |
| `recording` |  |

Operations: Load.

API path: `/isrc/{isrc}`

#### Release

| Field | Description |
| --- | --- |
| `barcode` |  |
| `country` |  |
| `date` |  |
| `disambiguation` |  |
| `id` |  |
| `packaging` |  |
| `status` |  |
| `title` |  |

Operations: List, Load.

API path: `/release`

#### ReleaseGroup

| Field | Description |
| --- | --- |
| `disambiguation` |  |
| `first_release_date` |  |
| `id` |  |
| `primary_type` |  |
| `secondary_type` |  |
| `title` |  |

Operations: List, Load.

API path: `/release-group`

#### ReleaseList

| Field | Description |
| --- | --- |
| `count` |  |
| `offset` |  |
| `release` |  |

Operations: Load.

API path: `/discid/{discid}`

#### Series

| Field | Description |
| --- | --- |
| `disambiguation` |  |
| `id` |  |
| `name` |  |
| `type` |  |

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
| `id` |  |
| `resource` |  |

Operations: List, Load.

API path: `/url`

#### Work

| Field | Description |
| --- | --- |
| `disambiguation` |  |
| `id` |  |
| `language` |  |
| `title` |  |
| `type` |  |

Operations: List, Load.

API path: `/work`

#### WorkList

| Field | Description |
| --- | --- |
| `count` |  |
| `offset` |  |
| `work` |  |

Operations: Load.

API path: `/iswc/{iswc}`



## Entities


### Area

Create an instance: `$area = $client->Area();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` |  |
| `id` | `string` |  |
| `life_span` | `array` |  |
| `name` | `string` |  |
| `sort_name` | `string` |  |
| `type` | `string` |  |

#### Example: Load

```php
// load() returns the bare Area record (throws on error).
$area = $client->Area()->load(["id" => "area_id"]);
```

#### Example: List

```php
// list() returns an array of Area records (throws on error).
$areas = $client->Area()->list();
```


### Artist

Create an instance: `$artist = $client->Artist();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country` | `string` |  |
| `disambiguation` | `string` |  |
| `gender` | `string` |  |
| `id` | `string` |  |
| `life_span` | `array` |  |
| `name` | `string` |  |
| `sort_name` | `string` |  |
| `type` | `string` |  |

#### Example: Load

```php
// load() returns the bare Artist record (throws on error).
$artist = $client->Artist()->load(["id" => "artist_id"]);
```

#### Example: List

```php
// list() returns an array of Artist records (throws on error).
$artists = $client->Artist()->list();
```


### Collection

Create an instance: `$collection = $client->Collection();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `editor` | `string` |  |
| `entity_type` | `string` |  |
| `id` | `string` |  |
| `name` | `string` |  |

#### Example: List

```php
// list() returns an array of Collection records (throws on error).
$collections = $client->Collection()->list();
```


### Event

Create an instance: `$event = $client->Event();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `cancelled` | `bool` |  |
| `disambiguation` | `string` |  |
| `id` | `string` |  |
| `life_span` | `array` |  |
| `name` | `string` |  |
| `time` | `string` |  |
| `type` | `string` |  |

#### Example: Load

```php
// load() returns the bare Event record (throws on error).
$event = $client->Event()->load(["id" => "event_id"]);
```

#### Example: List

```php
// list() returns an array of Event records (throws on error).
$events = $client->Event()->list();
```


### Genre

Create an instance: `$genre = $client->Genre();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` |  |
| `id` | `string` |  |
| `name` | `string` |  |

#### Example: Load

```php
// load() returns the bare Genre record (throws on error).
$genre = $client->Genre()->load(["id" => "genre_id"]);
```

#### Example: List

```php
// list() returns an array of Genre records (throws on error).
$genres = $client->Genre()->list();
```


### Instrument

Create an instance: `$instrument = $client->Instrument();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `string` |  |
| `disambiguation` | `string` |  |
| `id` | `string` |  |
| `name` | `string` |  |
| `type` | `string` |  |

#### Example: Load

```php
// load() returns the bare Instrument record (throws on error).
$instrument = $client->Instrument()->load(["id" => "instrument_id"]);
```

#### Example: List

```php
// list() returns an array of Instrument records (throws on error).
$instruments = $client->Instrument()->list();
```


### Label

Create an instance: `$label = $client->Label();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country` | `string` |  |
| `disambiguation` | `string` |  |
| `id` | `string` |  |
| `label_code` | `int` |  |
| `life_span` | `array` |  |
| `name` | `string` |  |
| `sort_name` | `string` |  |
| `type` | `string` |  |

#### Example: Load

```php
// load() returns the bare Label record (throws on error).
$label = $client->Label()->load(["id" => "label_id"]);
```

#### Example: List

```php
// list() returns an array of Label records (throws on error).
$labels = $client->Label()->list();
```


### Place

Create an instance: `$place = $client->Place();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `string` |  |
| `coordinate` | `array` |  |
| `disambiguation` | `string` |  |
| `id` | `string` |  |
| `life_span` | `array` |  |
| `name` | `string` |  |
| `type` | `string` |  |

#### Example: Load

```php
// load() returns the bare Place record (throws on error).
$place = $client->Place()->load(["id" => "place_id"]);
```

#### Example: List

```php
// list() returns an array of Place records (throws on error).
$places = $client->Place()->list();
```


### Rating

Create an instance: `$rating = $client->Rating();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```php
// load() returns the bare Rating record (throws on error).
$rating = $client->Rating()->load();
```

#### Example: Create

```php
$rating = $client->Rating()->create([
]);
```


### Recording

Create an instance: `$recording = $client->Recording();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` |  |
| `id` | `string` |  |
| `length` | `int` |  |
| `title` | `string` |  |
| `video` | `bool` |  |

#### Example: Load

```php
// load() returns the bare Recording record (throws on error).
$recording = $client->Recording()->load(["id" => "recording_id"]);
```

#### Example: List

```php
// list() returns an array of Recording records (throws on error).
$recordings = $client->Recording()->list();
```


### RecordingList

Create an instance: `$recording_list = $client->RecordingList();`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `int` |  |
| `offset` | `int` |  |
| `recording` | `array` |  |

#### Example: Load

```php
// load() returns the bare RecordingList record (throws on error).
$recording_list = $client->RecordingList()->load(["isrc" => "isrc"]);
```


### Release

Create an instance: `$release = $client->Release();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `barcode` | `string` |  |
| `country` | `string` |  |
| `date` | `string` |  |
| `disambiguation` | `string` |  |
| `id` | `string` |  |
| `packaging` | `string` |  |
| `status` | `string` |  |
| `title` | `string` |  |

#### Example: Load

```php
// load() returns the bare Release record (throws on error).
$release = $client->Release()->load(["id" => "release_id"]);
```

#### Example: List

```php
// list() returns an array of Release records (throws on error).
$releases = $client->Release()->list();
```


### ReleaseGroup

Create an instance: `$release_group = $client->ReleaseGroup();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` |  |
| `first_release_date` | `string` |  |
| `id` | `string` |  |
| `primary_type` | `string` |  |
| `secondary_type` | `array` |  |
| `title` | `string` |  |

#### Example: Load

```php
// load() returns the bare ReleaseGroup record (throws on error).
$release_group = $client->ReleaseGroup()->load(["id" => "release_group_id"]);
```

#### Example: List

```php
// list() returns an array of ReleaseGroup records (throws on error).
$release_groups = $client->ReleaseGroup()->list();
```


### ReleaseList

Create an instance: `$release_list = $client->ReleaseList();`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `int` |  |
| `offset` | `int` |  |
| `release` | `array` |  |

#### Example: Load

```php
// load() returns the bare ReleaseList record (throws on error).
$release_list = $client->ReleaseList()->load(["discid" => "discid"]);
```


### Series

Create an instance: `$series = $client->Series();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` |  |
| `id` | `string` |  |
| `name` | `string` |  |
| `type` | `string` |  |

#### Example: Load

```php
// load() returns the bare Series record (throws on error).
$series = $client->Series()->load(["id" => "series_id"]);
```

#### Example: List

```php
// list() returns an array of Series records (throws on error).
$seriess = $client->Series()->list();
```


### Tag

Create an instance: `$tag = $client->Tag();`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```php
// load() returns the bare Tag record (throws on error).
$tag = $client->Tag()->load();
```

#### Example: Create

```php
$tag = $client->Tag()->create([
]);
```


### Url

Create an instance: `$url = $client->Url();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` |  |
| `resource` | `string` |  |

#### Example: Load

```php
// load() returns the bare Url record (throws on error).
$url = $client->Url()->load(["id" => "url_id"]);
```

#### Example: List

```php
// list() returns an array of Url records (throws on error).
$urls = $client->Url()->list();
```


### Work

Create an instance: `$work = $client->Work();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` |  |
| `id` | `string` |  |
| `language` | `string` |  |
| `title` | `string` |  |
| `type` | `string` |  |

#### Example: Load

```php
// load() returns the bare Work record (throws on error).
$work = $client->Work()->load(["id" => "work_id"]);
```

#### Example: List

```php
// list() returns an array of Work records (throws on error).
$works = $client->Work()->list();
```


### WorkList

Create an instance: `$work_list = $client->WorkList();`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `int` |  |
| `offset` | `int` |  |
| `work` | `array` |  |

#### Example: Load

```php
// load() returns the bare WorkList record (throws on error).
$work_list = $client->WorkList()->load(["iswc" => "iswc"]);
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

Features are the extension mechanism. A feature is a PHP class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as arrays

The PHP SDK uses plain PHP associative arrays throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `Helpers::to_map()` to safely validate that a value is an array.

### Directory structure

```
php/
├── musicbrainz_sdk.php          -- Main SDK class
├── config.php                     -- Configuration
├── features.php                   -- Feature factory
├── core/                          -- Core types and context
├── entity/                        -- Entity implementations
├── feature/                       -- Built-in features (Base, Test, Log)
├── utility/                       -- Utility functions and struct library
└── test/                          -- Test suites
```

The main class (`musicbrainz_sdk.php`) exports the SDK class
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```php
$area = $client->Area();
$area->list();

// $area->data_get() now returns the area data from the last list
// $area->match_get() returns the last match criteria
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
