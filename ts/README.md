# Musicbrainz TypeScript SDK



The TypeScript SDK for the Musicbrainz API — a type-safe, entity-oriented client with full async/await support.

The API is exposed as capitalised, semantic **Entities** — e.g.
`client.Area()` — each with a small set of operations (`list`, `load`, `create`)
instead of raw URL paths and query parameters. This keeps the surface
predictable and low-friction for both humans and AI agents.

> Also generated from this model: `go`, `go-cli`, `go-mcp`, `lua`, `php`, `py`, `rb` — see
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

### 2. List area records

`list()` resolves to an array of Area ENTITIES — every operation
resolves to entities, not raw records. Iterate them directly, and call
`.data()` on one for the record it holds:

```ts
const areas = await client.Area().list()

for (const area of areas) {
  console.log(area)
}
```

### 3. Load a recordinglist

RecordingList is nested under isrc, so provide the `isrc`.
`load()` returns the entity directly and throws on failure:

```ts
try {
  const recordinglist = await client.RecordingList().load({
    isrc: 'example_isrc',
  })
  console.log(recordinglist)
} catch (err) {
  console.error('load failed:', err)
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const seriess = await client.Series().list()
  console.log(seriess)
} catch (err) {
  console.error('list failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
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

if (result instanceof Error) {
  throw result
}
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

const series = await client.Series().list()
// series is the entity, populated with mock response data
// — call series.data() for the record itself
console.log(series)
```

You can also use the instance method:

```ts
const client = new MusicbrainzSDK({ apikey: '...' })
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```ts
const entity = client.Series()

// First call runs the operation and stores its result
await entity.list()

// Subsequent calls reuse the stored state
const data = entity.data()
console.log(data.id)
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
| `Area(data?)` | `AreaEntity` | Create an Area entity instance. |
| `Artist(data?)` | `ArtistEntity` | Create an Artist entity instance. |
| `Collection(data?)` | `CollectionEntity` | Create a Collection entity instance. |
| `Event(data?)` | `EventEntity` | Create an Event entity instance. |
| `Genre(data?)` | `GenreEntity` | Create a Genre entity instance. |
| `Instrument(data?)` | `InstrumentEntity` | Create an Instrument entity instance. |
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
| `Url(data?)` | `UrlEntity` | Create an Url entity instance. |
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
| `load` | `load(reqmatch?, ctrl?): Promise<Entity>` | Load a single entity by match criteria. |
| `list` | `list(reqmatch?, ctrl?): Promise<Entity[]>` | List entities matching the criteria. |
| `create` | `create(reqdata?, ctrl?): Promise<Entity>` | Create a new entity. |
| `data` | `data(data?: Partial<Entity>): Entity` | Get or set entity data. |
| `match` | `match(match?: Partial<Entity>): Partial<Entity>` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): MusicbrainzSDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Return values

Entity operations resolve to the entity data directly — there is no
result envelope:

- `load` and `create` resolve to a single entity object.
- `list` resolves to an **array** of entity objects (iterate it directly;
  there is no `.data` and no `.ok`).

On a failed request these methods **throw**, so wrap calls in
`try`/`catch` to handle errors. Only `direct()` returns the result
envelope described below.

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
| `begin` | Begin date |
| `disambiguation` | Disambiguation comment |
| `end` | End date |
| `ended` | Whether the entity has ended |
| `id` | MusicBrainz ID |
| `lifespan` |  |
| `name` | Area name |
| `sortname` | Sort name |
| `type` | Area type |

Operations: list, load.

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

Operations: list, load.

API path: `/artist`

#### Collection

| Field | Description |
| --- | --- |
| `editor` |  |
| `entitytype` |  |
| `id` |  |
| `name` |  |

Operations: list.

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

Operations: list, load.

API path: `/event`

#### Genre

| Field | Description |
| --- | --- |
| `disambiguation` | Disambiguation comment |
| `id` | MusicBrainz ID |
| `name` | Genre name |

Operations: list, load.

API path: `/genre/all`

#### Instrument

| Field | Description |
| --- | --- |
| `description` | Instrument description |
| `disambiguation` | Disambiguation comment |
| `id` | MusicBrainz ID |
| `name` | Instrument name |
| `type` | Instrument type |

Operations: list, load.

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

Operations: list, load.

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
| `disambiguation` | Disambiguation comment |
| `id` | MusicBrainz ID |
| `length` | Duration in milliseconds |
| `title` | Recording title |
| `video` | Whether this is a video recording |

Operations: list, load.

API path: `/recording`

#### RecordingList

| Field | Description |
| --- | --- |
| `count` |  |
| `offset` |  |
| `recordings` |  |

Operations: load.

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

Operations: list, load.

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

Operations: list, load.

API path: `/release-group`

#### ReleaseList

| Field | Description |
| --- | --- |
| `count` |  |
| `offset` |  |
| `releases` |  |

Operations: load.

API path: `/discid/{discid}`

#### Series

| Field | Description |
| --- | --- |
| `disambiguation` | Disambiguation comment |
| `id` | MusicBrainz ID |
| `name` | Series name |
| `type` | Series type |

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
| `id` | MusicBrainz ID |
| `resource` | The URL resource |

Operations: list, load.

API path: `/url`

#### Work

| Field | Description |
| --- | --- |
| `disambiguation` | Disambiguation comment |
| `id` | MusicBrainz ID |
| `language` | Language code |
| `title` | Work title |
| `type` | Work type |

Operations: list, load.

API path: `/work`

