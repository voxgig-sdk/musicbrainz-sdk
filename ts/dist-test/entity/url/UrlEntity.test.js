"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const node_path_1 = __importDefault(require("node:path"));
const Fs = __importStar(require("node:fs"));
const node_test_1 = require("node:test");
const node_assert_1 = __importDefault(require("node:assert"));
const live_runner_1 = require("../../live-runner");
const live_entity_1 = require("../../live-entity");
const __1 = require("../../..");
const utility_1 = require("../../utility");
// AFTER the imports on purpose: TypeScript hoists `import` above any
// statement in the emitted CommonJS, so a loader placed above them would
// run only after every imported module had already been evaluated - and
// anything reading process.env at module scope would miss these values.
(0, utility_1.loadEnvLocal)(__dirname + '/../../../.env.local');
(0, node_test_1.describe)('UrlEntity', async () => {
    // Per-test live pacing. Delay is read from sdk-test-control.json's
    // `test.live.delayMs`; only sleeps when MUSICBRAINZ_TEST_LIVE=TRUE.
    (0, node_test_1.afterEach)((0, utility_1.liveDelay)('MUSICBRAINZ_TEST_LIVE'));
    (0, node_test_1.test)('instance', async () => {
        const testsdk = __1.MusicbrainzSDK.test();
        const ent = testsdk.Url();
        (0, node_assert_1.default)(null != ent);
    });
    (0, node_test_1.test)('basic', async (t) => {
        const live = 'TRUE' === process.env.MUSICBRAINZ_TEST_LIVE;
        for (const op of ['list', 'load']) {
            if (!live && (0, utility_1.maybeSkipControl)(t, 'entityOp', 'url.' + op, live))
                return;
        }
        const setup = basicSetup();
        if (setup.live) {
            return (0, live_entity_1.runLiveEntity)(setup, { "active": true, "alias": { "field": {} }, "fields": [{ "active": true, "format": "uuid", "name": "id", "req": false, "short": "MusicBrainz ID", "type": "`$STRING`", "index$": 0 }, { "active": true, "format": "uri", "name": "resource", "req": false, "short": "The URL resource", "type": "`$STRING`", "index$": 1 }], "id": { "field": "id", "name": "id" }, "name": "url", "op": { "list": { "input": "data", "name": "list", "points": [{ "active": true, "args": { "query": [{ "active": true, "example": "xml", "kind": "query", "name": "fmt", "orig": "fmt", "reqd": false, "type": "`$STRING`", "index$": 0 }, { "active": true, "example": "artist-credits+genres", "kind": "query", "name": "inc", "orig": "inc", "reqd": false, "type": "`$STRING`", "index$": 1 }, { "active": true, "example": 25, "kind": "query", "name": "limit", "orig": "limit", "reqd": false, "type": "`$INTEGER`", "index$": 2 }, { "active": true, "example": 0, "kind": "query", "name": "offset", "orig": "offset", "reqd": false, "type": "`$INTEGER`", "index$": 3 }, { "active": true, "kind": "query", "name": "query", "orig": "query", "reqd": false, "type": "`$STRING`", "index$": 4 }, { "active": true, "kind": "query", "name": "resource", "orig": "resource", "reqd": false, "type": "`$STRING`", "index$": 5 }] }, "contract": { "id": "GET /url", "json": "{\"operationId\":\"searchOrBrowseUrl\",\"parameters\":[{\"description\":\"Search query string. See search documentation for query syntax.\",\"in\":\"query\",\"name\":\"query\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Maximum number of results to return (maximum 100, default 25)\",\"in\":\"query\",\"name\":\"limit\",\"schema\":{\"default\":25,\"maximum\":100,\"minimum\":1,\"type\":\"integer\"}},{\"description\":\"Number of results to skip (for pagination)\",\"in\":\"query\",\"name\":\"offset\",\"schema\":{\"default\":0,\"minimum\":0,\"type\":\"integer\"}},{\"description\":\"Include additional information. Separate multiple values with '+'. Options include: aliases, annotation, tags, ratings, user-tags, user-ratings, genres, user-genres, releases, recordings, release-groups, works, labels, collections, discids, media, isrcs, artist-credits, various-artists, area-rels, artist-rels, event-rels, genre-rels, instrument-rels, label-rels, place-rels, recording-rels, release-rels, release-group-rels, series-rels, url-rels, work-rels, recording-level-rels, release-group-level-rels, work-level-rels\",\"example\":\"artist-credits+genres\",\"in\":\"query\",\"name\":\"inc\",\"schema\":{\"type\":\"string\"}},{\"description\":\"URL resource string for lookup\",\"in\":\"query\",\"name\":\"resource\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Response format\",\"in\":\"query\",\"name\":\"fmt\",\"schema\":{\"default\":\"xml\",\"enum\":[\"json\",\"xml\"],\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"count\":{\"type\":\"integer\"},\"offset\":{\"type\":\"integer\"},\"urls\":{\"items\":{\"properties\":{\"id\":{\"description\":\"MusicBrainz ID\",\"format\":\"uuid\",\"type\":\"string\"},\"resource\":{\"description\":\"The URL resource\",\"format\":\"uri\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"count\":{\"type\":\"integer\"},\"offset\":{\"type\":\"integer\"},\"urls\":{\"items\":{\"properties\":{\"id\":{\"description\":\"MusicBrainz ID\",\"format\":\"uuid\",\"type\":\"string\"},\"resource\":{\"description\":\"The URL resource\",\"format\":\"uri\",\"type\":\"string\"}},\"type\":\"object\"},\"type\":\"array\"}},\"type\":\"object\"}}},\"description\":\"Successful URL list response\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request - invalid parameters or query\"},\"503\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Rate limit exceeded - maximum 1 request per second\"}},\"security\":[],\"securitySchemes\":{\"digestAuth\":{\"description\":\"Digest authentication using MusicBrainz username and password over HTTPS\",\"scheme\":\"digest\",\"type\":\"http\"},\"oauth2\":{\"description\":\"OAuth 2.0 authentication\",\"flows\":{\"authorizationCode\":{\"authorizationUrl\":\"https://musicbrainz.org/oauth2/authorize\",\"scopes\":{\"collection\":\"Manage collections\",\"email\":\"Access user email\",\"profile\":\"Access user profile information\",\"rating\":\"Submit ratings\",\"submit_barcode\":\"Submit barcodes\",\"submit_isrc\":\"Submit ISRCs\",\"tag\":\"Submit tags\"},\"tokenUrl\":\"https://musicbrainz.org/oauth2/token\"}},\"type\":\"oauth2\"}},\"securitySource\":\"definition\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "GET", "orig": "/url", "segments": [{ "lit": "url" }], "select": { "exist": ["fmt", "inc", "limit", "offset", "query", "resource"] }, "transform": { "req": "`reqdata`", "res": "`body.urls`" }, "index$": 0 }], "key$": "list" }, "load": { "input": "data", "name": "load", "points": [{ "active": true, "args": { "params": [{ "active": true, "kind": "param", "name": "id", "orig": "mbid", "reqd": true, "type": "`$STRING`", "index$": 0 }], "query": [{ "active": true, "example": "xml", "kind": "query", "name": "fmt", "orig": "fmt", "reqd": false, "type": "`$STRING`", "index$": 0 }, { "active": true, "example": "artist-credits+genres", "kind": "query", "name": "inc", "orig": "inc", "reqd": false, "type": "`$STRING`", "index$": 1 }] }, "contract": { "id": "GET /url/{mbid}", "json": "{\"operationId\":\"lookupUrl\",\"parameters\":[{\"description\":\"MusicBrainz ID (UUID format)\",\"in\":\"path\",\"name\":\"mbid\",\"required\":true,\"schema\":{\"format\":\"uuid\",\"pattern\":\"^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$\",\"type\":\"string\"}},{\"description\":\"Include additional information. Separate multiple values with '+'. Options include: aliases, annotation, tags, ratings, user-tags, user-ratings, genres, user-genres, releases, recordings, release-groups, works, labels, collections, discids, media, isrcs, artist-credits, various-artists, area-rels, artist-rels, event-rels, genre-rels, instrument-rels, label-rels, place-rels, recording-rels, release-rels, release-group-rels, series-rels, url-rels, work-rels, recording-level-rels, release-group-level-rels, work-level-rels\",\"example\":\"artist-credits+genres\",\"in\":\"query\",\"name\":\"inc\",\"schema\":{\"type\":\"string\"}},{\"description\":\"Response format\",\"in\":\"query\",\"name\":\"fmt\",\"schema\":{\"default\":\"xml\",\"enum\":[\"json\",\"xml\"],\"type\":\"string\"}}],\"protocol\":\"http\",\"responses\":{\"200\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"id\":{\"description\":\"MusicBrainz ID\",\"format\":\"uuid\",\"type\":\"string\"},\"resource\":{\"description\":\"The URL resource\",\"format\":\"uri\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"id\":{\"description\":\"MusicBrainz ID\",\"format\":\"uuid\",\"type\":\"string\"},\"resource\":{\"description\":\"The URL resource\",\"format\":\"uri\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Successful URL lookup\"},\"400\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Bad request - invalid parameters or query\"},\"404\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Resource not found\"},\"503\":{\"content\":{\"application/json\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}},\"application/xml\":{\"schema\":{\"properties\":{\"error\":{\"description\":\"Error message\",\"type\":\"string\"},\"help\":{\"description\":\"Help text\",\"type\":\"string\"}},\"type\":\"object\"}}},\"description\":\"Rate limit exceeded - maximum 1 request per second\"}},\"security\":[],\"securitySchemes\":{\"digestAuth\":{\"description\":\"Digest authentication using MusicBrainz username and password over HTTPS\",\"scheme\":\"digest\",\"type\":\"http\"},\"oauth2\":{\"description\":\"OAuth 2.0 authentication\",\"flows\":{\"authorizationCode\":{\"authorizationUrl\":\"https://musicbrainz.org/oauth2/authorize\",\"scopes\":{\"collection\":\"Manage collections\",\"email\":\"Access user email\",\"profile\":\"Access user profile information\",\"rating\":\"Submit ratings\",\"submit_barcode\":\"Submit barcodes\",\"submit_isrc\":\"Submit ISRCs\",\"tag\":\"Submit tags\"},\"tokenUrl\":\"https://musicbrainz.org/oauth2/token\"}},\"type\":\"oauth2\"}},\"securitySource\":\"definition\"}", "source": "openapi3", "version": 1 }, "kind": "http", "method": "GET", "orig": "/url/{mbid}", "rename": { "param": { "mbid": "id" } }, "segments": [{ "lit": "url" }, { "var": "id" }], "select": { "exist": ["fmt", "id", "inc"] }, "transform": { "req": "`reqdata`", "res": "`body`" }, "index$": 0 }], "key$": "load" } }, "relations": { "ancestors": [] }, "key$": "url", "name__orig": "url", "Name": "Url", "name_": "url", "name-": "url", "NAME": "URL", "index$": 16 }, { "active": true, "entity": "url", "key$": "BasicUrlFlow", "kind": "basic", "name": "BasicUrlFlow", "param": {}, "step": [{ "active": true, "data": {}, "input": {}, "match": {}, "op": "list", "spec": [], "valid": [{ "apply": "ItemExists", "def": { "ref": "url_ref01" } }], "index$": 0 }, { "active": true, "data": {}, "input": { "ref": "url_ref01", "srcdatavar": "url_ref01_data", "suffix": "_dt0" }, "match": { "id": "url01" }, "op": "load", "spec": [], "valid": [{ "apply": "TextFieldMark", "def": { "mark": "Mark01-url_ref01" } }], "index$": 1 }] }, 'Url');
        }
        const client = setup.client;
        const struct = setup.struct;
        const isempty = struct.isempty;
        const select = struct.select;
        let url_ref01_data = Object.values(setup.data.existing.url)[0];
        // LIST
        const url_ref01_ent = client.Url();
        const url_ref01_match = {};
        const url_ref01_list = (await url_ref01_ent.list(url_ref01_match)).map((e) => e.data());
        // LOAD
        const url_ref01_match_dt0 = {};
        url_ref01_match_dt0.id = url_ref01_data.id;
        const url_ref01_data_dt0 = (await url_ref01_ent.load(url_ref01_match_dt0)).data();
        (0, node_assert_1.default)(url_ref01_data_dt0.id === url_ref01_data.id);
    });
});
function basicSetup(extra) {
    // TODO: fix test def options
    const options = {}; // null
    // TODO: needs test utility to resolve path
    const entityDataFile = node_path_1.default.resolve(__dirname, '../../../../.sdk/test/entity/url/UrlTestData.json');
    // TODO: file ready util needed?
    const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8');
    // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
    const entityData = JSON.parse(entityDataSource);
    options.entity = entityData.existing;
    let client = __1.MusicbrainzSDK.test(options, extra);
    const struct = client.utility().struct;
    const merge = struct.merge;
    const transform = struct.transform;
    let idmap = transform(['url01', 'url02', 'url03'], {
        '`$PACK`': ['', {
                '`$KEY`': '`$COPY`',
                '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
            }]
    });
    const env = (0, utility_1.envOverride)({
        'MUSICBRAINZ_TEST_URL_ENTID': idmap,
        'MUSICBRAINZ_TEST_LIVE': 'FALSE',
        'MUSICBRAINZ_TEST_EXPLAIN': 'FALSE',
        'MUSICBRAINZ_APIKEY': '',
    });
    idmap = env['MUSICBRAINZ_TEST_URL_ENTID'];
    const live = 'TRUE' === env.MUSICBRAINZ_TEST_LIVE;
    const transport = (0, live_runner_1.createLiveTransport)();
    if (live) {
        const rawIds = process.env['MUSICBRAINZ_TEST_URL_ENTID'];
        idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {};
        if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
            throw new Error('Live ENTID must be a JSON object');
        }
        client = new __1.MusicbrainzSDK(merge([
            // FIRST, so the generated fields below win: sdk-test-control.json's
            // test.client.options adds to the live client, it does not redirect it.
            (0, utility_1.liveClientOptions)(),
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
        ]));
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
    };
    return setup;
}
//# sourceMappingURL=UrlEntity.test.js.map