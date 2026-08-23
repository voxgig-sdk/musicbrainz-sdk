# Musicbrainz Golang SDK



The Golang SDK for the Musicbrainz API — an entity-oriented client using standard Go conventions. No generics required; data flows as `map[string]any`.

It exposes the API as capitalised, semantic **Entities** — e.g. `client.Area(nil)` — each with the same small set of operations (`List`, `Load`, `Create`) instead of raw URL paths and query strings. You call meaning, not endpoints, which keeps the cognitive load low.

> Also generated from this model: `go-cli`, `go-mcp`, `lua`, `php`, `py`, `rb`, `ts` — see
> the [top-level README](../README.md).


## Install
```bash
go get github.com/voxgig-sdk/musicbrainz-sdk/go@latest
```

The Go module proxy resolves the version from the `go/vX.Y.Z` GitHub
release tag — see [Releases](https://github.com/voxgig-sdk/musicbrainz-sdk/releases) for the available versions.

To vendor from a local checkout instead, clone this repo alongside your
project and add a `replace` directive pointing at the checked-out
`go/` directory:

```bash
go mod edit -replace github.com/voxgig-sdk/musicbrainz-sdk/go=../musicbrainz-sdk/go
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### Quickstart

A complete program: create a client, then call the entity operations.
Each operation returns `(value, error)` — the value is the data itself
(there is no `{ok, data}` wrapper), so check `err` and use the value
directly.

```go
package main

import (
    "fmt"
    "os"
    sdk "github.com/voxgig-sdk/musicbrainz-sdk/go"
)

func main() {
    client := sdk.NewMusicbrainzSDK(map[string]any{
        "apikey": os.Getenv("MUSICBRAINZ_APIKEY"),
    })

    // List area records — the value is the array of records itself.
    areas, err := client.Area(nil).List(nil, nil)
    if err != nil {
        panic(err)
    }
    for _, item := range areas.([]any) {
        fmt.Println(item)
    }

    // Load a single area — the value is the loaded record.
    area, err := client.Area(nil).Load(map[string]any{"id": "example_id"}, nil)
    if err != nil {
        panic(err)
    }
    fmt.Println(area)
}
```


## Error handling

Every entity operation returns `(value, error)`. Check `err` before
using the value — there is no exception to catch:

```go
seriess, err := client.Series(nil).List(nil, nil)
if err != nil {
    // handle err
    return
}
_ = seriess
```

`Direct` follows the same `(value, error)` convention:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example_id"},
})
if err != nil {
    // handle err
}
_ = result
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

if result["ok"] == true {
    fmt.Println(result["status"]) // 200
    fmt.Println(result["data"])   // response body
}
```

### Prepare a request without sending it

```go
fetchdef, err := client.Prepare(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "DELETE",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

fmt.Println(fetchdef["url"])
fmt.Println(fetchdef["method"])
fmt.Println(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```go
client := sdk.Test()

series, err := client.Series(nil).List(
    nil, nil,
)
if err != nil {
    panic(err)
}
fmt.Println(series) // the returned mock data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```go
mockFetch := func(url string, init map[string]any) (map[string]any, error) {
    return map[string]any{
        "status":     200,
        "statusText": "OK",
        "headers":    map[string]any{},
        "json": (func() any)(func() any {
            return map[string]any{"id": "mock01"}
        }),
    }, nil
}

client := sdk.NewMusicbrainzSDK(map[string]any{
    "base": "http://localhost:8080",
    "system": map[string]any{
        "fetch": (func(string, map[string]any) (map[string]any, error))(mockFetch),
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
cd go && go test ./test/...
```


## Reference

### NewMusicbrainzSDK

```go
func NewMusicbrainzSDK(options map[string]any) *MusicbrainzSDK
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `"apikey"` | `string` | API key for authentication. |
| `"base"` | `string` | Base URL of the API server. |
| `"prefix"` | `string` | URL path prefix prepended to all requests. |
| `"suffix"` | `string` | URL path suffix appended to all requests. |
| `"feature"` | `map[string]any` | Feature activation flags. |
| `"extend"` | `[]any` | Additional Feature instances to load. |
| `"system"` | `map[string]any` | System overrides (e.g. custom `"fetch"` function). |

### TestSDK

```go
func TestSDK(testopts map[string]any, sdkopts map[string]any) *MusicbrainzSDK
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### MusicbrainzSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `OptionsMap` | `() map[string]any` | Deep copy of current SDK options. |
| `GetUtility` | `() *Utility` | Copy of the SDK utility object. |
| `Prepare` | `(fetchargs map[string]any) (map[string]any, error)` | Build an HTTP request definition without sending. |
| `Direct` | `(fetchargs map[string]any) (map[string]any, error)` | Build and send an HTTP request. |
| `Area` | `(data map[string]any) MusicbrainzEntity` | Create an Area entity instance. |
| `Artist` | `(data map[string]any) MusicbrainzEntity` | Create an Artist entity instance. |
| `Collection` | `(data map[string]any) MusicbrainzEntity` | Create a Collection entity instance. |
| `Event` | `(data map[string]any) MusicbrainzEntity` | Create an Event entity instance. |
| `Genre` | `(data map[string]any) MusicbrainzEntity` | Create a Genre entity instance. |
| `Instrument` | `(data map[string]any) MusicbrainzEntity` | Create an Instrument entity instance. |
| `Label` | `(data map[string]any) MusicbrainzEntity` | Create a Label entity instance. |
| `Place` | `(data map[string]any) MusicbrainzEntity` | Create a Place entity instance. |
| `Rating` | `(data map[string]any) MusicbrainzEntity` | Create a Rating entity instance. |
| `Recording` | `(data map[string]any) MusicbrainzEntity` | Create a Recording entity instance. |
| `RecordingList` | `(data map[string]any) MusicbrainzEntity` | Create a RecordingList entity instance. |
| `Release` | `(data map[string]any) MusicbrainzEntity` | Create a Release entity instance. |
| `ReleaseGroup` | `(data map[string]any) MusicbrainzEntity` | Create a ReleaseGroup entity instance. |
| `ReleaseList` | `(data map[string]any) MusicbrainzEntity` | Create a ReleaseList entity instance. |
| `Series` | `(data map[string]any) MusicbrainzEntity` | Create a Series entity instance. |
| `Tag` | `(data map[string]any) MusicbrainzEntity` | Create a Tag entity instance. |
| `Url` | `(data map[string]any) MusicbrainzEntity` | Create an Url entity instance. |
| `Work` | `(data map[string]any) MusicbrainzEntity` | Create a Work entity instance. |
| `WorkList` | `(data map[string]any) MusicbrainzEntity` | Create a WorkList entity instance. |

### Entity interface (MusicbrainzEntity)

All entities implement the `MusicbrainzEntity` interface.

| Method | Signature | Description |
| --- | --- | --- |
| `Load` | `(reqmatch, ctrl map[string]any) (any, error)` | Load a single entity by match criteria. |
| `List` | `(reqmatch, ctrl map[string]any) (any, error)` | List entities matching the criteria. |
| `Create` | `(reqdata, ctrl map[string]any) (any, error)` | Create a new entity. |
| `Data` | `(args ...any) any` | Get or set entity data. |
| `Match` | `(args ...any) any` | Get or set entity match criteria. |
| `Make` | `() Entity` | Create a new instance with the same options. |
| `GetName` | `() string` | Return the entity name. |

### Result shape

Entity operations return `(value, error)`. The `value` is the
operation's data **directly** — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `Load` / `Create` | the entity record (`map[string]any`) |
| `List` | a `[]any` of entity records |

Check `err` first, then use the value directly (or the typed
`...Typed` variants, which return the entity's model struct and a typed
slice):

    area, err := client.Area(nil).List(map[string]any{/* fields */}, nil)
    if err != nil { /* handle */ }
    // area is the returned record

Only `Direct()` returns a response envelope — a `map[string]any` with
`"ok"`, `"status"`, `"headers"`, and `"data"` keys.

### Entities

#### Area

| Field | Description |
| --- | --- |
| `"begin"` | Begin date |
| `"disambiguation"` | Disambiguation comment |
| `"end"` | End date |
| `"ended"` | Whether the entity has ended |
| `"id"` | MusicBrainz ID |
| `"lifespan"` |  |
| `"name"` | Area name |
| `"sortname"` | Sort name |
| `"type"` | Area type |

Operations: List, Load.

API path: `/area`

#### Artist

| Field | Description |
| --- | --- |
| `"begin"` | Begin date |
| `"country"` | Country code |
| `"disambiguation"` | Disambiguation comment |
| `"end"` | End date |
| `"ended"` | Whether the entity has ended |
| `"gender"` | Gender (for person type) |
| `"id"` | MusicBrainz ID |
| `"lifespan"` |  |
| `"name"` | Artist name |
| `"sortname"` | Sort name |
| `"type"` | Artist type (person, group, etc.) |

Operations: List, Load.

API path: `/artist`

#### Collection

| Field | Description |
| --- | --- |
| `"editor"` |  |
| `"entitytype"` |  |
| `"id"` |  |
| `"name"` |  |

Operations: List.

API path: `/collection`

#### Event

| Field | Description |
| --- | --- |
| `"begin"` | Begin date |
| `"cancelled"` | Whether the event was cancelled |
| `"disambiguation"` | Disambiguation comment |
| `"end"` | End date |
| `"ended"` | Whether the entity has ended |
| `"id"` | MusicBrainz ID |
| `"lifespan"` |  |
| `"name"` | Event name |
| `"time"` | Event time |
| `"type"` | Event type |

Operations: List, Load.

API path: `/event`

#### Genre

| Field | Description |
| --- | --- |
| `"disambiguation"` | Disambiguation comment |
| `"id"` | MusicBrainz ID |
| `"name"` | Genre name |

Operations: List, Load.

API path: `/genre/all`

#### Instrument

| Field | Description |
| --- | --- |
| `"description"` | Instrument description |
| `"disambiguation"` | Disambiguation comment |
| `"id"` | MusicBrainz ID |
| `"name"` | Instrument name |
| `"type"` | Instrument type |

Operations: List, Load.

API path: `/instrument`

#### Label

| Field | Description |
| --- | --- |
| `"begin"` | Begin date |
| `"country"` | Country code |
| `"disambiguation"` | Disambiguation comment |
| `"end"` | End date |
| `"ended"` | Whether the entity has ended |
| `"id"` | MusicBrainz ID |
| `"labelcode"` | Label code |
| `"lifespan"` |  |
| `"name"` | Label name |
| `"sortname"` | Sort name |
| `"type"` | Label type |

Operations: List, Load.

API path: `/label`

#### Place

| Field | Description |
| --- | --- |
| `"address"` | Place address |
| `"coordinates"` |  |
| `"disambiguation"` | Disambiguation comment |
| `"id"` | MusicBrainz ID |
| `"lifespan"` |  |
| `"name"` | Place name |
| `"type"` | Place type |

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
| `"disambiguation"` | Disambiguation comment |
| `"id"` | MusicBrainz ID |
| `"length"` | Duration in milliseconds |
| `"title"` | Recording title |
| `"video"` | Whether this is a video recording |

Operations: List, Load.

API path: `/recording`

#### RecordingList

| Field | Description |
| --- | --- |
| `"count"` |  |
| `"offset"` |  |
| `"recordings"` |  |

Operations: Load.

API path: `/isrc/{isrc}`

#### Release

| Field | Description |
| --- | --- |
| `"barcode"` | Barcode |
| `"country"` | Release country |
| `"date"` | Release date |
| `"disambiguation"` | Disambiguation comment |
| `"id"` | MusicBrainz ID |
| `"packaging"` | Packaging type |
| `"status"` | Release status (official, promotion, bootleg, pseudo-release) |
| `"title"` | Release title |

Operations: List, Load.

API path: `/release`

#### ReleaseGroup

| Field | Description |
| --- | --- |
| `"disambiguation"` | Disambiguation comment |
| `"firstreleasedate"` | Date of first release |
| `"id"` | MusicBrainz ID |
| `"primarytype"` | Primary type (album, single, ep, broadcast, other) |
| `"secondarytypes"` | Secondary types (compilation, soundtrack, etc.) |
| `"title"` | Release group title |

Operations: List, Load.

API path: `/release-group`

#### ReleaseList

| Field | Description |
| --- | --- |
| `"count"` |  |
| `"offset"` |  |
| `"releases"` |  |

Operations: Load.

API path: `/discid/{discid}`

#### Series

| Field | Description |
| --- | --- |
| `"disambiguation"` | Disambiguation comment |
| `"id"` | MusicBrainz ID |
| `"name"` | Series name |
| `"type"` | Series type |

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
| `"id"` | MusicBrainz ID |
| `"resource"` | The URL resource |

Operations: List, Load.

API path: `/url`

#### Work

| Field | Description |
| --- | --- |
| `"disambiguation"` | Disambiguation comment |
| `"id"` | MusicBrainz ID |
| `"language"` | Language code |
| `"title"` | Work title |
| `"type"` | Work type |

Operations: List, Load.

API path: `/work`

#### WorkList

| Field | Description |
| --- | --- |
| `"count"` |  |
| `"offset"` |  |
| `"works"` |  |

Operations: Load.

API path: `/iswc/{iswc}`



## Entities


### Area

Create an instance: `area := client.Area(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `string` | Begin date |
| `disambiguation` | `string` | Disambiguation comment |
| `end` | `string` | End date |
| `ended` | `bool` | Whether the entity has ended |
| `id` | `string` | MusicBrainz ID |
| `lifespan` | `map[string]any` |  |
| `name` | `string` | Area name |
| `sortname` | `string` | Sort name |
| `type` | `string` | Area type |

#### Example: Load

```go
area, err := client.Area(nil).Load(map[string]any{"id": "area_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(area) // the loaded record
```

#### Example: List

```go
areas, err := client.Area(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(areas) // the array of records
```


### Artist

Create an instance: `artist := client.Artist(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `string` | Begin date |
| `country` | `string` | Country code |
| `disambiguation` | `string` | Disambiguation comment |
| `end` | `string` | End date |
| `ended` | `bool` | Whether the entity has ended |
| `gender` | `string` | Gender (for person type) |
| `id` | `string` | MusicBrainz ID |
| `lifespan` | `map[string]any` |  |
| `name` | `string` | Artist name |
| `sortname` | `string` | Sort name |
| `type` | `string` | Artist type (person, group, etc.) |

#### Example: Load

```go
artist, err := client.Artist(nil).Load(map[string]any{"id": "artist_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(artist) // the loaded record
```

#### Example: List

```go
artists, err := client.Artist(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(artists) // the array of records
```


### Collection

Create an instance: `collection := client.Collection(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `editor` | `string` |  |
| `entitytype` | `string` |  |
| `id` | `string` |  |
| `name` | `string` |  |

#### Example: List

```go
collections, err := client.Collection(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(collections) // the array of records
```


### Event

Create an instance: `event := client.Event(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `string` | Begin date |
| `cancelled` | `bool` | Whether the event was cancelled |
| `disambiguation` | `string` | Disambiguation comment |
| `end` | `string` | End date |
| `ended` | `bool` | Whether the entity has ended |
| `id` | `string` | MusicBrainz ID |
| `lifespan` | `map[string]any` |  |
| `name` | `string` | Event name |
| `time` | `string` | Event time |
| `type` | `string` | Event type |

#### Example: Load

```go
event, err := client.Event(nil).Load(map[string]any{"id": "event_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(event) // the loaded record
```

#### Example: List

```go
events, err := client.Event(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(events) // the array of records
```


### Genre

Create an instance: `genre := client.Genre(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `name` | `string` | Genre name |

#### Example: Load

```go
genre, err := client.Genre(nil).Load(map[string]any{"id": "genre_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(genre) // the loaded record
```

#### Example: List

```go
genres, err := client.Genre(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(genres) // the array of records
```


### Instrument

Create an instance: `instrument := client.Instrument(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | `string` | Instrument description |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `name` | `string` | Instrument name |
| `type` | `string` | Instrument type |

#### Example: Load

```go
instrument, err := client.Instrument(nil).Load(map[string]any{"id": "instrument_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(instrument) // the loaded record
```

#### Example: List

```go
instruments, err := client.Instrument(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(instruments) // the array of records
```


### Label

Create an instance: `label := client.Label(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `begin` | `string` | Begin date |
| `country` | `string` | Country code |
| `disambiguation` | `string` | Disambiguation comment |
| `end` | `string` | End date |
| `ended` | `bool` | Whether the entity has ended |
| `id` | `string` | MusicBrainz ID |
| `labelcode` | `int` | Label code |
| `lifespan` | `map[string]any` |  |
| `name` | `string` | Label name |
| `sortname` | `string` | Sort name |
| `type` | `string` | Label type |

#### Example: Load

```go
label, err := client.Label(nil).Load(map[string]any{"id": "label_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(label) // the loaded record
```

#### Example: List

```go
labels, err := client.Label(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(labels) // the array of records
```


### Place

Create an instance: `place := client.Place(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `address` | `string` | Place address |
| `coordinates` | `map[string]any` |  |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `lifespan` | `map[string]any` |  |
| `name` | `string` | Place name |
| `type` | `string` | Place type |

#### Example: Load

```go
place, err := client.Place(nil).Load(map[string]any{"id": "place_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(place) // the loaded record
```

#### Example: List

```go
places, err := client.Place(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(places) // the array of records
```


### Rating

Create an instance: `rating := client.Rating(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |

#### Example: Load

```go
rating, err := client.Rating(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(rating) // the loaded record
```

#### Example: Create

```go
result, err := client.Rating(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Recording

Create an instance: `recording := client.Recording(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `length` | `int` | Duration in milliseconds |
| `title` | `string` | Recording title |
| `video` | `bool` | Whether this is a video recording |

#### Example: Load

```go
recording, err := client.Recording(nil).Load(map[string]any{"id": "recording_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(recording) // the loaded record
```

#### Example: List

```go
recordings, err := client.Recording(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(recordings) // the array of records
```


### RecordingList

Create an instance: `recordingList := client.RecordingList(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `int` |  |
| `offset` | `int` |  |
| `recordings` | `[]any` |  |

#### Example: Load

```go
recordingList, err := client.RecordingList(nil).Load(map[string]any{"isrc": "isrc"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(recordingList) // the loaded record
```


### Release

Create an instance: `release := client.Release(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

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

```go
release, err := client.Release(nil).Load(map[string]any{"id": "release_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(release) // the loaded record
```

#### Example: List

```go
releases, err := client.Release(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(releases) // the array of records
```


### ReleaseGroup

Create an instance: `releaseGroup := client.ReleaseGroup(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` | Disambiguation comment |
| `firstreleasedate` | `string` | Date of first release |
| `id` | `string` | MusicBrainz ID |
| `primarytype` | `string` | Primary type (album, single, ep, broadcast, other) |
| `secondarytypes` | `[]any` | Secondary types (compilation, soundtrack, etc.) |
| `title` | `string` | Release group title |

#### Example: Load

```go
releaseGroup, err := client.ReleaseGroup(nil).Load(map[string]any{"id": "release_group_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(releaseGroup) // the loaded record
```

#### Example: List

```go
releaseGroups, err := client.ReleaseGroup(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(releaseGroups) // the array of records
```


### ReleaseList

Create an instance: `releaseList := client.ReleaseList(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `int` |  |
| `offset` | `int` |  |
| `releases` | `[]any` |  |

#### Example: Load

```go
releaseList, err := client.ReleaseList(nil).Load(map[string]any{"discid": "discid"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(releaseList) // the loaded record
```


### Series

Create an instance: `series := client.Series(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `name` | `string` | Series name |
| `type` | `string` | Series type |

#### Example: Load

```go
series, err := client.Series(nil).Load(map[string]any{"id": "series_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(series) // the loaded record
```

#### Example: List

```go
seriess, err := client.Series(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(seriess) // the array of records
```


### Tag

Create an instance: `tag := client.Tag(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |
| `Create(data, ctrl)` | Create a new entity with the given data. |

#### Example: Load

```go
tag, err := client.Tag(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(tag) // the loaded record
```

#### Example: Create

```go
result, err := client.Tag(nil).Create(map[string]any{
}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
```


### Url

Create an instance: `url := client.Url(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `string` | MusicBrainz ID |
| `resource` | `string` | The URL resource |

#### Example: Load

```go
url, err := client.Url(nil).Load(map[string]any{"id": "url_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(url) // the loaded record
```

#### Example: List

```go
urls, err := client.Url(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(urls) // the array of records
```


### Work

Create an instance: `work := client.Work(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `disambiguation` | `string` | Disambiguation comment |
| `id` | `string` | MusicBrainz ID |
| `language` | `string` | Language code |
| `title` | `string` | Work title |
| `type` | `string` | Work type |

#### Example: Load

```go
work, err := client.Work(nil).Load(map[string]any{"id": "work_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(work) // the loaded record
```

#### Example: List

```go
works, err := client.Work(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(works) // the array of records
```


### WorkList

Create an instance: `workList := client.WorkList(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | `int` |  |
| `offset` | `int` |  |
| `works` | `[]any` |  |

#### Example: Load

```go
workList, err := client.WorkList(nil).Load(map[string]any{"iswc": "iswc"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(workList) // the loaded record
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

Features are the extension mechanism. A feature implements the
`Feature` interface and provides hooks — functions keyed by pipeline
stage names.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as maps

The Go SDK uses `map[string]any` throughout rather than typed structs.
This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Use `core.ToMapAny()` to safely cast results and nested data.

### Package structure

```
github.com/voxgig-sdk/musicbrainz-sdk/go/
├── musicbrainz.go        # Root package — type aliases and constructors
├── core/               # SDK core — client, types, pipeline
├── entity/             # Entity implementations
├── feature/            # Built-in features (Base, Test, Log)
├── utility/            # Utility functions and struct library
└── test/               # Test suites
```

The root package (`github.com/voxgig-sdk/musicbrainz-sdk/go`) re-exports everything needed
for normal use. Import sub-packages only when you need specific types
like `core.ToMapAny`.

### Entity state

Entity instances are stateful. After a successful `List`, the entity
stores the returned data and match criteria internally.

```go
series := client.Series(nil)
series.List(nil, nil)

// series.Data() now returns the series data from the last list
// series.Match() returns the last match criteria
```

Call `Make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`Direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `Prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
