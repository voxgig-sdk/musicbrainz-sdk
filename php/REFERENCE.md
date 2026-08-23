# Musicbrainz PHP SDK Reference

Complete API reference for the Musicbrainz PHP SDK.


## MusicbrainzSDK

### Constructor

```php
require_once __DIR__ . '/musicbrainz_sdk.php';

$client = new MusicbrainzSDK($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `array` | SDK configuration options. |
| `$options["apikey"]` | `string` | API key for authentication. |
| `$options["base"]` | `string` | Base URL for API requests. |
| `$options["prefix"]` | `string` | URL prefix appended after base. |
| `$options["suffix"]` | `string` | URL suffix appended after path. |
| `$options["headers"]` | `array` | Custom headers for all requests. |
| `$options["feature"]` | `array` | Feature configuration. |
| `$options["system"]` | `array` | System overrides (e.g. custom fetch). |


### Static Methods

#### `MusicbrainzSDK::test($testopts = null, $sdkopts = null)`

Create a test client with mock features active. Both arguments may be `null`.

```php
$client = MusicbrainzSDK::test();
```


### Instance Methods

#### `Area($data = null)`

Create a new `AreaEntity` instance. Pass `null` for no initial data.

#### `Artist($data = null)`

Create a new `ArtistEntity` instance. Pass `null` for no initial data.

#### `Collection($data = null)`

Create a new `CollectionEntity` instance. Pass `null` for no initial data.

#### `Event($data = null)`

Create a new `EventEntity` instance. Pass `null` for no initial data.

#### `Genre($data = null)`

Create a new `GenreEntity` instance. Pass `null` for no initial data.

#### `Instrument($data = null)`

Create a new `InstrumentEntity` instance. Pass `null` for no initial data.

#### `Label($data = null)`

Create a new `LabelEntity` instance. Pass `null` for no initial data.

#### `Place($data = null)`

Create a new `PlaceEntity` instance. Pass `null` for no initial data.

#### `Rating($data = null)`

Create a new `RatingEntity` instance. Pass `null` for no initial data.

#### `Recording($data = null)`

Create a new `RecordingEntity` instance. Pass `null` for no initial data.

#### `RecordingList($data = null)`

Create a new `RecordingListEntity` instance. Pass `null` for no initial data.

#### `Release($data = null)`

Create a new `ReleaseEntity` instance. Pass `null` for no initial data.

#### `ReleaseGroup($data = null)`

Create a new `ReleaseGroupEntity` instance. Pass `null` for no initial data.

#### `ReleaseList($data = null)`

Create a new `ReleaseListEntity` instance. Pass `null` for no initial data.

#### `Series($data = null)`

Create a new `SeriesEntity` instance. Pass `null` for no initial data.

#### `Tag($data = null)`

Create a new `TagEntity` instance. Pass `null` for no initial data.

#### `Url($data = null)`

Create a new `UrlEntity` instance. Pass `null` for no initial data.

#### `Work($data = null)`

Create a new `WorkEntity` instance. Pass `null` for no initial data.

#### `WorkList($data = null)`

Create a new `WorkListEntity` instance. Pass `null` for no initial data.

#### `options_map(): array`

Return a deep copy of the current SDK options.

#### `get_utility(): MusicbrainzUtility`

Return a copy of the SDK utility object.

#### `direct(array $fetchargs = []): array`

Make a direct HTTP request to any API endpoint. This is the raw-HTTP escape
hatch: it does **not** throw. It returns a result array
`["ok" => bool, "status" => int, "headers" => array, "data" => mixed]`, or
`["ok" => false, "err" => \Exception]` on failure. Branch on `$result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `$fetchargs["params"]` | `array` | Path parameter values for `{param}` substitution. |
| `$fetchargs["query"]` | `array` | Query string parameters. |
| `$fetchargs["headers"]` | `array` | Request headers (merged with defaults). |
| `$fetchargs["body"]` | `mixed` | Request body (arrays are JSON-serialized). |
| `$fetchargs["ctrl"]` | `array` | Control options. |

**Returns:** `array` — the result dict (see above); never throws.

#### `prepare(array $fetchargs = []): mixed`

Prepare a fetch definition without sending the request. Returns the
`$fetchdef` array. Throws on error.


---

## AreaEntity

```php
$area = $client->Area();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `begin` | `string` | No | Begin date |
| `disambiguation` | `string` | No | Disambiguation comment |
| `end` | `string` | No | End date |
| `ended` | `bool` | No | Whether the entity has ended |
| `id` | `string` | No | MusicBrainz ID |
| `lifespan` | `array` | No |  |
| `name` | `string` | No | Area name |
| `sortname` | `string` | No | Sort name |
| `type` | `string` | No | Area type |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Area()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Area()->load(["id" => "area_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): AreaEntity`

