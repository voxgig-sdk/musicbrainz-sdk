# Musicbrainz Golang SDK



The Golang SDK for the Musicbrainz API — an entity-oriented client using standard Go conventions. No generics required; data flows as `map[string]any`.

> Other languages, the CLI, and MCP server live alongside this one — see
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

area, err := client.Area(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
if err != nil {
    panic(err)
}
fmt.Println(area) // the loaded mock data
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
| `Update` | `(reqdata, ctrl map[string]any) (any, error)` | Update an existing entity. |
| `Remove` | `(reqmatch, ctrl map[string]any) (any, error)` | Remove an entity. |
| `Data` | `(args ...any) any` | Get or set entity data. |
| `Match` | `(args ...any) any` | Get or set entity match criteria. |
| `Make` | `() Entity` | Create a new instance with the same options. |
| `GetName` | `() string` | Return the entity name. |

### Result shape

Entity operations return `(value, error)`. The `value` is the
operation's data **directly** — there is no wrapper:

| Operation | `value` |
| --- | --- |
| `Load` / `Create` / `Update` / `Remove` | the entity record (`map[string]any`) |
| `List` | a `[]any` of entity records |

Check `err` first, then use the value directly (or the typed
`...Typed` variants, which return the entity's model struct and a typed
slice):

    area, err := client.Area(nil).Load(map[string]any{"id": "example_id"}, nil)
    if err != nil { /* handle */ }
    // area is the loaded record

Only `Direct()` returns a response envelope — a `map[string]any` with
`"ok"`, `"status"`, `"headers"`, and `"data"` keys.

### Entities

#### Area

| Field | Description |
| --- | --- |
| `"disambiguation"` |  |
| `"id"` |  |
| `"life_span"` |  |
| `"name"` |  |
| `"sort_name"` |  |
| `"type"` |  |

Operations: List, Load.

API path: `/area`

#### Artist

| Field | Description |
| --- | --- |
| `"country"` |  |
| `"disambiguation"` |  |
| `"gender"` |  |
| `"id"` |  |
| `"life_span"` |  |
| `"name"` |  |
| `"sort_name"` |  |
| `"type"` |  |

Operations: List, Load.

API path: `/artist`

#### Collection

| Field | Description |
| --- | --- |
| `"editor"` |  |
| `"entity_type"` |  |
| `"id"` |  |
| `"name"` |  |

Operations: List.

API path: `/collection`

#### Event

| Field | Description |
| --- | --- |
| `"cancelled"` |  |
| `"disambiguation"` |  |
| `"id"` |  |
| `"life_span"` |  |
| `"name"` |  |
| `"time"` |  |
| `"type"` |  |

Operations: List, Load.

API path: `/event`

#### Genre

| Field | Description |
| --- | --- |
| `"disambiguation"` |  |
| `"id"` |  |
| `"name"` |  |

Operations: List, Load.

API path: `/genre/all`

#### Instrument

| Field | Description |
| --- | --- |
| `"description"` |  |
| `"disambiguation"` |  |
| `"id"` |  |
| `"name"` |  |
| `"type"` |  |

Operations: List, Load.

API path: `/instrument`

#### Label

| Field | Description |
| --- | --- |
| `"country"` |  |
| `"disambiguation"` |  |
| `"id"` |  |
| `"label_code"` |  |
| `"life_span"` |  |
| `"name"` |  |
| `"sort_name"` |  |
| `"type"` |  |

Operations: List, Load.

API path: `/label`

#### Place

| Field | Description |
| --- | --- |
| `"address"` |  |
| `"coordinate"` |  |
| `"disambiguation"` |  |
| `"id"` |  |
| `"life_span"` |  |
| `"name"` |  |
| `"type"` |  |

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
| `"disambiguation"` |  |
| `"id"` |  |
| `"length"` |  |
| `"title"` |  |
| `"video"` |  |

Operations: List, Load.

API path: `/recording`

#### RecordingList

| Field | Description |
| --- | --- |
| `"count"` |  |
| `"offset"` |  |
| `"recording"` |  |

Operations: Load.

API path: `/isrc/{isrc}`

#### Release

| Field | Description |
| --- | --- |
| `"barcode"` |  |
| `"country"` |  |
| `"date"` |  |
| `"disambiguation"` |  |
| `"id"` |  |
| `"packaging"` |  |
| `"status"` |  |
| `"title"` |  |

Operations: List, Load.

API path: `/release`

#### ReleaseGroup

| Field | Description |
| --- | --- |
| `"disambiguation"` |  |
| `"first_release_date"` |  |
| `"id"` |  |
| `"primary_type"` |  |
| `"secondary_type"` |  |
| `"title"` |  |

Operations: List, Load.

API path: `/release-group`

#### ReleaseList

| Field | Description |
| --- | --- |
| `"count"` |  |
| `"offset"` |  |
| `"release"` |  |

Operations: Load.

API path: `/discid/{discid}`

#### Series

| Field | Description |
| --- | --- |
| `"disambiguation"` |  |
| `"id"` |  |
| `"name"` |  |
| `"type"` |  |

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
| `"id"` |  |
| `"resource"` |  |

Operations: List, Load.

API path: `/url`

#### Work

| Field | Description |
| --- | --- |
| `"disambiguation"` |  |
| `"id"` |  |
| `"language"` |  |
| `"title"` |  |
| `"type"` |  |

Operations: List, Load.

API path: `/work`

#### WorkList

| Field | Description |
| --- | --- |
| `"count"` |  |
| `"offset"` |  |
| `"work"` |  |

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
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `life_span` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `sort_name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

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
| `country` | ``$STRING`` |  |
| `disambiguation` | ``$STRING`` |  |
| `gender` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `life_span` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `sort_name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

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
| `editor` | ``$STRING`` |  |
| `entity_type` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `name` | ``$STRING`` |  |

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
| `cancelled` | ``$BOOLEAN`` |  |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `life_span` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `time` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

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
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `name` | ``$STRING`` |  |

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
| `description` | ``$STRING`` |  |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

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
| `country` | ``$STRING`` |  |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `label_code` | ``$INTEGER`` |  |
| `life_span` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `sort_name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

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
| `address` | ``$STRING`` |  |
| `coordinate` | ``$OBJECT`` |  |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `life_span` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

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
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```go
rating, err := client.Rating(nil).Load(map[string]any{"id": "rating_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(rating) // the loaded record
```

#### Example: Create

```go
result, err := client.Rating(nil).Create(map[string]any{
}, nil)
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
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `length` | ``$INTEGER`` |  |
| `title` | ``$STRING`` |  |
| `video` | ``$BOOLEAN`` |  |

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

Create an instance: `recording_list := client.RecordingList(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | ``$INTEGER`` |  |
| `offset` | ``$INTEGER`` |  |
| `recording` | ``$ARRAY`` |  |

#### Example: Load

```go
recording_list, err := client.RecordingList(nil).Load(map[string]any{"id": "recording_list_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(recording_list) // the loaded record
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
| `barcode` | ``$STRING`` |  |
| `country` | ``$STRING`` |  |
| `date` | ``$STRING`` |  |
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `packaging` | ``$STRING`` |  |
| `status` | ``$STRING`` |  |
| `title` | ``$STRING`` |  |

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

Create an instance: `release_group := client.ReleaseGroup(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

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

```go
release_group, err := client.ReleaseGroup(nil).Load(map[string]any{"id": "release_group_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(release_group) // the loaded record
```

#### Example: List

```go
release_groups, err := client.ReleaseGroup(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(release_groups) // the array of records
```


### ReleaseList

Create an instance: `release_list := client.ReleaseList(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | ``$INTEGER`` |  |
| `offset` | ``$INTEGER`` |  |
| `release` | ``$ARRAY`` |  |

#### Example: Load

```go
release_list, err := client.ReleaseList(nil).Load(map[string]any{"id": "release_list_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(release_list) // the loaded record
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
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `name` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

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
| `Create(data, ctrl)` | Create a new entity with the given data. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```go
tag, err := client.Tag(nil).Load(map[string]any{"id": "tag_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(tag) // the loaded record
```

#### Example: Create

```go
result, err := client.Tag(nil).Create(map[string]any{
}, nil)
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
| `id` | ``$STRING`` |  |
| `resource` | ``$STRING`` |  |

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
| `disambiguation` | ``$STRING`` |  |
| `id` | ``$STRING`` |  |
| `language` | ``$STRING`` |  |
| `title` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |

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

Create an instance: `work_list := client.WorkList(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `count` | ``$INTEGER`` |  |
| `offset` | ``$INTEGER`` |  |
| `work` | ``$ARRAY`` |  |

#### Example: Load

```go
work_list, err := client.WorkList(nil).Load(map[string]any{"id": "work_list_id"}, nil)
if err != nil {
    panic(err)
}
fmt.Println(work_list) // the loaded record
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
error is returned to the caller. An unexpected panic triggers the
`PreUnexpected` hook.

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

Entity instances are stateful. After a successful `Load`, the entity
stores the returned data and match criteria internally.

```go
area := client.Area(nil)
area.Load(map[string]any{"id": "example_id"}, nil)

// area.Data() now returns the loaded area data
// area.Match() returns the last match criteria
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
