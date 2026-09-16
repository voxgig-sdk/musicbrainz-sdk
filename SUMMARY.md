# MusicBrainz API

The MusicBrainz API provides developers with access to the MusicBrainz Database, an extensive collection of music metadata. Designed for media applications like players and taggers, it utilizes REST principles and supports content in XML and JSON formats for easy integration.

## Start here

This guide introduces the API, the client libraries, and the companion tools in this repository. Start with the API capabilities, choose a client for your application, and use the linked reference when you need exact request and response details.

The selected API surface contains 19 entities and 34 HTTP routes. There are 6 SDK targets and 2 companion tools.

An entity groups related API operations. An operation can have several routes with different inputs or authentication requirements. The SDK exposes the entity and its operations using the conventions of the selected language.

## What the API provides

### Area

Results: Successful area list response; Successful area lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `begin`: Begin date
- `disambiguation`: Disambiguation comment
- `end`: End date
- `ended`: Whether the entity has ended
- `id`: MusicBrainz ID

### Artist

Results: Successful artist list response; Successful artist lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `begin`: Begin date
- `country`: Country code
- `disambiguation`: Disambiguation comment
- `end`: End date
- `ended`: Whether the entity has ended

### Collection

Results: Successful collection list response.

SDK operations: `list`.

### Event

Results: Successful event list response; Successful event lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `begin`: Begin date
- `cancelled`: Whether the event was cancelled
- `disambiguation`: Disambiguation comment
- `end`: End date
- `ended`: Whether the entity has ended

### Genre

Results: Successful response; Successful genre lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `disambiguation`: Disambiguation comment
- `id`: MusicBrainz ID
- `name`: Genre name

### Instrument

Results: Successful instrument list response; Successful instrument lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `description`: Instrument description
- `disambiguation`: Disambiguation comment
- `id`: MusicBrainz ID
- `name`: Instrument name
- `type`: Instrument type

### Label

Results: Successful label list response; Successful label lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `begin`: Begin date
- `country`: Country code
- `disambiguation`: Disambiguation comment
- `end`: End date
- `ended`: Whether the entity has ended

### Place

Results: Successful place list response; Successful place lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `address`: Place address
- `disambiguation`: Disambiguation comment
- `id`: MusicBrainz ID
- `name`: Place name
- `type`: Place type

### Rating

Results: Rating submitted successfully; Successful response with ratings.

SDK operations: `create`, `load`.

### Recording

Results: Successful recording list response; Successful recording lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `disambiguation`: Disambiguation comment
- `id`: MusicBrainz ID
- `length`: Duration in milliseconds
- `title`: Recording title
- `video`: Whether this is a video recording

### RecordingList

Results: Successful recording list response.

SDK operations: `load`.

### Release

Results: Successful release list response; Successful release lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `barcode`: Barcode
- `country`: Release country
- `date`: Release date
- `disambiguation`: Disambiguation comment
- `id`: MusicBrainz ID

### ReleaseGroup

Results: Successful release group list response; Successful release group lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `disambiguation`: Disambiguation comment
- `firstreleasedate`: Date of first release
- `id`: MusicBrainz ID
- `primarytype`: Primary type (album, single, ep, broadcast, other)
- `secondarytypes`: Secondary types (compilation, soundtrack, etc.)

### ReleaseList

Results: Successful release list response.

SDK operations: `load`.

### Series

Results: Successful series list response; Successful series lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `disambiguation`: Disambiguation comment
- `id`: MusicBrainz ID
- `name`: Series name
- `type`: Series type

### Tag

Results: Tags submitted successfully; Successful response with tags.

SDK operations: `create`, `load`.

### Url

Results: Successful URL list response; Successful URL lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `id`: MusicBrainz ID
- `resource`: The URL resource

### Work

Results: Successful work list response; Successful work lookup.

SDK operations: `list`, `load`.

Key fields to recognise:

- `disambiguation`: Disambiguation comment
- `id`: MusicBrainz ID
- `language`: Language code
- `title`: Work title
- `type`: Work type

### WorkList

Results: Successful work list response.

SDK operations: `load`.

### Route map

Use this map to locate a capability. Consult the entity reference before supplying request data; routes for the same operation can require different fields.