Create a new `AreaEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## ArtistEntity

```php
$artist = $client->Artist();
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
| `lifespan` | `array` | No |  |
| `name` | `string` | No | Artist name |
| `sortname` | `string` | No | Sort name |
| `type` | `string` | No | Artist type (person, group, etc.) |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Artist()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Artist()->load(["id" => "artist_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): ArtistEntity`

Create a new `ArtistEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## CollectionEntity

```php
$collection = $client->Collection();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `editor` | `string` | No |  |
| `entitytype` | `string` | No |  |
| `id` | `string` | No |  |
| `name` | `string` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Collection()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): CollectionEntity`

Create a new `CollectionEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## EventEntity

```php
$event = $client->Event();
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
| `lifespan` | `array` | No |  |
| `name` | `string` | No | Event name |
| `time` | `string` | No | Event time |
| `type` | `string` | No | Event type |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Event()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Event()->load(["id" => "event_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): EventEntity`

Create a new `EventEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## GenreEntity

```php
$genre = $client->Genre();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | `string` | No | Disambiguation comment |
| `id` | `string` | No | MusicBrainz ID |
| `name` | `string` | No | Genre name |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Genre()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Genre()->load(["id" => "genre_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): GenreEntity`

Create a new `GenreEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## InstrumentEntity

```php
$instrument = $client->Instrument();
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

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Instrument()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Instrument()->load(["id" => "instrument_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): InstrumentEntity`

Create a new `InstrumentEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## LabelEntity

```php
$label = $client->Label();
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
| `lifespan` | `array` | No |  |
| `name` | `string` | No | Label name |
| `sortname` | `string` | No | Sort name |
| `type` | `string` | No | Label type |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Label()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Label()->load(["id" => "label_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): LabelEntity`

Create a new `LabelEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## PlaceEntity

```php
$place = $client->Place();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `address` | `string` | No | Place address |
| `coordinates` | `array` | No |  |
| `disambiguation` | `string` | No | Disambiguation comment |
| `id` | `string` | No | MusicBrainz ID |
| `lifespan` | `array` | No |  |
| `name` | `string` | No | Place name |
| `type` | `string` | No | Place type |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Place()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Place()->load(["id" => "place_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): PlaceEntity`

Create a new `PlaceEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## RatingEntity

```php
$rating = $client->Rating();
```

### Operations

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->Rating()->create([
]);
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Rating()->load();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): RatingEntity`

Create a new `RatingEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## RecordingEntity

```php
$recording = $client->Recording();
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

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Recording()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Recording()->load(["id" => "recording_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): RecordingEntity`

Create a new `RecordingEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## RecordingListEntity

```php
$recording_list = $client->RecordingList();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `count` | `int` | No |  |
| `offset` | `int` | No |  |
| `recordings` | `array` | No |  |

### Operations

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->RecordingList()->load(["isrc" => "isrc"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): RecordingListEntity`

Create a new `RecordingListEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## ReleaseEntity

```php
$release = $client->Release();
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

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Release()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Release()->load(["id" => "release_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): ReleaseEntity`

Create a new `ReleaseEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## ReleaseGroupEntity

```php
$release_group = $client->ReleaseGroup();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | `string` | No | Disambiguation comment |
| `firstreleasedate` | `string` | No | Date of first release |
| `id` | `string` | No | MusicBrainz ID |
| `primarytype` | `string` | No | Primary type (album, single, ep, broadcast, other) |
| `secondarytypes` | `array` | No | Secondary types (compilation, soundtrack, etc.) |
| `title` | `string` | No | Release group title |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->ReleaseGroup()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->ReleaseGroup()->load(["id" => "release_group_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): ReleaseGroupEntity`

Create a new `ReleaseGroupEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## ReleaseListEntity

```php
$release_list = $client->ReleaseList();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `count` | `int` | No |  |
| `offset` | `int` | No |  |
| `releases` | `array` | No |  |

### Operations

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->ReleaseList()->load(["discid" => "discid"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): ReleaseListEntity`

Create a new `ReleaseListEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## SeriesEntity

```php
$series = $client->Series();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `disambiguation` | `string` | No | Disambiguation comment |
| `id` | `string` | No | MusicBrainz ID |
| `name` | `string` | No | Series name |
| `type` | `string` | No | Series type |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Series()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Series()->load(["id" => "series_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): SeriesEntity`

Create a new `SeriesEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## TagEntity

```php
$tag = $client->Tag();
```

### Operations

#### `create(array $reqdata, ?array $ctrl = null): mixed`

Create a new entity with the given data. Throws on error.

```php
$result = $client->Tag()->create([
]);
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Tag()->load();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): TagEntity`

Create a new `TagEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## UrlEntity

```php
$url = $client->Url();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `string` | No | MusicBrainz ID |
| `resource` | `string` | No | The URL resource |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Url()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Url()->load(["id" => "url_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): UrlEntity`

Create a new `UrlEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## WorkEntity

```php
$work = $client->Work();
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

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Work()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Work()->load(["id" => "work_id"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): WorkEntity`

Create a new `WorkEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## WorkListEntity

```php
$work_list = $client->WorkList();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `count` | `int` | No |  |
| `offset` | `int` | No |  |
| `works` | `array` | No |  |

### Operations

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->WorkList()->load(["iswc" => "iswc"]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): WorkListEntity`

Create a new `WorkListEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```php
$client = new MusicbrainzSDK([
  "feature" => [
    "test" => ["active" => true],
  ],
]);
```

