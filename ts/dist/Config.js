"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FEATURE_PLUGINS = exports.config = void 0;
const RatelimitFeature_1 = require("./feature/ratelimit/RatelimitFeature");
const RetryFeature_1 = require("./feature/retry/RetryFeature");
const TestFeature_1 = require("./feature/test/TestFeature");
const TimeoutFeature_1 = require("./feature/timeout/TimeoutFeature");
const FEATURE_CLASS = {
    ratelimit: RatelimitFeature_1.RatelimitFeature,
    retry: RetryFeature_1.RetryFeature,
    test: TestFeature_1.TestFeature,
    timeout: TimeoutFeature_1.TimeoutFeature,
};
// Per-feature plugin DEFINITIONS (voxgig/plugin `Definition` values), from
// the model's active plugin groups. A feature that takes a `plugins` option
// (secrets over sekreto) reads its own entry; a feature with no plugins has
// none. Named imports above make each definition statically reachable, so
// an SDK carries exactly the plugin modules its model selects — the same
// leanness the old side-effect registry imports bought, without a registry.
const FEATURE_PLUGINS = {};
exports.FEATURE_PLUGINS = FEATURE_PLUGINS;
class Config {
    makeFeature(fn) {
        const fc = FEATURE_CLASS[fn];
        const fi = new fc();
        // TODO: errors etc
        return fi;
    }
    // False for a feature added at runtime via options.extend (station's
    // adopt path) - the constructor uses this to skip makeFeature for names
    // no generated class backs.
    hasFeature(fn) {
        return null != FEATURE_CLASS[fn];
    }
    main = {
        name: 'Musicbrainz',
        slug: "musicbrainz",
        version: "0.0.1",
        target: "ts",
    };
    feature = {
        ratelimit: {
            "options": {
                "active": false,
                "burst": 5,
                "rate": 5
            },
            "optspec": {
                "now": "`$FUNCTION`",
                "sleep": "`$FUNCTION`"
            },
            "strict": false,
            "transport": "wrap"
        },
        retry: {
            "options": {
                "active": false,
                "factor": 2,
                "maxDelay": 2000,
                "minDelay": 50,
                "retries": 2,
                "statuses": [
                    408,
                    425,
                    429,
                    500,
                    502,
                    503,
                    504
                ]
            },
            "optspec": {
                "jitter": "`$BOOLEAN`",
                "sleep": "`$FUNCTION`"
            },
            "strict": false,
            "transport": "wrap"
        },
        test: {
            "options": {
                "active": false
            },
            "optspec": {
                "entity": "`$MAP`",
                "net": "`$MAP`"
            },
            "strict": false,
            "transport": "base"
        },
        timeout: {
            "options": {
                "active": false,
                "ms": 30000
            },
            "optspec": {
                "clearTimer": "`$FUNCTION`",
                "setTimer": "`$FUNCTION`"
            },
            "strict": false,
            "transport": "wrap"
        },
    };
    options = {
        base: "https://musicbrainz.org/ws/2",
        auth: {
            prefix: 'Bearer',
        },
        headers: {
            "content-type": "application/json"
        },
        entity: {
            area: {},
            artist: {},
            collection: {},
            event: {},
            genre: {},
            instrument: {},
            label: {},
            place: {},
            rating: {},
            recording: {},
            recording_list: {},
            release: {},
            release_group: {},
            release_list: {},
            series: {},
            tag: {},
            url: {},
            work: {},
            work_list: {},
        }
    };
    entity = {
        "area": {
            "fields": [
                {
                    "name": "begin",
                    "short": "Begin date",
                    "type": "`$STRING`"
                },
                {
                    "name": "disambiguation",
                    "short": "Disambiguation comment",
                    "type": "`$STRING`"
                },
                {
                    "name": "end",
                    "short": "End date",
                    "type": "`$STRING`"
                },
                {
                    "name": "ended",
                    "short": "Whether the entity has ended",
                    "type": "`$BOOLEAN`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "name": "lifespan",
                    "type": "`$OBJECT`"
                },
                {
                    "name": "name",
                    "short": "Area name",
                    "type": "`$STRING`"
                },
                {
                    "name": "sortname",
                    "short": "Sort name",
                    "type": "`$STRING`"
                },
                {
                    "name": "type",
                    "short": "Area type",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "area",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "query",
                                        "orig": "query",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/area",
                            "segments": [
                                {
                                    "lit": "area"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "inc",
                                    "limit",
                                    "offset",
                                    "query"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.areas`"
                            },
                            "parts": [
                                "area"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/area/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "area"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id",
                                    "inc"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.life-span`"
                            },
                            "parts": [
                                "area",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "artist": {
            "fields": [
                {
                    "name": "begin",
                    "short": "Begin date",
                    "type": "`$STRING`"
                },
                {
                    "name": "country",
                    "short": "Country code",
                    "type": "`$STRING`"
                },
                {
                    "name": "disambiguation",
                    "short": "Disambiguation comment",
                    "type": "`$STRING`"
                },
                {
                    "name": "end",
                    "short": "End date",
                    "type": "`$STRING`"
                },
                {
                    "name": "ended",
                    "short": "Whether the entity has ended",
                    "type": "`$BOOLEAN`"
                },
                {
                    "name": "gender",
                    "short": "Gender (for person type)",
                    "type": "`$STRING`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "name": "lifespan",
                    "type": "`$OBJECT`"
                },
                {
                    "name": "name",
                    "short": "Artist name",
                    "type": "`$STRING`"
                },
                {
                    "name": "sortname",
                    "short": "Sort name",
                    "type": "`$STRING`"
                },
                {
                    "name": "type",
                    "short": "Artist type (person, group, etc.)",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "artist",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "kind": "query",
                                        "name": "area",
                                        "orig": "area",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "collection",
                                        "orig": "collection",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "query",
                                        "orig": "query",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "recording",
                                        "orig": "recording",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "release",
                                        "orig": "release",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "release_group",
                                        "orig": "release_group",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "work",
                                        "orig": "work",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/artist",
                            "segments": [
                                {
                                    "lit": "artist"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "area",
                                    "collection",
                                    "fmt",
                                    "inc",
                                    "limit",
                                    "offset",
                                    "query",
                                    "recording",
                                    "release",
                                    "release_group",
                                    "work"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.artists`"
                            },
                            "parts": [
                                "artist"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "status",
                                        "orig": "status",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "type",
                                        "orig": "type",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/artist/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "artist"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id",
                                    "inc",
                                    "status",
                                    "type"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.life-span`"
                            },
                            "parts": [
                                "artist",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "collection": {
            "fields": [
                {
                    "name": "editor",
                    "type": "`$STRING`"
                },
                {
                    "name": "entitytype",
                    "type": "`$STRING`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "type": "`$STRING`"
                },
                {
                    "name": "name",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "collection",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/collection",
                            "segments": [
                                {
                                    "lit": "collection"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "inc",
                                    "limit",
                                    "offset"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.collections`"
                            },
                            "parts": [
                                "collection"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "event": {
            "fields": [
                {
                    "name": "begin",
                    "short": "Begin date",
                    "type": "`$STRING`"
                },
                {
                    "name": "cancelled",
                    "short": "Whether the event was cancelled",
                    "type": "`$BOOLEAN`"
                },
                {
                    "name": "disambiguation",
                    "short": "Disambiguation comment",
                    "type": "`$STRING`"
                },
                {
                    "name": "end",
                    "short": "End date",
                    "type": "`$STRING`"
                },
                {
                    "name": "ended",
                    "short": "Whether the entity has ended",
                    "type": "`$BOOLEAN`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "name": "lifespan",
                    "type": "`$OBJECT`"
                },
                {
                    "name": "name",
                    "short": "Event name",
                    "type": "`$STRING`"
                },
                {
                    "name": "time",
                    "short": "Event time",
                    "type": "`$STRING`"
                },
                {
                    "name": "type",
                    "short": "Event type",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "event",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "kind": "query",
                                        "name": "area",
                                        "orig": "area",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "artist",
                                        "orig": "artist",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "place",
                                        "orig": "place",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "query",
                                        "orig": "query",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/event",
                            "segments": [
                                {
                                    "lit": "event"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "area",
                                    "artist",
                                    "fmt",
                                    "inc",
                                    "limit",
                                    "offset",
                                    "place",
                                    "query"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.events`"
                            },
                            "parts": [
                                "event"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/event/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "event"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id",
                                    "inc"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.life-span`"
                            },
                            "parts": [
                                "event",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "genre": {
            "fields": [
                {
                    "name": "disambiguation",
                    "short": "Disambiguation comment",
                    "type": "`$STRING`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "name": "name",
                    "short": "Genre name",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "genre",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/genre/all",
                            "segments": [
                                {
                                    "lit": "genre"
                                },
                                {
                                    "lit": "all"
                                }
                            ],
                            "select": {
                                "$action": "all",
                                "exist": [
                                    "fmt",
                                    "limit",
                                    "offset"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.genres`"
                            },
                            "parts": [
                                "genre",
                                "all"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/genre/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "genre"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "genre",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "instrument": {
            "fields": [
                {
                    "name": "description",
                    "short": "Instrument description",
                    "type": "`$STRING`"
                },
                {
                    "name": "disambiguation",
                    "short": "Disambiguation comment",
                    "type": "`$STRING`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "name": "name",
                    "short": "Instrument name",
                    "type": "`$STRING`"
                },
                {
                    "name": "type",
                    "short": "Instrument type",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "instrument",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "kind": "query",
                                        "name": "collection",
                                        "orig": "collection",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "query",
                                        "orig": "query",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/instrument",
                            "segments": [
                                {
                                    "lit": "instrument"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "collection",
                                    "fmt",
                                    "inc",
                                    "limit",
                                    "offset",
                                    "query"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.instruments`"
                            },
                            "parts": [
                                "instrument"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/instrument/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "instrument"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id",
                                    "inc"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "instrument",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "label": {
            "fields": [
                {
                    "name": "begin",
                    "short": "Begin date",
                    "type": "`$STRING`"
                },
                {
                    "name": "country",
                    "short": "Country code",
                    "type": "`$STRING`"
                },
                {
                    "name": "disambiguation",
                    "short": "Disambiguation comment",
                    "type": "`$STRING`"
                },
                {
                    "name": "end",
                    "short": "End date",
                    "type": "`$STRING`"
                },
                {
                    "name": "ended",
                    "short": "Whether the entity has ended",
                    "type": "`$BOOLEAN`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "name": "labelcode",
                    "short": "Label code",
                    "type": "`$INTEGER`"
                },
                {
                    "name": "lifespan",
                    "type": "`$OBJECT`"
                },
                {
                    "name": "name",
                    "short": "Label name",
                    "type": "`$STRING`"
                },
                {
                    "name": "sortname",
                    "short": "Sort name",
                    "type": "`$STRING`"
                },
                {
                    "name": "type",
                    "short": "Label type",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "label",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "kind": "query",
                                        "name": "area",
                                        "orig": "area",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "collection",
                                        "orig": "collection",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "query",
                                        "orig": "query",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "release",
                                        "orig": "release",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/label",
                            "segments": [
                                {
                                    "lit": "label"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "area",
                                    "collection",
                                    "fmt",
                                    "inc",
                                    "limit",
                                    "offset",
                                    "query",
                                    "release"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.labels`"
                            },
                            "parts": [
                                "label"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "status",
                                        "orig": "status",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "type",
                                        "orig": "type",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/label/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "label"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id",
                                    "inc",
                                    "status",
                                    "type"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.life-span`"
                            },
                            "parts": [
                                "label",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "place": {
            "fields": [
                {
                    "name": "address",
                    "short": "Place address",
                    "type": "`$STRING`"
                },
                {
                    "name": "coordinates",
                    "type": "`$OBJECT`"
                },
                {
                    "name": "disambiguation",
                    "short": "Disambiguation comment",
                    "type": "`$STRING`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "name": "lifespan",
                    "type": "`$OBJECT`"
                },
                {
                    "name": "name",
                    "short": "Place name",
                    "type": "`$STRING`"
                },
                {
                    "name": "type",
                    "short": "Place type",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "place",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "kind": "query",
                                        "name": "area",
                                        "orig": "area",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "collection",
                                        "orig": "collection",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "query",
                                        "orig": "query",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/place",
                            "segments": [
                                {
                                    "lit": "place"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "area",
                                    "collection",
                                    "fmt",
                                    "inc",
                                    "limit",
                                    "offset",
                                    "query"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.places`"
                            },
                            "parts": [
                                "place"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/place/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "place"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id",
                                    "inc"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "place",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "rating": {
            "fields": [],
            "name": "rating",
            "op": {
                "create": {
                    "input": "data",
                    "name": "create",
                    "points": [
                        {
                            "args": {},
                            "kind": "http",
                            "method": "POST",
                            "orig": "/rating",
                            "segments": [
                                {
                                    "lit": "rating"
                                }
                            ],
                            "select": {},
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "rating"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/rating",
                            "segments": [
                                {
                                    "lit": "rating"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "rating"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "recording": {
            "fields": [
                {
                    "name": "disambiguation",
                    "short": "Disambiguation comment",
                    "type": "`$STRING`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "name": "length",
                    "short": "Duration in milliseconds",
                    "type": "`$INTEGER`"
                },
                {
                    "name": "title",
                    "short": "Recording title",
                    "type": "`$STRING`"
                },
                {
                    "name": "video",
                    "short": "Whether this is a video recording",
                    "type": "`$BOOLEAN`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "recording",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "kind": "query",
                                        "name": "artist",
                                        "orig": "artist",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "collection",
                                        "orig": "collection",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "query",
                                        "orig": "query",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "release",
                                        "orig": "release",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "work",
                                        "orig": "work",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/recording",
                            "segments": [
                                {
                                    "lit": "recording"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "artist",
                                    "collection",
                                    "fmt",
                                    "inc",
                                    "limit",
                                    "offset",
                                    "query",
                                    "release",
                                    "work"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.recordings`"
                            },
                            "parts": [
                                "recording"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "status",
                                        "orig": "status",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "type",
                                        "orig": "type",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/recording/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "recording"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id",
                                    "inc",
                                    "status",
                                    "type"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "recording",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "recording_list": {
            "fields": [
                {
                    "name": "count",
                    "type": "`$INTEGER`"
                },
                {
                    "name": "offset",
                    "type": "`$INTEGER`"
                },
                {
                    "name": "recordings",
                    "type": "`$ARRAY`"
                }
            ],
            "name": "recording_list",
            "op": {
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "isrc",
                                        "orig": "isrc",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/isrc/{isrc}",
                            "segments": [
                                {
                                    "lit": "isrc"
                                },
                                {
                                    "var": "isrc"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "inc",
                                    "isrc"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "isrc",
                                "{isrc}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": [
                    [
                        "isrc"
                    ]
                ]
            }
        },
        "release": {
            "fields": [
                {
                    "name": "barcode",
                    "short": "Barcode",
                    "type": "`$STRING`"
                },
                {
                    "name": "country",
                    "short": "Release country",
                    "type": "`$STRING`"
                },
                {
                    "name": "date",
                    "short": "Release date",
                    "type": "`$STRING`"
                },
                {
                    "name": "disambiguation",
                    "short": "Disambiguation comment",
                    "type": "`$STRING`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "name": "packaging",
                    "short": "Packaging type",
                    "type": "`$STRING`"
                },
                {
                    "name": "status",
                    "short": "Release status (official, promotion, bootleg, pseudo-release)",
                    "type": "`$STRING`"
                },
                {
                    "name": "title",
                    "short": "Release title",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "release",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "kind": "query",
                                        "name": "area",
                                        "orig": "area",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "artist",
                                        "orig": "artist",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "collection",
                                        "orig": "collection",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "label",
                                        "orig": "label",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "query",
                                        "orig": "query",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "recording",
                                        "orig": "recording",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "release_group",
                                        "orig": "release_group",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "status",
                                        "orig": "status",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "track",
                                        "orig": "track",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "track_artist",
                                        "orig": "track_artist",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "type",
                                        "orig": "type",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/release",
                            "segments": [
                                {
                                    "lit": "release"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "area",
                                    "artist",
                                    "collection",
                                    "fmt",
                                    "inc",
                                    "label",
                                    "limit",
                                    "offset",
                                    "query",
                                    "recording",
                                    "release_group",
                                    "status",
                                    "track",
                                    "track_artist",
                                    "type"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.releases`"
                            },
                            "parts": [
                                "release"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/release/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "release"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id",
                                    "inc"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "release",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "release_group": {
            "fields": [
                {
                    "name": "disambiguation",
                    "short": "Disambiguation comment",
                    "type": "`$STRING`"
                },
                {
                    "name": "firstreleasedate",
                    "short": "Date of first release",
                    "type": "`$STRING`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "name": "primarytype",
                    "short": "Primary type (album, single, ep, broadcast, other)",
                    "type": "`$STRING`"
                },
                {
                    "name": "secondarytypes",
                    "short": "Secondary types (compilation, soundtrack, etc.)",
                    "type": "`$ARRAY`"
                },
                {
                    "name": "title",
                    "short": "Release group title",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "release_group",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "kind": "query",
                                        "name": "artist",
                                        "orig": "artist",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "collection",
                                        "orig": "collection",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "query",
                                        "orig": "query",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "release",
                                        "orig": "release",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "type",
                                        "orig": "type",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/release-group",
                            "segments": [
                                {
                                    "lit": "release-group"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "artist",
                                    "collection",
                                    "fmt",
                                    "inc",
                                    "limit",
                                    "offset",
                                    "query",
                                    "release",
                                    "type"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.release-groups`"
                            },
                            "parts": [
                                "release-group"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "status",
                                        "orig": "status",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "type",
                                        "orig": "type",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/release-group/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "release-group"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id",
                                    "inc",
                                    "status",
                                    "type"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "release-group",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "release_list": {
            "fields": [
                {
                    "name": "count",
                    "type": "`$INTEGER`"
                },
                {
                    "name": "offset",
                    "type": "`$INTEGER`"
                },
                {
                    "name": "releases",
                    "type": "`$ARRAY`"
                }
            ],
            "name": "release_list",
            "op": {
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "discid",
                                        "orig": "discid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/discid/{discid}",
                            "segments": [
                                {
                                    "lit": "discid"
                                },
                                {
                                    "var": "discid"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "discid",
                                    "fmt",
                                    "inc"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "discid",
                                "{discid}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": [
                    [
                        "discid"
                    ]
                ]
            }
        },
        "series": {
            "fields": [
                {
                    "name": "disambiguation",
                    "short": "Disambiguation comment",
                    "type": "`$STRING`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "name": "name",
                    "short": "Series name",
                    "type": "`$STRING`"
                },
                {
                    "name": "type",
                    "short": "Series type",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "series",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "kind": "query",
                                        "name": "collection",
                                        "orig": "collection",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "query",
                                        "orig": "query",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/series",
                            "segments": [
                                {
                                    "lit": "series"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "collection",
                                    "fmt",
                                    "inc",
                                    "limit",
                                    "offset",
                                    "query"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.series`"
                            },
                            "parts": [
                                "series"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/series/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "series"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id",
                                    "inc"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "series",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "tag": {
            "fields": [],
            "name": "tag",
            "op": {
                "create": {
                    "input": "data",
                    "name": "create",
                    "points": [
                        {
                            "args": {},
                            "kind": "http",
                            "method": "POST",
                            "orig": "/tag",
                            "segments": [
                                {
                                    "lit": "tag"
                                }
                            ],
                            "select": {},
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "tag"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/tag",
                            "segments": [
                                {
                                    "lit": "tag"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "tag"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "url": {
            "fields": [
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "format": "uri",
                    "name": "resource",
                    "short": "The URL resource",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "url",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "query",
                                        "orig": "query",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "resource",
                                        "orig": "resource",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/url",
                            "segments": [
                                {
                                    "lit": "url"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "inc",
                                    "limit",
                                    "offset",
                                    "query",
                                    "resource"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.urls`"
                            },
                            "parts": [
                                "url"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/url/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "url"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id",
                                    "inc"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "url",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "work": {
            "fields": [
                {
                    "name": "disambiguation",
                    "short": "Disambiguation comment",
                    "type": "`$STRING`"
                },
                {
                    "format": "uuid",
                    "name": "id",
                    "short": "MusicBrainz ID",
                    "type": "`$STRING`"
                },
                {
                    "name": "language",
                    "short": "Language code",
                    "type": "`$STRING`"
                },
                {
                    "name": "title",
                    "short": "Work title",
                    "type": "`$STRING`"
                },
                {
                    "name": "type",
                    "short": "Work type",
                    "type": "`$STRING`"
                }
            ],
            "id": {
                "field": "id",
                "name": "id"
            },
            "name": "work",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "args": {
                                "query": [
                                    {
                                        "kind": "query",
                                        "name": "artist",
                                        "orig": "artist",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "collection",
                                        "orig": "collection",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": 25,
                                        "kind": "query",
                                        "name": "limit",
                                        "orig": "limit",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "example": 0,
                                        "kind": "query",
                                        "name": "offset",
                                        "orig": "offset",
                                        "type": "`$INTEGER`"
                                    },
                                    {
                                        "kind": "query",
                                        "name": "query",
                                        "orig": "query",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/work",
                            "segments": [
                                {
                                    "lit": "work"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "artist",
                                    "collection",
                                    "fmt",
                                    "inc",
                                    "limit",
                                    "offset",
                                    "query"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body.works`"
                            },
                            "parts": [
                                "work"
                            ]
                        }
                    ]
                },
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "id",
                                        "orig": "mbid",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/work/{mbid}",
                            "rename": {
                                "param": {
                                    "mbid": "id"
                                }
                            },
                            "segments": [
                                {
                                    "lit": "work"
                                },
                                {
                                    "var": "id"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "id",
                                    "inc"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "work",
                                "{id}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "work_list": {
            "fields": [
                {
                    "name": "count",
                    "type": "`$INTEGER`"
                },
                {
                    "name": "offset",
                    "type": "`$INTEGER`"
                },
                {
                    "name": "works",
                    "type": "`$ARRAY`"
                }
            ],
            "name": "work_list",
            "op": {
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "args": {
                                "params": [
                                    {
                                        "kind": "param",
                                        "name": "iswc",
                                        "orig": "iswc",
                                        "reqd": true,
                                        "type": "`$STRING`"
                                    }
                                ],
                                "query": [
                                    {
                                        "example": "xml",
                                        "kind": "query",
                                        "name": "fmt",
                                        "orig": "fmt",
                                        "type": "`$STRING`"
                                    },
                                    {
                                        "example": "artist-credits+genres",
                                        "kind": "query",
                                        "name": "inc",
                                        "orig": "inc",
                                        "type": "`$STRING`"
                                    }
                                ]
                            },
                            "kind": "http",
                            "method": "GET",
                            "orig": "/iswc/{iswc}",
                            "segments": [
                                {
                                    "lit": "iswc"
                                },
                                {
                                    "var": "iswc"
                                }
                            ],
                            "select": {
                                "exist": [
                                    "fmt",
                                    "inc",
                                    "iswc"
                                ]
                            },
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "parts": [
                                "iswc",
                                "{iswc}"
                            ]
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": [
                    [
                        "iswc"
                    ]
                ]
            }
        }
    };
}
const config = new Config();
exports.config = config;
//# sourceMappingURL=Config.js.map