# Musicbrainz TypeScript SDK



The TypeScript SDK for the Musicbrainz API — a type-safe, entity-oriented client with full async/await support.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to npm. Install it from the GitHub
release tag (`ts/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/musicbrainz-sdk/releases](https://github.com/voxgig-sdk/musicbrainz-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ts
import { MusicbrainzSDK } from '@voxgig-sdk/musicbrainz'

const client = new MusicbrainzSDK({
  apikey: process.env.MUSICBRAINZ_APIKEY,
})
```

### 2. List areas

```ts
const result = await client.area.list()

if (result.ok) {
  for (const item of result.data) {
    console.log(item.id, item.name)
  }
}
```

### 3. Load an area

```ts
const result = await client.area.load({ id: 'example_id' })

if (result.ok) {
  console.log(result.data)
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})

if (result.ok) {
  console.log(result.status)  // 200
  console.log(result.data)    // response body
}
```

### Prepare a request without sending it

```ts
const fetchdef = await client.prepare({
  path: '/api/resource/{id}',
  method: 'DELETE',
  params: { id: 'example' },
})

// Inspect before sending
console.log(fetchdef.url)
console.log(fetchdef.method)
console.log(fetchdef.headers)
```

### Use test mode

Create a mock client for unit testing — no server required:

```ts
const client = MusicbrainzSDK.test()

const result = await client.area.load({ id: 'test01' })
// result.ok === true
// result.data contains mock response data
```

You can also use the instance method:

```ts
const client = new MusicbrainzSDK({ apikey: '...' })
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```ts
const entity = client.area

// First call sets internal match
await entity.load({ id: 'example' })

// Subsequent calls reuse the stored match
const data = entity.data()
console.log(data.id) // 'example'
```

### Add custom middleware

Pass features via the `extend` option:

```ts
const logger = {
  hooks: {
    PreRequest: (ctx: any) => {
      console.log('Requesting:', ctx.spec.method, ctx.spec.path)
    },
    PreResponse: (ctx: any) => {
      console.log('Status:', ctx.out.request?.status)
    },
  },
}

const client = new MusicbrainzSDK({
  apikey: '...',
  extend: [logger],
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
cd ts && npm test
```


## Reference

### MusicbrainzSDK

#### Constructor

```ts
new MusicbrainzSDK(options?: {
  apikey?: string
  base?: string
  prefix?: string
  suffix?: string
  feature?: Record<string, { active: boolean }>
  extend?: Feature[]
})
```

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `object` | Feature activation flags (e.g. `{ test: { active: true } }`). |
| `extend` | `Feature[]` | Additional feature instances to load. |

#### Methods

| Method | Returns | Description |
| --- | --- | --- |
| `options()` | `object` | Deep copy of current SDK options. |
| `utility()` | `Utility` | Deep copy of the SDK utility object. |
| `prepare(fetchargs?)` | `Promise<FetchDef>` | Build an HTTP request definition without sending it. |
| `direct(fetchargs?)` | `Promise<DirectResult>` | Build and send an HTTP request. |
| `Area(data?)` | `AreaEntity` | Create a Area entity instance. |
| `Artist(data?)` | `ArtistEntity` | Create a Artist entity instance. |
| `Collection(data?)` | `CollectionEntity` | Create a Collection entity instance. |
| `Event(data?)` | `EventEntity` | Create a Event entity instance. |
| `Genre(data?)` | `GenreEntity` | Create a Genre entity instance. |
| `Instrument(data?)` | `InstrumentEntity` | Create a Instrument entity instance. |
| `Label(data?)` | `LabelEntity` | Create a Label entity instance. |
| `Place(data?)` | `PlaceEntity` | Create a Place entity instance. |
| `Rating(data?)` | `RatingEntity` | Create a Rating entity instance. |
| `Recording(data?)` | `RecordingEntity` | Create a Recording entity instance. |
| `RecordingList(data?)` | `RecordingListEntity` | Create a RecordingList entity instance. |
| `Release(data?)` | `ReleaseEntity` | Create a Release entity instance. |
| `ReleaseGroup(data?)` | `ReleaseGroupEntity` | Create a ReleaseGroup entity instance. |
| `ReleaseList(data?)` | `ReleaseListEntity` | Create a ReleaseList entity instance. |
| `Series(data?)` | `SeriesEntity` | Create a Series entity instance. |
| `Tag(data?)` | `TagEntity` | Create a Tag entity instance. |
| `Url(data?)` | `UrlEntity` | Create a Url entity instance. |
| `Work(data?)` | `WorkEntity` | Create a Work entity instance. |
| `WorkList(data?)` | `WorkListEntity` | Create a WorkList entity instance. |
| `tester(testopts?, sdkopts?)` | `MusicbrainzSDK` | Create a test-mode client instance. |

#### Static methods

| Method | Returns | Description |
| --- | --- | --- |
| `MusicbrainzSDK.test(testopts?, sdkopts?)` | `MusicbrainzSDK` | Create a test-mode client. |

### Entity interface

All entities share the same interface.

#### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `load(reqmatch?, ctrl?): Promise<Result>` | Load a single entity by match criteria. |
| `list` | `list(reqmatch?, ctrl?): Promise<Result>` | List entities matching the criteria. |
| `create` | `create(reqdata?, ctrl?): Promise<Result>` | Create a new entity. |
| `update` | `update(reqdata?, ctrl?): Promise<Result>` | Update an existing entity. |
| `remove` | `remove(reqmatch?, ctrl?): Promise<Result>` | Remove an entity. |
| `data` | `data(data?): any` | Get or set entity data. |
| `match` | `match(match?): any` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): MusicbrainzSDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Result shape

All entity operations return a Result object:

```ts
{
  ok: boolean      // true if the HTTP status is 2xx
  status: number   // HTTP status code
  headers: object  // response headers
  data: any        // parsed JSON response body
}
```

### DirectResult shape

The `direct()` method returns:

```ts
{
  ok: boolean
  status: number
  headers: object
  data: any
}
```

On error, `ok` is `false` and an `err` property contains the error.

### FetchDef shape

The `prepare()` method returns:

```ts
{
  url: string
  method: string
  headers: Record<string, string>
  body?: any
}
```

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

Operations: list, load.

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

Operations: list, load.

API path: `/artist`

#### Collection

| Field | Description |
| --- | --- |
| `editor` |  |
| `entity_type` |  |
| `id` |  |
| `name` |  |

Operations: list.

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

Operations: list, load.

API path: `/event`

#### Genre

| Field | Description |
| --- | --- |
| `disambiguation` |  |
| `id` |  |
| `name` |  |

Operations: list, load.

API path: `/genre/all`

#### Instrument

| Field | Description |
| --- | --- |
| `description` |  |
| `disambiguation` |  |
| `id` |  |
| `name` |  |
| `type` |  |

Operations: list, load.

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

Operations: list, load.

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

Operations: list, load.

API path: `/place`

#### Rating

| Field | Description |
| --- | --- |

Operations: create, load.

API path: `/rating`

#### Recording

| Field | Description |
| --- | --- |
| `disambiguation` |  |
| `id` |  |
| `length` |  |
| `title` |  |
| `video` |  |

Operations: list, load.

API path: `/recording`

#### RecordingList

| Field | Description |
| --- | --- |
| `count` |  |
| `offset` |  |
| `recording` |  |

Operations: load.

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

Operations: list, load.

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

Operations: list, load.

API path: `/release-group`

#### ReleaseList

| Field | Description |
| --- | --- |
| `count` |  |
| `offset` |  |
| `release` |  |

Operations: load.

API path: `/discid/{discid}`

#### Series

| Field | Description |
| --- | --- |
| `disambiguation` |  |
| `id` |  |
| `name` |  |
| `type` |  |

Operations: list, load.

API path: `/series`

#### Tag

| Field | Description |
| --- | --- |

Operations: create, load.

API path: `/tag`

#### Url

| Field | Description |
| --- | --- |
| `id` |  |
| `resource` |  |

Operations: list, load.

API path: `/url`

#### Work

| Field | Description |
| --- | --- |
| `disambiguation` |  |
| `id` |  |
| `language` |  |
| `title` |  |
| `type` |  |

Operations: list, load.

API path: `/work`

#### WorkList

| Field | Description |
| --- | --- |
| `count` |  |
| `offset` |  |
| `work` |  |

Operations: load.

API path: `/iswc/{iswc}`



## Entities


### Area

Create an instance: `const area = client.area`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `life_span` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `sort_name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

#### Example: Load

```ts
const area = await client.area.load({ id: 'area_id' })
```

#### Example: List

```ts
const areas = await client.area.list()
```


### Artist

Create an instance: `const artist = client.artist`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country` | ``$STRING`` |  |
| `disambiguation` | ``$STRING`` |  |
| `gender` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `life_span` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `sort_name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

#### Example: Load

```ts
const artist = await client.artist.load({ id: 'artist_id' })
```

#### Example: List

```ts
const artists = await client.artist.list()
```


### Collection

Create an instance: `const collection = client.collection`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `editor` | ``$STRING`` |  |
| `entity_type` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `name` | ``$STRING`` |  |

#### Example: List

```ts
const collections = await client.collection.list()
```


### Event

Create an instance: `const event = client.event`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `cancelled` | ``$BOOLEAN`` |  |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `life_span` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `time` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

#### Example: Load

```ts
const event = await client.event.load({ id: 'event_id' })
```

#### Example: List

```ts
const events = await client.event.list()
```


### Genre

Create an instance: `const genre = client.genre`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `name` | ``$STRING`` |  |

#### Example: Load

```ts
const genre = await client.genre.load({ id: 'genre_id' })
```

#### Example: List

```ts
const genres = await client.genre.list()
```


### Instrument

Create an instance: `const instrument = client.instrument`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | ``$STRING`` |  |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

#### Example: Load

```ts
const instrument = await client.instrument.load({ id: 'instrument_id' })
```

#### Example: List

```ts
const instruments = await client.instrument.list()
```


### Label

Create an instance: `const label = client.label`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country` | ``$STRING`` |  |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `label_code` | ``$INTEGER`` |  |
| `life_span` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `sort_name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

#### Example: Load

```ts
const label = await client.label.load({ id: 'label_id' })
```

#### Example: List

```ts
const labels = await client.label.list()
```


### Place

Create an instance: `const place = client.place`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | ``$STRING`` |  |
| `coordinate` | ``$OBJECT`` |  |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `life_span` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

#### Example: Load

```ts
const place = await client.place.load({ id: 'place_id' })
```

#### Example: List

```ts
const places = await client.place.list()
```


### Rating

Create an instance: `const rating = client.rating`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const rating = await client.rating.load({ id: 'rating_id' })
```

#### Example: Create

```ts
const rating = await client.rating.create({
})
```


### Recording

Create an instance: `const recording = client.recording`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `length` | ``$INTEGER`` |  |
| `title` | ``$STRING`` |  |
| `video` | ``$BOOLEAN`` |  |

#### Example: Load

```ts
const recording = await client.recording.load({ id: 'recording_id' })
```

#### Example: List

```ts
const recordings = await client.recording.list()
```


### RecordingList

Create an instance: `const recording_list = client.recording_list`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | ``$INTEGER`` |  |
| `offset` | ``$INTEGER`` |  |
| `recording` | ``$ARRAY`` |  |

#### Example: Load

```ts
const recording_list = await client.recording_list.load({ id: 'recording_list_id' })
```


### Release

Create an instance: `const release = client.release`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `barcode` | ``$STRING`` |  |
| `country` | ``$STRING`` |  |
| `date` | ``$STRING`` |  |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `packaging` | ``$STRING`` |  |
| `status` | ``$STRING`` |  |
| `title` | ``$STRING`` |  |

#### Example: Load

```ts
const release = await client.release.load({ id: 'release_id' })
```

#### Example: List

```ts
const releases = await client.release.list()
```


### ReleaseGroup

Create an instance: `const release_group = client.release_group`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | ``$STRING`` |  |
| `first_release_date` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `primary_type` | ``$STRING`` |  |
| `secondary_type` | ``$ARRAY`` |  |
| `title` | ``$STRING`` |  |

#### Example: Load

```ts
const release_group = await client.release_group.load({ id: 'release_group_id' })
```

#### Example: List

```ts
const release_groups = await client.release_group.list()
```


### ReleaseList

Create an instance: `const release_list = client.release_list`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | ``$INTEGER`` |  |
| `offset` | ``$INTEGER`` |  |
| `release` | ``$ARRAY`` |  |

#### Example: Load

```ts
const release_list = await client.release_list.load({ id: 'release_list_id' })
```


### Series

Create an instance: `const series = client.series`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

#### Example: Load

```ts
const series = await client.series.load({ id: 'series_id' })
```

#### Example: List

```ts
const seriess = await client.series.list()
```


### Tag

Create an instance: `const tag = client.tag`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const tag = await client.tag.load({ id: 'tag_id' })
```

#### Example: Create

```ts
const tag = await client.tag.create({
})
```


### Url

Create an instance: `const url = client.url`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | ``$STRING`` |  |
| `resource` | ``$STRING`` |  |

#### Example: Load

```ts
const url = await client.url.load({ id: 'url_id' })
```

#### Example: List

```ts
const urls = await client.url.list()
```


### Work

Create an instance: `const work = client.work`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `language` | ``$STRING`` |  |
| `title` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

#### Example: Load

```ts
const work = await client.work.load({ id: 'work_id' })
```

#### Example: List

```ts
const works = await client.work.list()
```


### WorkList

Create an instance: `const work_list = client.work_list`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | ``$INTEGER`` |  |
| `offset` | ``$INTEGER`` |  |
| `work` | ``$ARRAY`` |  |

#### Example: Load

```ts
const work_list = await client.work_list.load({ id: 'work_list_id' })
```


## Explanation

### The operation pipeline

Every entity operation (load, list, create, update, remove) follows a
six-stage pipeline. Each stage fires a feature hook before executing:

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

If any stage returns an error, the pipeline short-circuits and the
error is returned to the caller.

An unexpected exception triggers the `PreUnexpected` hook before
propagating.

### Features and hooks

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Module structure

```
musicbrainz/
├── src/
│   ├── MusicbrainzSDK.ts        # Main SDK class
│   ├── entity/             # Entity implementations
│   ├── feature/            # Built-in features (Base, Test, Log)
│   └── utility/            # Utility functions
├── test/                   # Test suites
└── dist/                   # Compiled output
```

Import the SDK from the package root:

```ts
import { MusicbrainzSDK } from '@voxgig-sdk/musicbrainz'
```

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const area = client.area
await area.load({ id: "example_id" })

// area.data() now returns the loaded area data
// area.match() returns { id: "example_id" }
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