| Entity | SDK operation | HTTP route | Authentication |
| --- | --- | --- | --- |
| Area | `list` | `GET /area` | Not required |
| Area | `load` | `GET /area/{mbid}` | Not required |
| Artist | `list` | `GET /artist` | Not required |
| Artist | `load` | `GET /artist/{mbid}` | Not required |
| Collection | `list` | `GET /collection` | Required |
| Event | `list` | `GET /event` | Not required |
| Event | `load` | `GET /event/{mbid}` | Not required |
| Genre | `list` | `GET /genre/all` | Not required |
| Genre | `load` | `GET /genre/{mbid}` | Not required |
| Instrument | `list` | `GET /instrument` | Not required |
| Instrument | `load` | `GET /instrument/{mbid}` | Not required |
| Label | `list` | `GET /label` | Not required |
| Label | `load` | `GET /label/{mbid}` | Not required |
| Place | `list` | `GET /place` | Not required |
| Place | `load` | `GET /place/{mbid}` | Not required |
| Rating | `create` | `POST /rating` | Required |
| Rating | `load` | `GET /rating` | Required |
| Recording | `list` | `GET /recording` | Not required |
| Recording | `load` | `GET /recording/{mbid}` | Not required |
| RecordingList | `load` | `GET /isrc/{isrc}` | Not required |
| Release | `list` | `GET /release` | Not required |
| Release | `load` | `GET /release/{mbid}` | Not required |
| ReleaseGroup | `list` | `GET /release-group` | Not required |
| ReleaseGroup | `load` | `GET /release-group/{mbid}` | Not required |
| ReleaseList | `load` | `GET /discid/{discid}` | Not required |
| Series | `list` | `GET /series` | Not required |
| Series | `load` | `GET /series/{mbid}` | Not required |
| Tag | `create` | `POST /tag` | Required |
| Tag | `load` | `GET /tag` | Required |
| Url | `list` | `GET /url` | Not required |
| Url | `load` | `GET /url/{mbid}` | Not required |
| Work | `list` | `GET /work` | Not required |
| Work | `load` | `GET /work/{mbid}` | Not required |
| WorkList | `load` | `GET /iswc/{iswc}` | Not required |

## Connect to the API

- MusicBrainz API v2 Production Server: `https://musicbrainz.org/ws/2`

The default credential is sent in the `Authorization` header with the `Bearer` prefix.

Digest authentication using MusicBrainz username and password over HTTPS

OAuth 2.0 authentication

Check authentication for the route you plan to call. A route that declares no authentication can be used without credentials; this does not change the requirements of other routes. Keep credentials in environment variables or a configured secret provider, and keep them out of source control and logs.

## Make a first request

1. Choose the API server and an operation that matches your task.
2. Check the operation’s required input and authentication. Use values valid for your account and environment.
3. Send one request and inspect the returned data before adding retries, concurrency, or a larger batch.

A read request without required parameters or authentication is `GET /area`. For example:

```sh
curl --fail-with-body --silent --show-error 'https://musicbrainz.org/ws/2/area'
```

Inspect the response using the Area reference. This checks the public route; authenticated operations need their own credentials and request data.

For an SDK call, install or build the chosen client, create a client instance with its documented configuration, and call the required entity operation. Language references describe the argument shape, asynchronous behaviour, and returned values.

## Choose an SDK

Choose the language already used by your application or service. The clients represent the same API model, while package setup, naming, and return types follow each language. Check the selected client’s reference and tests before integrating it into an existing application.

| Client | Repository directory | Distribution |
| --- | --- | --- |
| Golang | `go/` | Build from source |
| Lua | `lua/` | Build from source |
| PHP | `php/` | Build from source |
| Python | `py/` | Build from source |
| Ruby | `rb/` | Build from source |
| TypeScript | `ts/` | Build from source |

Build-from-source entries are not marked as published in the project model. Follow the build instructions in that target’s README, then consume the resulting package using your language’s local dependency mechanism. Published entries give the installation command recorded for that client.

## Companion tools

These targets provide another way to use the API. Their available commands or tools can cover a smaller set of operations than the client libraries.

### Go CLI

Use the command-line interface for shell-based tasks and scripts.

Repository directory: `go-cli/`. Not published. Build from the go-cli directory.


### Go MCP server

Use the MCP server to expose supported API operations to an MCP client.

Repository directory: `go-mcp/`. Not published. Build from the go-mcp directory.

- `musicbrainz_list`: List records for an entity. Supported entities: `area`, `artist`, `collection`, `event`, `genre`, `instrument`, `label`, `place`, `recording`, `release`, `release_group`, `series`, `url`, `work`.
- `musicbrainz_load`: Load one record for an entity. Supported entities: `area`, `artist`, `event`, `genre`, `instrument`, `label`, `place`, `rating`, `recording`, `recording_list`, `release`, `release_group`, `release_list`, `series`, `tag`, `url`, `work`, `work_list`.

## Operational features

Features supply behaviour around API calls, such as request handling, diagnostics, or local testing. Inclusion in this project does not mean a feature is enabled at runtime. Check the selected SDK’s supported features and configuration defaults, then enable the behaviour your application needs.

- `ratelimit`: Client-side rate limiting via a token bucket
- `retry`: Automatic retry of transient failures with exponential backoff
- `test`: In-memory mock transport for testing without a live server
- `timeout`: Per-request timeout with transport abort

Start with the default client configuration. Add request limits and diagnostics as needed, test error paths, and review retry behaviour before using operations that change data. A retry can repeat an operation unless the API provides a suitable guarantee.

## Continue with the documentation

- Follow the first-call guide for the setup sequence.
- Read the authentication guide before using protected routes.
- Use the API reference for request schemas, response formats, and status codes.
- Check the chosen SDK or companion tool reference for its configuration and supported operations.