#### WorkList

| Field | Description |
| --- | --- |
| `count` |  |
| `offset` |  |
| `works` |  |

Operations: load.

API path: `/iswc/{iswc}`



## Entities


### Area

Create an instance: `const area = client.Area()`

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
| `lifespan` | `Record<string, any>` |  |
| `name` | `string` | Area name |
| `sortname` | `string` | Sort name |
| `type` | `string` | Area type |

#### Example: Load

```ts
const area = await client.Area().load({ id: 'area_id' })
```

#### Example: List

```ts
const areas = await client.Area().list()
```


### Artist

Create an instance: `const artist = client.Artist()`

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
| `lifespan` | `Record<string, any>` |  |
| `name` | `string` | Artist name |
| `sortname` | `string` | Sort name |
| `type` | `string` | Artist type (person, group, etc.) |

#### Example: Load

```ts
const artist = await client.Artist().load({ id: 'artist_id' })
```

#### Example: List

```ts
const artists = await client.Artist().list()
```


### Collection

Create an instance: `const collection = client.Collection()`

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

```ts
const collections = await client.Collection().list()
```


### Event

Create an instance: `const event = client.Event()`

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
| `lifespan` | `Record<string, any>` |  |
| `name` | `string` | Event name |
| `time` | `string` | Event time |
| `type` | `string` | Event type |

#### Example: Load

```ts
const event = await client.Event().load({ id: 'event_id' })
```

#### Example: List

```ts
const events = await client.Event().list()
```


### Genre

Create an instance: `const genre = client.Genre()`

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

```ts
const genre = await client.Genre().load({ id: 'genre_id' })
```

#### Example: List

```ts
const genres = await client.Genre().list()
```


### Instrument

Create an instance: `const instrument = client.Instrument()`

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

```ts
const instrument = await client.Instrument().load({ id: 'instrument_id' })
```

#### Example: List

```ts
const instruments = await client.Instrument().list()
```


### Label

Create an instance: `const label = client.Label()`

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
| `lifespan` | `Record<string, any>` |  |
| `name` | `string` | Label name |
| `sortname` | `string` | Sort name |
| `type` | `string` | Label type |

#### Example: Load

```ts
const label = await client.Label().load({ id: 'label_id' })
```

#### Example: List

```ts
const labels = await client.Label().list()
```


### Place

Create an instance: `const place = client.Place()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `string` | Place address |
| `coordinates` | `Record<string, any>` |  |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `lifespan` | `Record<string, any>` |  |
| `name` | `string` | Place name |
| `type` | `string` | Place type |

#### Example: Load

```ts
const place = await client.Place().load({ id: 'place_id' })
```

#### Example: List

```ts
const places = await client.Place().list()
```


### Rating

Create an instance: `const rating = client.Rating()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const rating = await client.Rating().load()
```

#### Example: Create

```ts
const rating = await client.Rating().create({
})
```


### Recording

Create an instance: `const recording = client.Recording()`

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

```ts
const recording = await client.Recording().load({ id: 'recording_id' })
```

#### Example: List

```ts
const recordings = await client.Recording().list()
```


### RecordingList

Create an instance: `const recording_list = client.RecordingList()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `number` |  |
| `offset` | `number` |  |
| `recordings` | `any[]` |  |

#### Example: Load

```ts
const recording_list = await client.RecordingList().load({ isrc: 'isrc' })
```


### Release

Create an instance: `const release = client.Release()`

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

```ts
const release = await client.Release().load({ id: 'release_id' })
```

#### Example: List

```ts
const releases = await client.Release().list()
```


### ReleaseGroup

Create an instance: `const release_group = client.ReleaseGroup()`

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
| `secondarytypes` | `any[]` | Secondary types (compilation, soundtrack, etc.) |
| `title` | `string` | Release group title |

#### Example: Load

```ts
const release_group = await client.ReleaseGroup().load({ id: 'release_group_id' })
```

#### Example: List

```ts
const release_groups = await client.ReleaseGroup().list()
```


### ReleaseList

Create an instance: `const release_list = client.ReleaseList()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `number` |  |
| `offset` | `number` |  |
| `releases` | `any[]` |  |

#### Example: Load

```ts
const release_list = await client.ReleaseList().load({ discid: 'discid' })
```


### Series

Create an instance: `const series = client.Series()`

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

```ts
const series = await client.Series().load({ id: 'series_id' })
```

#### Example: List

```ts
const seriess = await client.Series().list()
```


### Tag

Create an instance: `const tag = client.Tag()`

#### Operations

| Method | Description |
| --- | --- |
| `create(data)` | Create a new entity with the given data. |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const tag = await client.Tag().load()
```

#### Example: Create

```ts
const tag = await client.Tag().create({
})
```


### Url

Create an instance: `const url = client.Url()`

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

```ts
const url = await client.Url().load({ id: 'url_id' })
```

#### Example: List

```ts
const urls = await client.Url().list()
```


### Work

Create an instance: `const work = client.Work()`

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

```ts
const work = await client.Work().load({ id: 'work_id' })
```

#### Example: List

```ts
const works = await client.Work().list()
```


### WorkList

Create an instance: `const work_list = client.WorkList()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `number` |  |
| `offset` | `number` |  |
| `works` | `any[]` |  |

#### Example: Load

```ts
const work_list = await client.WorkList().load({ iswc: 'iswc' })
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

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const series = client.Series()
await series.list()

// series.data() now returns the series data from the last `list`
// series.match() returns the last match criteria
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
