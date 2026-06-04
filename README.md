# Musicbrainz SDK

Query the open MusicBrainz music metadata database for artists, releases, recordings and related entities

> TypeScript, Python, PHP, Golang, Ruby, Lua SDKs, a CLI, an interactive REPL, and an MCP server for AI agents — all generated from one OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).

## About MusicBrainz API

[MusicBrainz](https://musicbrainz.org/) is an open, community-maintained encyclopedia of music metadata operated by the [MetaBrainz Foundation](https://metabrainz.org/). The web service at `https://musicbrainz.org/ws/2/` exposes the database as a REST API returning XML or JSON, designed for media players, taggers, CD rippers and similar applications.

What you get from the API:

- **Lookup** a single entity by its MusicBrainz Identifier (MBID).
- **Browse** entities linked to another entity (e.g. releases by an artist).
- **Search** with Lucene-style queries across the catalogue.
- **Non-MBID lookups** by `discid`, `ISRC` or `ISWC`.
- **Submission** of tags, ratings, barcodes and ISRCs via authenticated POST.

Operational notes:

- Strict rate limit: at most **one request per second** per client/IP — exceeding this can lead to blocking.
- Set a descriptive `User-Agent` identifying your application and contact info.
- Authentication uses **OAuth2** or HTTP digest over HTTPS for user-specific reads and submissions; anonymous access is fine for most lookups.

## Try it

**TypeScript**
```bash
npm install musicbrainz
```

**Python**
```bash
pip install musicbrainz-sdk
```

**PHP**
```bash
composer require voxgig/musicbrainz-sdk
```

**Golang**
```bash
go get github.com/voxgig-sdk/musicbrainz-sdk/go
```

**Ruby**
```bash
gem install musicbrainz-sdk
```

**Lua**
```bash
luarocks install musicbrainz-sdk
```

## 30-second quickstart

### TypeScript

```ts
import { MusicbrainzSDK } from 'musicbrainz'

const client = new MusicbrainzSDK({})

// List all areas
const areas = await client.Area().list()
```

See the [TypeScript README](ts/README.md) for the
full guide, or scroll down for the same example in other languages.

## What's in the box

| Surface | Use it for | Path |
| --- | --- | --- |
| **SDK** (TypeScript, Python, PHP, Golang, Ruby, Lua) | App integration | `ts/` `py/` `php/` `go/` `rb/` `lua/` |
| **CLI** | Scripts, CI, ops, one-off API calls | `go-cli/` |
| **MCP server** | AI agents (Claude, Cursor, Cline) | `go-mcp/` |

## Use it from an AI agent (MCP)

The generated MCP server exposes every operation in this SDK as an
[MCP](https://modelcontextprotocol.io) tool that Claude, Cursor or Cline
can call directly. Build and register it:

```bash
cd go-mcp && go build -o musicbrainz-mcp .
```

Then add it to your agent's MCP config (Claude Desktop, Cursor, etc.):

```json
{
  "mcpServers": {
    "musicbrainz": {
      "command": "/abs/path/to/musicbrainz-mcp"
    }
  }
}
```

## Entities

The API exposes 19 entities:

| Entity | Description | API path |
| --- | --- | --- |
| **Area** | A geographic area (country, city, subdivision) used to place artists, labels and events — `/area/{mbid}`. | `/area` |
| **Artist** | A musician, group, orchestra or other performing entity — `/artist/{mbid}`. | `/artist` |
| **Collection** | A user-curated set of entities (non-core resource) — `/collection/{mbid}`. | `/collection` |
| **Event** | A concert, festival or other music event — `/event/{mbid}`. | `/event` |
| **Genre** | A musical genre vocabulary term — `/genre/{mbid}`. | `/genre/all` |
| **Instrument** | A musical instrument used in recordings or by artists — `/instrument/{mbid}`. | `/instrument` |
| **Label** | A record label or imprint that issues releases — `/label/{mbid}`. | `/label` |
| **Place** | A specific venue, studio or other physical place — `/place/{mbid}`. | `/place` |
| **Rating** | User ratings attached to core entities (non-core resource), submittable via authenticated POST. | `/rating` |
| **Recording** | A distinct audio recording (a track as performed/captured) — `/recording/{mbid}`. | `/recording` |
| **RecordingList** | A list result of recordings, e.g. from browse or search queries on recordings. | `/isrc/{isrc}` |
| **Release** | A specific issuance of an album, single or other product (with format, country, date) — `/release/{mbid}`. | `/release` |
| **ReleaseGroup** | An abstract grouping of related releases (e.g. all editions of an album) — `/release-group/{mbid}`. | `/release-group` |
| **ReleaseList** | A list result of releases, e.g. from browse or search queries on releases. | `/discid/{discid}` |
| **Series** | An ordered series of releases, recordings, works or events — `/series/{mbid}`. | `/series` |
| **Tag** | Free-form folksonomy tags applied to entities (non-core resource), submittable via authenticated POST. | `/tag` |
| **Url** | A URL resource linking entities to external web pages — `/url/{mbid}`. | `/url` |
| **Work** | A distinct musical work or composition, separate from any one recording — `/work/{mbid}`. | `/work` |
| **WorkList** | A list result of works, e.g. from browse or search queries on works. | `/iswc/{iswc}` |

Each entity supports the following operations where available: **load**,
**list**, **create**, **update**, and **remove**.

## Quickstart in other languages

### Python

```python
from musicbrainz_sdk import MusicbrainzSDK

client = MusicbrainzSDK({})

# List all areas
areas, err = client.Area(None).list(None, None)

# Load a specific area
area, err = client.Area(None).load(
    {"id": "example_id"}, None
)
```

### PHP

```php
<?php
require_once 'musicbrainz_sdk.php';

$client = new MusicbrainzSDK([]);

// List all areas
[$areas, $err] = $client->Area(null)->list(null, null);

// Load a specific area
[$area, $err] = $client->Area(null)->load(
    ["id" => "example_id"], null
);
```

### Golang

```go
import sdk "github.com/voxgig-sdk/musicbrainz-sdk/go"

client := sdk.NewMusicbrainzSDK(map[string]any{})

// List all areas
areas, err := client.Area(nil).List(nil, nil)
```

### Ruby

```ruby
require_relative "Musicbrainz_sdk"

client = MusicbrainzSDK.new({})

# List all areas
areas, err = client.Area(nil).list(nil, nil)

# Load a specific area
area, err = client.Area(nil).load(
  { "id" => "example_id" }, nil
)
```

### Lua

```lua
local sdk = require("musicbrainz_sdk")

local client = sdk.new({})

-- List all areas
local areas, err = client:Area(nil):list(nil, nil)

-- Load a specific area
local area, err = client:Area(nil):load(
  { id = "example_id" }, nil
)
```

## Unit testing in offline mode

Every SDK ships a test mode that swaps the HTTP transport for an
in-memory mock, so unit tests run offline.

### TypeScript

```ts
const client = MusicbrainzSDK.test()
const result = await client.Area().load({ id: 'test01' })
// result.ok === true, result.data contains mock data
```

### Python

```python
client = MusicbrainzSDK.test(None, None)
result, err = client.Area(None).load(
    {"id": "test01"}, None
)
```

### PHP

```php
$client = MusicbrainzSDK::test(null, null);
[$result, $err] = $client->Area(null)->load(
    ["id" => "test01"], null
);
```

### Golang

```go
client := sdk.TestSDK(nil, nil)
result, err := client.Area(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Ruby

```ruby
client = MusicbrainzSDK.test(nil, nil)
result, err = client.Area(nil).load(
  { "id" => "test01" }, nil
)
```

### Lua

```lua
local client = sdk.test(nil, nil)
local result, err = client:Area(nil):load(
  { id = "test01" }, nil
)
```

## How it works

Every SDK call runs the same five-stage pipeline:

1. **Point** — resolve the API endpoint from the operation definition.
2. **Spec** — build the HTTP specification (URL, method, headers, body).
3. **Request** — send the HTTP request.
4. **Response** — receive and parse the response.
5. **Result** — extract the result data for the caller.

A feature hook fires at each stage (e.g. `PrePoint`, `PreSpec`,
`PreRequest`), so features can inspect or modify the pipeline without
forking the SDK.

### Features

| Feature | Purpose |
| --- | --- |
| **TestFeature** | In-memory mock transport for testing without a live server |

Pass custom features via the `extend` option at construction time.

### Direct and Prepare

For endpoints the entity model doesn't cover, use the low-level methods:

- **`direct(fetchargs)`** — build and send an HTTP request in one step.
- **`prepare(fetchargs)`** — build the request without sending it.

Both accept a map with `path`, `method`, `params`, `query`,
`headers`, and `body`. See the [How-to guides](#how-to-guides) below.

## How-to guides

### Make a direct API call

When the entity interface does not cover an endpoint, use `direct`:

**TypeScript:**
```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})
console.log(result.data)
```

**Python:**
```python
result, err = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})
```

**PHP:**
```php
[$result, $err] = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);
```

**Go:**
```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
```

**Ruby:**
```ruby
result, err = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})
```

**Lua:**
```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
```

## Per-language documentation

- [TypeScript](ts/README.md)
- [Python](py/README.md)
- [PHP](php/README.md)
- [Golang](go/README.md)
- [Ruby](rb/README.md)
- [Lua](lua/README.md)

## Using the MusicBrainz API

- Upstream: [https://musicbrainz.org/](https://musicbrainz.org/)
- API docs: [https://musicbrainz.org/doc/MusicBrainz_API](https://musicbrainz.org/doc/MusicBrainz_API)

- Operated by the [MetaBrainz Foundation](https://metabrainz.org/), a non-profit.
- Core database released under open licences (CC0 for core data; CC BY-NC-SA for some supplementary data) — see [Data Licenses](https://musicbrainz.org/doc/About/Data_License).
- Non-commercial use is free; commercial users should arrange a licence with MetaBrainz.
- Attribution to MusicBrainz is expected when redistributing data.

---

Generated from the MusicBrainz API OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).
