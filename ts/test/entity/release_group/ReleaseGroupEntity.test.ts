

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { MusicbrainzSDK, BaseFeature, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


// AFTER the imports on purpose: TypeScript hoists `import` above any
// statement in the emitted CommonJS, so a loader placed above them would
// run only after every imported module had already been evaluated - and
// anything reading process.env at module scope would miss these values.
loadEnvLocal(__dirname + '/../../../.env.local')


describe('ReleaseGroupEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when MUSICBRAINZ_TEST_LIVE=TRUE.
  afterEach(liveDelay('MUSICBRAINZ_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = MusicbrainzSDK.test()
    const ent = testsdk.ReleaseGroup()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.MUSICBRAINZ_TEST_LIVE
    for (const op of ['list', 'load']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'release_group.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"name":"disambiguation","req":false,"short":"Disambiguation comment","type":"`$STRING`","index$":0},{"active":true,"name":"firstreleasedate","req":false,"short":"Date of first release","type":"`$STRING`","index$":1},{"active":true,"format":"uuid","name":"id","req":false,"short":"MusicBrainz ID","type":"`$STRING`","index$":2},{"active":true,"name":"primarytype","req":false,"short":"Primary type (album, single, ep, broadcast, other)","type":"`$STRING`","index$":3},{"active":true,"name":"secondarytypes","req":false,"short":"Secondary types (compilation, soundtrack, etc.)","type":"`$ARRAY`","index$":4},{"active":true,"name":"title","req":false,"short":"Release group title","type":"`$STRING`","index$":5}],"id":{"field":"id","name":"id"},"name":"release_group","op":{"list":{"input":"data","name":"list","points":[{"active":true,"args":{"query":[{"active":true,"kind":"query","name":"artist","orig":"artist","reqd":false,"type":"`$STRING`","index$":0},{"active":true,"kind":"query","name":"collection","orig":"collection","reqd":false,"type":"`$STRING`","index$":1},{"active":true,"example":"xml","kind":"query","name":"fmt","orig":"fmt","reqd":false,"type":"`$STRING`","index$":2},{"active":true,"example":"artist-credits+genres","kind":"query","name":"inc","orig":"inc","reqd":false,"type":"`$STRING`","index$":3},{"active":true,"example":25,"kind":"query","name":"limit","orig":"limit","reqd":false,"type":"`$INTEGER`","index$":4},{"active":true,"example":0,"kind":"query","name":"offset","orig":"offset","reqd":false,"type":"`$INTEGER`","index$":5},{"active":true,"kind":"query","name":"query","orig":"query","reqd":false,"type":"`$STRING`","index$":6},{"active":true,"kind":"query","name":"release","orig":"release","reqd":false,"type":"`$STRING`","index$":7},{"active":true,"kind":"query","name":"type","orig":"type","reqd":false,"type":"`$STRING`","index$":8}]},"contract":{"id":"GET /release-group","json":"{\"operationId\":\"searchOrBrowseReleaseGroup\",\"parameters\":[{\"description\":\"Search query string. See search documentation for query syntax.\",\"in\":\"query\",\"name\":\"query\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Maximum number of results to return (maximum 100, default 25)\",\"in\":\"query\",\"name\":\"limit\",\"schema\":{\"default\":25,\"maximum\":100,\"minimum\":1,\"type\":\"integer\"}},{\"description\":\"Number of results to skip (for pagination)\",\"in\":\"query\",\"name\":\"offset\",\"schema\":{\"default\":0,\"minimum\":0,\"type\":\"integer\"}},{\"description\":\"Include additional information. Separate multiple values with '+'. Options include: aliases, annotation, tags, ratings, user-tags, user-ratings, genres, user-genres, releases, recordings, release-groups, works, labels, collections, discids, media, isrcs, artist-credits, various-artists, area-rels, artist-rels, event-rels, genre-rels, instrument-rels, label-rels, place-rels, recording-rels, release-rels, release-group-rels, series-rels, url-rels, work-rels, recording-level-rels, release-group-level-rels, work-level-rels\",\"example\":\"artist-credits+genres\",\"in\":\"query\",\"name\":\"inc\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Artist MBID for browsing\",\"in\":\"query\",\"name\":\"artist\",\"schema\":{\"format\":\"uuid\",\"type\":\"string\"}},{\"description\":\"Collection MBID for browsing\",\"in\":\"query\",\"name\":\"collection\",\"schema\":{\"format\":\"uuid\",\"type\":\"string\"}},{\"description\":\"Release MBID for browsing\",\"in\":\"query\",\"name\":\"release\",\"schema\":{\"format\":\"uuid\",\"type\":\"string\"}},{\"description\":\"Filter by release or release-group type (e.g., album, single, ep, broadcast, other)\",\"in\":\"query\",\"name\":\"type\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Response format\",\"in\":\"query\",\"name\":\"fmt\",\"schema\":{\"default\":\"xml\",\"enum\":[\"json\",\"xml\"],\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"count\":{\"type\":\"integer\"},\"offset\":{\"type\":\"integer\"},\"release-groups\":{\"items\":{\"properties\":{\"disambiguation\":{\"description\":\"Disambiguation comment\",\"type\":\"string\"},\"first-release-date\":{\"description\":\"Date of first release\",\"type\":\"string\"},\"id\":{\"description\":\"MusicBrainz ID\",\"format\":\"uuid\",\"type\":\"string\"},\"primary-type\":{\"description\":\"Primary type (album, single, ep, broadcast, other)\",\"type\":\"string\"},\"secondary-types\":{\"description\":\"Secondary types (compilation, soundtrack, etc.)\",\"items\":{\"type\":\"string\"},\"type\":\"array\"},\"title\":{\"description\":\"Release group title\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"count\":{\"type\":\"integer\"},\"offset\":{\"type\":\"integer\"},\"release-groups\":{\"items\":{\"properties\":{\"disambiguation\":{\"description\":\"Disambiguation comment\",\"type\":\"string\"},\"first-release-date\":{\"description\":\"Date of first release\",\"type\":\"string\"},\"id\":{\"description\":\"MusicBrainz ID\",\"format\":\"uuid\",\"type\":\"string\"},\"primary-type\":{\"description\":\"Primary type (album, single, ep, broadcast, other)\",\"type\":\"string\"},\"secondary-types\":{\"description\":\"Secondary types (compilation, soundtrack, etc.)\",\"items\":{\"type\":\"string\"},\"type\":\"array\"},\"title\":{\"description\":\"Release group title\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"}}},\"description\":\"Successful release group list response\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request - invalid parameters or query\"},\"503\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Rate limit exceeded - maximum 1 request per second\"}},\"security\":[],\"securitySchemes\":{\"digestAuth\":{\"description\":\"Digest authentication using MusicBrainz username and password over HTTPS\",\"scheme\":\"digest\",\"type\":\"http\"},\"oauth2\":{\"description\":\"OAuth 2.0 authentication\",\"flows\":{\"authorizationCode\":{\"authorizationUrl\":\"https://musicbrainz.org/oauth2/authorize\",\"scopes\":{\"collection\":\"Manage collections\",\"email\":\"Access user email\",\"profile\":\"Access user profile information\",\"rating\":\"Submit ratings\",\"submit_barcode\":\"Submit barcodes\",\"submit_isrc\":\"Submit ISRCs\",\"tag\":\"Submit tags\"},\"tokenUrl\":\"https://musicbrainz.org/oauth2/token\"}},\"type\":\"oauth2\"}},\"securitySource\":\"definition\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/release-group","segments":[{"lit":"release-group"}],"select":{"exist":["artist","collection","fmt","inc","limit","offset","query","release","type"]},"transform":{"req":"`reqdata`","res":"`body.release-groups`"},"index$":0}],"key$":"list"},"load":{"input":"data","name":"load","points":[{"active":true,"args":{"params":[{"active":true,"kind":"param","name":"id","orig":"mbid","reqd":true,"type":"`$STRING`","index$":0}],"query":[{"active":true,"example":"xml","kind":"query","name":"fmt","orig":"fmt","reqd":false,"type":"`$STRING`","index$":0},{"active":true,"example":"artist-credits+genres","kind":"query","name":"inc","orig":"inc","reqd":false,"type":"`$STRING`","index$":1},{"active":true,"kind":"query","name":"status","orig":"status","reqd":false,"type":"`$STRING`","index$":2},{"active":true,"kind":"query","name":"type","orig":"type","reqd":false,"type":"`$STRING`","index$":3}]},"contract":{"id":"GET /release-group/{mbid}","json":"{\"operationId\":\"lookupReleaseGroup\",\"parameters\":[{\"description\":\"MusicBrainz ID (UUID format)\",\"in\":\"path\",\"name\":\"mbid\",\"required\":true,\"schema\":{\"format\":\"uuid\",\"pattern\":\"^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$\",\"type\":\"string\"}},{\"description\":\"Include additional information. Separate multiple values with '+'. Options include: aliases, annotation, tags, ratings, user-tags, user-ratings, genres, user-genres, releases, recordings, release-groups, works, labels, collections, discids, media, isrcs, artist-credits, various-artists, area-rels, artist-rels, event-rels, genre-rels, instrument-rels, label-rels, place-rels, recording-rels, release-rels, release-group-rels, series-rels, url-rels, work-rels, recording-level-rels, release-group-level-rels, work-level-rels\",\"example\":\"artist-credits+genres\",\"in\":\"query\",\"name\":\"inc\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Filter by release or release-group type (e.g., album, single, ep, broadcast, other)\",\"in\":\"query\",\"name\":\"type\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Filter releases by status (e.g., official, promotion, bootleg, pseudo-release)\",\"in\":\"query\",\"name\":\"status\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Response format\",\"in\":\"query\",\"name\":\"fmt\",\"schema\":{\"default\":\"xml\",\"enum\":[\"json\",\"xml\"],\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"disambiguation\":{\"description\":\"Disambiguation comment\",\"type\":\"string\"},\"first-release-date\":{\"description\":\"Date of first release\",\"type\":\"string\"},\"id\":{\"description\":\"MusicBrainz ID\",\"format\":\"uuid\",\"type\":\"string\"},\"primary-type\":{\"description\":\"Primary type (album, single, ep, broadcast, other)\",\"type\":\"string\"},\"secondary-types\":{\"description\":\"Secondary types (compilation, soundtrack, etc.)\",\"items\":{\"type\":\"string\"},\"type\":\"array\"},\"title\":{\"description\":\"Release group title\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"disambiguation\":{\"description\":\"Disambiguation comment\",\"type\":\"string\"},\"first-release-date\":{\"description\":\"Date of first release\",\"type\":\"string\"},\"id\":{\"description\":\"MusicBrainz ID\",\"format\":\"uuid\",\"type\":\"string\"},\"primary-type\":{\"description\":\"Primary type (album, single, ep, broadcast, other)\",\"type\":\"string\"},\"secondary-types\":{\"description\":\"Secondary types (compilation, soundtrack, etc.)\",\"items\":{\"type\":\"string\"},\"type\":\"array\"},\"title\":{\"description\":\"Release group title\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Successful release group lookup\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request - invalid parameters or query\"},\"404\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Resource not found\"},\"503\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Rate limit exceeded - maximum 1 request per second\"}},\"security\":[],\"securitySchemes\":{\"digestAuth\":{\"description\":\"Digest authentication using MusicBrainz username and password over HTTPS\",\"scheme\":\"digest\",\"type\":\"http\"},\"oauth2\":{\"description\":\"OAuth 2.0 authentication\",\"flows\":{\"authorizationCode\":{\"authorizationUrl\":\"https://musicbrainz.org/oauth2/authorize\",\"scopes\":{\"collection\":\"Manage collections\",\"email\":\"Access user email\",\"profile\":\"Access user profile information\",\"rating\":\"Submit ratings\",\"submit_barcode\":\"Submit barcodes\",\"submit_isrc\":\"Submit ISRCs\",\"tag\":\"Submit tags\"},\"tokenUrl\":\"https://musicbrainz.org/oauth2/token\"}},\"type\":\"oauth2\"}},\"securitySource\":\"definition\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/release-group/{mbid}","rename":{"param":{"mbid":"id"}},"segments":[{"lit":"release-group"},{"var":"id"}],"select":{"exist":["fmt","id","inc","status","type"]},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"}},"relations":{"ancestors":[]},"key$":"release_group","name__orig":"release_group","Name":"ReleaseGroup","name_":"release_group","name-":"release-group","NAME":"RELEASE_GROUP","index$":12}, {"active":true,"entity":"release_group","key$":"BasicReleaseGroupFlow","kind":"basic","name":"BasicReleaseGroupFlow","param":{},"step":[{"active":true,"data":{},"input":{},"match":{},"op":"list","spec":[],"valid":[{"apply":"ItemExists","def":{"ref":"release_group_ref01"}}],"index$":0},{"active":true,"data":{},"input":{"ref":"release_group_ref01","srcdatavar":"release_group_ref01_data","suffix":"_dt0"},"match":{"id":"release_group01"},"op":"load","spec":[],"valid":[{"apply":"TextFieldMark","def":{"mark":"Mark01-release_group_ref01"}}],"index$":1}]}, 'ReleaseGroup')
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let release_group_ref01_data = Object.values(setup.data.existing.release_group)[0] as any

    // LIST
    const release_group_ref01_ent = client.ReleaseGroup()
    const release_group_ref01_match: any = {}

    const release_group_ref01_list = (await release_group_ref01_ent.list(release_group_ref01_match)).map((e: any) => e.data())


    // LOAD
    const release_group_ref01_match_dt0: any = {}
    release_group_ref01_match_dt0.id = release_group_ref01_data.id
    const release_group_ref01_data_dt0 = (await release_group_ref01_ent.load(release_group_ref01_match_dt0)).data()
    assert(release_group_ref01_data_dt0.id === release_group_ref01_data.id)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/release_group/ReleaseGroupTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = MusicbrainzSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['release_group01','release_group02','release_group03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'MUSICBRAINZ_TEST_RELEASE_GROUP_ENTID': idmap,
    'MUSICBRAINZ_TEST_LIVE': 'FALSE',
    'MUSICBRAINZ_TEST_EXPLAIN': 'FALSE',
    'MUSICBRAINZ_APIKEY': '',
  })

  idmap = env['MUSICBRAINZ_TEST_RELEASE_GROUP_ENTID']

  const live = 'TRUE' === env.MUSICBRAINZ_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['MUSICBRAINZ_TEST_RELEASE_GROUP_ENTID']
    idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {}
    if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
      throw new Error('Live ENTID must be a JSON object')
    }
    client = new MusicbrainzSDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
      {
        apikey: env.MUSICBRAINZ_APIKEY,
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
      // last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey
      // and server values above and handed the SDK undefined. Harmless
      // while there was nothing in that object; not harmless now.
      extra || {},
      { system: { fetch: transport.fetch } }
    ]))
  }

  const setup = {
    idmap,
    env,
    options,
    client,
    struct,
    data: entityData,
    explain: 'TRUE' === env.MUSICBRAINZ_TEST_EXPLAIN,
    live,
    transport,
    now: Date.now(),
  }

  return setup
}
  
