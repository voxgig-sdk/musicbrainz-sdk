

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


describe('RecordingEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when MUSICBRAINZ_TEST_LIVE=TRUE.
  afterEach(liveDelay('MUSICBRAINZ_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = MusicbrainzSDK.test()
    const ent = testsdk.Recording()
    assert(null != ent)
  })


  test('basic', async (t) => {

    const live = 'TRUE' === process.env.MUSICBRAINZ_TEST_LIVE
    for (const op of ['list', 'load']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'recording.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":[{"active":true,"name":"disambiguation","req":false,"short":"Disambiguation comment","type":"`$STRING`","index$":0},{"active":true,"format":"uuid","name":"id","req":false,"short":"MusicBrainz ID","type":"`$STRING`","index$":1},{"active":true,"name":"length","req":false,"short":"Duration in milliseconds","type":"`$INTEGER`","index$":2},{"active":true,"name":"title","req":false,"short":"Recording title","type":"`$STRING`","index$":3},{"active":true,"name":"video","req":false,"short":"Whether this is a video recording","type":"`$BOOLEAN`","index$":4}],"id":{"field":"id","name":"id"},"name":"recording","op":{"list":{"input":"data","name":"list","points":[{"active":true,"args":{"query":[{"active":true,"kind":"query","name":"artist","orig":"artist","reqd":false,"type":"`$STRING`","index$":0},{"active":true,"kind":"query","name":"collection","orig":"collection","reqd":false,"type":"`$STRING`","index$":1},{"active":true,"example":"xml","kind":"query","name":"fmt","orig":"fmt","reqd":false,"type":"`$STRING`","index$":2},{"active":true,"example":"artist-credits+genres","kind":"query","name":"inc","orig":"inc","reqd":false,"type":"`$STRING`","index$":3},{"active":true,"example":25,"kind":"query","name":"limit","orig":"limit","reqd":false,"type":"`$INTEGER`","index$":4},{"active":true,"example":0,"kind":"query","name":"offset","orig":"offset","reqd":false,"type":"`$INTEGER`","index$":5},{"active":true,"kind":"query","name":"query","orig":"query","reqd":false,"type":"`$STRING`","index$":6},{"active":true,"kind":"query","name":"release","orig":"release","reqd":false,"type":"`$STRING`","index$":7},{"active":true,"kind":"query","name":"work","orig":"work","reqd":false,"type":"`$STRING`","index$":8}]},"contract":{"id":"GET /recording","json":"{\"operationId\":\"searchOrBrowseRecording\",\"parameters\":[{\"description\":\"Search query string. See search documentation for query syntax.\",\"in\":\"query\",\"name\":\"query\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Maximum number of results to return (maximum 100, default 25)\",\"in\":\"query\",\"name\":\"limit\",\"schema\":{\"default\":25,\"maximum\":100,\"minimum\":1,\"type\":\"integer\"}},{\"description\":\"Number of results to skip (for pagination)\",\"in\":\"query\",\"name\":\"offset\",\"schema\":{\"default\":0,\"minimum\":0,\"type\":\"integer\"}},{\"description\":\"Include additional information. Separate multiple values with '+'. Options include: aliases, annotation, tags, ratings, user-tags, user-ratings, genres, user-genres, releases, recordings, release-groups, works, labels, collections, discids, media, isrcs, artist-credits, various-artists, area-rels, artist-rels, event-rels, genre-rels, instrument-rels, label-rels, place-rels, recording-rels, release-rels, release-group-rels, series-rels, url-rels, work-rels, recording-level-rels, release-group-level-rels, work-level-rels\",\"example\":\"artist-credits+genres\",\"in\":\"query\",\"name\":\"inc\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Artist MBID for browsing\",\"in\":\"query\",\"name\":\"artist\",\"schema\":{\"format\":\"uuid\",\"type\":\"string\"}},{\"description\":\"Collection MBID for browsing\",\"in\":\"query\",\"name\":\"collection\",\"schema\":{\"format\":\"uuid\",\"type\":\"string\"}},{\"description\":\"Release MBID for browsing\",\"in\":\"query\",\"name\":\"release\",\"schema\":{\"format\":\"uuid\",\"type\":\"string\"}},{\"description\":\"Work MBID for browsing\",\"in\":\"query\",\"name\":\"work\",\"schema\":{\"format\":\"uuid\",\"type\":\"string\"}},{\"description\":\"Response format\",\"in\":\"query\",\"name\":\"fmt\",\"schema\":{\"default\":\"xml\",\"enum\":[\"json\",\"xml\"],\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"count\":{\"type\":\"integer\"},\"offset\":{\"type\":\"integer\"},\"recordings\":{\"items\":{\"properties\":{\"disambiguation\":{\"description\":\"Disambiguation comment\",\"type\":\"string\"},\"id\":{\"description\":\"MusicBrainz ID\",\"format\":\"uuid\",\"type\":\"string\"},\"length\":{\"description\":\"Duration in milliseconds\",\"type\":\"integer\"},\"title\":{\"description\":\"Recording title\",\"type\":\"string\"},\"video\":{\"description\":\"Whether this is a video recording\",\"type\":\"boolean\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"count\":{\"type\":\"integer\"},\"offset\":{\"type\":\"integer\"},\"recordings\":{\"items\":{\"properties\":{\"disambiguation\":{\"description\":\"Disambiguation comment\",\"type\":\"string\"},\"id\":{\"description\":\"MusicBrainz ID\",\"format\":\"uuid\",\"type\":\"string\"},\"length\":{\"description\":\"Duration in milliseconds\",\"type\":\"integer\"},\"title\":{\"description\":\"Recording title\",\"type\":\"string\"},\"video\":{\"description\":\"Whether this is a video recording\",\"type\":\"boolean\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"}}},\"description\":\"Successful recording list response\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request - invalid parameters or query\"},\"503\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Rate limit exceeded - maximum 1 request per second\"}},\"security\":[],\"securitySchemes\":{\"digestAuth\":{\"description\":\"Digest authentication using MusicBrainz username and password over HTTPS\",\"scheme\":\"digest\",\"type\":\"http\"},\"oauth2\":{\"description\":\"OAuth 2.0 authentication\",\"flows\":{\"authorizationCode\":{\"authorizationUrl\":\"https://musicbrainz.org/oauth2/authorize\",\"scopes\":{\"collection\":\"Manage collections\",\"email\":\"Access user email\",\"profile\":\"Access user profile information\",\"rating\":\"Submit ratings\",\"submit_barcode\":\"Submit barcodes\",\"submit_isrc\":\"Submit ISRCs\",\"tag\":\"Submit tags\"},\"tokenUrl\":\"https://musicbrainz.org/oauth2/token\"}},\"type\":\"oauth2\"}},\"securitySource\":\"definition\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/recording","segments":[{"lit":"recording"}],"select":{"exist":["artist","collection","fmt","inc","limit","offset","query","release","work"]},"transform":{"req":"`reqdata`","res":"`body.recordings`"},"index$":0}],"key$":"list"},"load":{"input":"data","name":"load","points":[{"active":true,"args":{"params":[{"active":true,"kind":"param","name":"id","orig":"mbid","reqd":true,"type":"`$STRING`","index$":0}],"query":[{"active":true,"example":"xml","kind":"query","name":"fmt","orig":"fmt","reqd":false,"type":"`$STRING`","index$":0},{"active":true,"example":"artist-credits+genres","kind":"query","name":"inc","orig":"inc","reqd":false,"type":"`$STRING`","index$":1},{"active":true,"kind":"query","name":"status","orig":"status","reqd":false,"type":"`$STRING`","index$":2},{"active":true,"kind":"query","name":"type","orig":"type","reqd":false,"type":"`$STRING`","index$":3}]},"contract":{"id":"GET /recording/{mbid}","json":"{\"operationId\":\"lookupRecording\",\"parameters\":[{\"description\":\"MusicBrainz ID (UUID format)\",\"in\":\"path\",\"name\":\"mbid\",\"required\":true,\"schema\":{\"format\":\"uuid\",\"pattern\":\"^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$\",\"type\":\"string\"}},{\"description\":\"Include additional information. Separate multiple values with '+'. Options include: aliases, annotation, tags, ratings, user-tags, user-ratings, genres, user-genres, releases, recordings, release-groups, works, labels, collections, discids, media, isrcs, artist-credits, various-artists, area-rels, artist-rels, event-rels, genre-rels, instrument-rels, label-rels, place-rels, recording-rels, release-rels, release-group-rels, series-rels, url-rels, work-rels, recording-level-rels, release-group-level-rels, work-level-rels\",\"example\":\"artist-credits+genres\",\"in\":\"query\",\"name\":\"inc\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Filter by release or release-group type (e.g., album, single, ep, broadcast, other)\",\"in\":\"query\",\"name\":\"type\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Filter releases by status (e.g., official, promotion, bootleg, pseudo-release)\",\"in\":\"query\",\"name\":\"status\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Response format\",\"in\":\"query\",\"name\":\"fmt\",\"schema\":{\"default\":\"xml\",\"enum\":[\"json\",\"xml\"],\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"disambiguation\":{\"description\":\"Disambiguation comment\",\"type\":\"string\"},\"id\":{\"description\":\"MusicBrainz ID\",\"format\":\"uuid\",\"type\":\"string\"},\"length\":{\"description\":\"Duration in milliseconds\",\"type\":\"integer\"},\"title\":{\"description\":\"Recording title\",\"type\":\"string\"},\"video\":{\"description\":\"Whether this is a video recording\",\"type\":\"boolean\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"disambiguation\":{\"description\":\"Disambiguation comment\",\"type\":\"string\"},\"id\":{\"description\":\"MusicBrainz ID\",\"format\":\"uuid\",\"type\":\"string\"},\"length\":{\"description\":\"Duration in milliseconds\",\"type\":\"integer\"},\"title\":{\"description\":\"Recording title\",\"type\":\"string\"},\"video\":{\"description\":\"Whether this is a video recording\",\"type\":\"boolean\"}},\"type\":\"object\"}}},\"description\":\"Successful recording lookup\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request - invalid parameters or query\"},\"404\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Resource not found\"},\"503\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Rate limit exceeded - maximum 1 request per second\"}},\"security\":[],\"securitySchemes\":{\"digestAuth\":{\"description\":\"Digest authentication using MusicBrainz username and password over HTTPS\",\"scheme\":\"digest\",\"type\":\"http\"},\"oauth2\":{\"description\":\"OAuth 2.0 authentication\",\"flows\":{\"authorizationCode\":{\"authorizationUrl\":\"https://musicbrainz.org/oauth2/authorize\",\"scopes\":{\"collection\":\"Manage collections\",\"email\":\"Access user email\",\"profile\":\"Access user profile information\",\"rating\":\"Submit ratings\",\"submit_barcode\":\"Submit barcodes\",\"submit_isrc\":\"Submit ISRCs\",\"tag\":\"Submit tags\"},\"tokenUrl\":\"https://musicbrainz.org/oauth2/token\"}},\"type\":\"oauth2\"}},\"securitySource\":\"definition\"}","source":"openapi3","version":1},"kind":"http","method":"GET","orig":"/recording/{mbid}","rename":{"param":{"mbid":"id"}},"segments":[{"lit":"recording"},{"var":"id"}],"select":{"exist":["fmt","id","inc","status","type"]},"transform":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"load"}},"relations":{"ancestors":[]},"key$":"recording","name__orig":"recording","Name":"Recording","name_":"recording","name-":"recording","NAME":"RECORDING","index$":9}, {"active":true,"entity":"recording","key$":"BasicRecordingFlow","kind":"basic","name":"BasicRecordingFlow","param":{},"step":[{"active":true,"data":{},"input":{},"match":{},"op":"list","spec":[],"valid":[{"apply":"ItemExists","def":{"ref":"recording_ref01"}}],"index$":0},{"active":true,"data":{},"input":{"ref":"recording_ref01","srcdatavar":"recording_ref01_data","suffix":"_dt0"},"match":{"id":"recording01"},"op":"load","spec":[],"valid":[{"apply":"TextFieldMark","def":{"mark":"Mark01-recording_ref01"}}],"index$":1}]}, 'Recording')
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let recording_ref01_data = Object.values(setup.data.existing.recording)[0] as any

    // LIST
    const recording_ref01_ent = client.Recording()
    const recording_ref01_match: any = {}

    const recording_ref01_list = (await recording_ref01_ent.list(recording_ref01_match)).map((e: any) => e.data())


    // LOAD
    const recording_ref01_match_dt0: any = {}
    recording_ref01_match_dt0.id = recording_ref01_data.id
    const recording_ref01_data_dt0 = (await recording_ref01_ent.load(recording_ref01_match_dt0)).data()
    assert(recording_ref01_data_dt0.id === recording_ref01_data.id)


  })
})



function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/recording/RecordingTestData.json')

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
    ['recording01','recording02','recording03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'MUSICBRAINZ_TEST_RECORDING_ENTID': idmap,
    'MUSICBRAINZ_TEST_LIVE': 'FALSE',
    'MUSICBRAINZ_TEST_EXPLAIN': 'FALSE',
    'MUSICBRAINZ_APIKEY': '',
  })

  idmap = env['MUSICBRAINZ_TEST_RECORDING_ENTID']

  const live = 'TRUE' === env.MUSICBRAINZ_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['MUSICBRAINZ_TEST_RECORDING_ENTID']
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
  
