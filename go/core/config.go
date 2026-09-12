package core

import (
	"sync"
)

// MakeConfig builds a fresh, fully materialised config map. Every call
// rebuilds the whole structure, so prefer SharedConfig unless you need a
// private copy you intend to mutate.
func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "Musicbrainz",
			"slug": "musicbrainz",
			"version": "0.0.1",
			"target": "go",
		},
		"feature": map[string]any{
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"transport": "base",
			},
		},
		"options": map[string]any{
			"base": "https://musicbrainz.org/ws/2",
			"auth": map[string]any{
				"prefix": "Bearer",
			},
			"headers": map[string]any{
				"content-type": "application/json",
			},
			"entity": map[string]any{
				"area": map[string]any{},
				"artist": map[string]any{},
				"collection": map[string]any{},
				"event": map[string]any{},
				"genre": map[string]any{},
				"instrument": map[string]any{},
				"label": map[string]any{},
				"place": map[string]any{},
				"rating": map[string]any{},
				"recording": map[string]any{},
				"recording_list": map[string]any{},
				"release": map[string]any{},
				"release_group": map[string]any{},
				"release_list": map[string]any{},
				"series": map[string]any{},
				"tag": map[string]any{},
				"url": map[string]any{},
				"work": map[string]any{},
				"work_list": map[string]any{},
			},
		},
		"entity": map[string]any{
			"area": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "begin",
						"short": "Begin date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "disambiguation",
						"short": "Disambiguation comment",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "end",
						"short": "End date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "ended",
						"short": "Whether the entity has ended",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "lifespan",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Area name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "sortname",
						"short": "Sort name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Area type",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "area",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "query",
											"orig": "query",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/area",
								"segments": []any{
									map[string]any{
										"lit": "area",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"inc",
										"limit",
										"offset",
										"query",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.areas`",
								},
								"parts": []any{
									"area",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/area/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "area",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
										"inc",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.life-span`",
								},
								"parts": []any{
									"area",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"artist": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "begin",
						"short": "Begin date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "country",
						"short": "Country code",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "disambiguation",
						"short": "Disambiguation comment",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "end",
						"short": "End date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "ended",
						"short": "Whether the entity has ended",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "gender",
						"short": "Gender (for person type)",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "lifespan",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Artist name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "sortname",
						"short": "Sort name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Artist type (person, group, etc.)",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "artist",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "area",
											"orig": "area",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "collection",
											"orig": "collection",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "query",
											"orig": "query",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "recording",
											"orig": "recording",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "release",
											"orig": "release",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "release_group",
											"orig": "release_group",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "work",
											"orig": "work",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/artist",
								"segments": []any{
									map[string]any{
										"lit": "artist",
									},
								},
								"select": map[string]any{
									"exist": []any{
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
										"work",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.artists`",
								},
								"parts": []any{
									"artist",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "status",
											"orig": "status",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "type",
											"orig": "type",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/artist/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "artist",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
										"inc",
										"status",
										"type",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.life-span`",
								},
								"parts": []any{
									"artist",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"collection": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "editor",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "entitytype",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "name",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "collection",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/collection",
								"segments": []any{
									map[string]any{
										"lit": "collection",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"inc",
										"limit",
										"offset",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.collections`",
								},
								"parts": []any{
									"collection",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"event": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "begin",
						"short": "Begin date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "cancelled",
						"short": "Whether the event was cancelled",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "disambiguation",
						"short": "Disambiguation comment",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "end",
						"short": "End date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "ended",
						"short": "Whether the entity has ended",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "lifespan",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Event name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "time",
						"short": "Event time",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Event type",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "event",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "area",
											"orig": "area",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "artist",
											"orig": "artist",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "place",
											"orig": "place",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "query",
											"orig": "query",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/event",
								"segments": []any{
									map[string]any{
										"lit": "event",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"area",
										"artist",
										"fmt",
										"inc",
										"limit",
										"offset",
										"place",
										"query",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.events`",
								},
								"parts": []any{
									"event",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/event/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "event",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
										"inc",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.life-span`",
								},
								"parts": []any{
									"event",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"genre": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "disambiguation",
						"short": "Disambiguation comment",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "name",
						"short": "Genre name",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "genre",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/genre/all",
								"segments": []any{
									map[string]any{
										"lit": "genre",
									},
									map[string]any{
										"lit": "all",
									},
								},
								"select": map[string]any{
									"$action": "all",
									"exist": []any{
										"fmt",
										"limit",
										"offset",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.genres`",
								},
								"parts": []any{
									"genre",
									"all",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/genre/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "genre",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"genre",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"instrument": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "description",
						"short": "Instrument description",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "disambiguation",
						"short": "Disambiguation comment",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "name",
						"short": "Instrument name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Instrument type",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "instrument",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "collection",
											"orig": "collection",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "query",
											"orig": "query",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/instrument",
								"segments": []any{
									map[string]any{
										"lit": "instrument",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"collection",
										"fmt",
										"inc",
										"limit",
										"offset",
										"query",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.instruments`",
								},
								"parts": []any{
									"instrument",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/instrument/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "instrument",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
										"inc",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"instrument",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"label": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "begin",
						"short": "Begin date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "country",
						"short": "Country code",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "disambiguation",
						"short": "Disambiguation comment",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "end",
						"short": "End date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "ended",
						"short": "Whether the entity has ended",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "labelcode",
						"short": "Label code",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "lifespan",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Label name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "sortname",
						"short": "Sort name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Label type",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "label",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "area",
											"orig": "area",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "collection",
											"orig": "collection",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "query",
											"orig": "query",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "release",
											"orig": "release",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/label",
								"segments": []any{
									map[string]any{
										"lit": "label",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"area",
										"collection",
										"fmt",
										"inc",
										"limit",
										"offset",
										"query",
										"release",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.labels`",
								},
								"parts": []any{
									"label",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "status",
											"orig": "status",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "type",
											"orig": "type",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/label/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "label",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
										"inc",
										"status",
										"type",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.life-span`",
								},
								"parts": []any{
									"label",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"place": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "address",
						"short": "Place address",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "coordinates",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "disambiguation",
						"short": "Disambiguation comment",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "lifespan",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Place name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Place type",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "place",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "area",
											"orig": "area",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "collection",
											"orig": "collection",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "query",
											"orig": "query",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/place",
								"segments": []any{
									map[string]any{
										"lit": "place",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"area",
										"collection",
										"fmt",
										"inc",
										"limit",
										"offset",
										"query",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.places`",
								},
								"parts": []any{
									"place",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/place/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "place",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
										"inc",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"place",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"rating": map[string]any{
				"fields": []any{},
				"name": "rating",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/rating",
								"segments": []any{
									map[string]any{
										"lit": "rating",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"rating",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/rating",
								"segments": []any{
									map[string]any{
										"lit": "rating",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"rating",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"recording": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "disambiguation",
						"short": "Disambiguation comment",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "length",
						"short": "Duration in milliseconds",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "title",
						"short": "Recording title",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "video",
						"short": "Whether this is a video recording",
						"type": "`$BOOLEAN`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "recording",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "artist",
											"orig": "artist",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "collection",
											"orig": "collection",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "query",
											"orig": "query",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "release",
											"orig": "release",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "work",
											"orig": "work",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/recording",
								"segments": []any{
									map[string]any{
										"lit": "recording",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"artist",
										"collection",
										"fmt",
										"inc",
										"limit",
										"offset",
										"query",
										"release",
										"work",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.recordings`",
								},
								"parts": []any{
									"recording",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "status",
											"orig": "status",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "type",
											"orig": "type",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/recording/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "recording",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
										"inc",
										"status",
										"type",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"recording",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"recording_list": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "count",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "offset",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "recordings",
						"type": "`$ARRAY`",
					},
				},
				"name": "recording_list",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "isrc",
											"orig": "isrc",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/isrc/{isrc}",
								"segments": []any{
									map[string]any{
										"lit": "isrc",
									},
									map[string]any{
										"var": "isrc",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"inc",
										"isrc",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"isrc",
									"{isrc}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"isrc",
						},
					},
				},
			},
			"release": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "barcode",
						"short": "Barcode",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "country",
						"short": "Release country",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "date",
						"short": "Release date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "disambiguation",
						"short": "Disambiguation comment",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "packaging",
						"short": "Packaging type",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "status",
						"short": "Release status (official, promotion, bootleg, pseudo-release)",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "title",
						"short": "Release title",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "release",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "area",
											"orig": "area",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "artist",
											"orig": "artist",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "collection",
											"orig": "collection",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "label",
											"orig": "label",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "query",
											"orig": "query",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "recording",
											"orig": "recording",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "release_group",
											"orig": "release_group",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "status",
											"orig": "status",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "track",
											"orig": "track",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "track_artist",
											"orig": "track_artist",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "type",
											"orig": "type",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/release",
								"segments": []any{
									map[string]any{
										"lit": "release",
									},
								},
								"select": map[string]any{
									"exist": []any{
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
										"type",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.releases`",
								},
								"parts": []any{
									"release",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/release/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "release",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
										"inc",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"release",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"release_group": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "disambiguation",
						"short": "Disambiguation comment",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "firstreleasedate",
						"short": "Date of first release",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "primarytype",
						"short": "Primary type (album, single, ep, broadcast, other)",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "secondarytypes",
						"short": "Secondary types (compilation, soundtrack, etc.)",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "title",
						"short": "Release group title",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "release_group",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "artist",
											"orig": "artist",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "collection",
											"orig": "collection",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "query",
											"orig": "query",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "release",
											"orig": "release",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "type",
											"orig": "type",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/release-group",
								"segments": []any{
									map[string]any{
										"lit": "release-group",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"artist",
										"collection",
										"fmt",
										"inc",
										"limit",
										"offset",
										"query",
										"release",
										"type",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.release-groups`",
								},
								"parts": []any{
									"release-group",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "status",
											"orig": "status",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "type",
											"orig": "type",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/release-group/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "release-group",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
										"inc",
										"status",
										"type",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"release-group",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"release_list": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "count",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "offset",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "releases",
						"type": "`$ARRAY`",
					},
				},
				"name": "release_list",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "discid",
											"orig": "discid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/discid/{discid}",
								"segments": []any{
									map[string]any{
										"lit": "discid",
									},
									map[string]any{
										"var": "discid",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"discid",
										"fmt",
										"inc",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"discid",
									"{discid}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"discid",
						},
					},
				},
			},
			"series": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "disambiguation",
						"short": "Disambiguation comment",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "name",
						"short": "Series name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Series type",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "series",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "collection",
											"orig": "collection",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "query",
											"orig": "query",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/series",
								"segments": []any{
									map[string]any{
										"lit": "series",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"collection",
										"fmt",
										"inc",
										"limit",
										"offset",
										"query",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.series`",
								},
								"parts": []any{
									"series",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/series/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "series",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
										"inc",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"series",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"tag": map[string]any{
				"fields": []any{},
				"name": "tag",
				"op": map[string]any{
					"create": map[string]any{
						"input": "data",
						"name": "create",
						"points": []any{
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "POST",
								"orig": "/tag",
								"segments": []any{
									map[string]any{
										"lit": "tag",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"tag",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/tag",
								"segments": []any{
									map[string]any{
										"lit": "tag",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"tag",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"url": map[string]any{
				"fields": []any{
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uri",
						"name": "resource",
						"short": "The URL resource",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "url",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "query",
											"orig": "query",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "resource",
											"orig": "resource",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/url",
								"segments": []any{
									map[string]any{
										"lit": "url",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"inc",
										"limit",
										"offset",
										"query",
										"resource",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.urls`",
								},
								"parts": []any{
									"url",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/url/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "url",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
										"inc",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"url",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"work": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "disambiguation",
						"short": "Disambiguation comment",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "uuid",
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "language",
						"short": "Language code",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "title",
						"short": "Work title",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Work type",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "work",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "artist",
											"orig": "artist",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "collection",
											"orig": "collection",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": 25,
											"kind": "query",
											"name": "limit",
											"orig": "limit",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "offset",
											"orig": "offset",
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "query",
											"orig": "query",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/work",
								"segments": []any{
									map[string]any{
										"lit": "work",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"artist",
										"collection",
										"fmt",
										"inc",
										"limit",
										"offset",
										"query",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body.works`",
								},
								"parts": []any{
									"work",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "mbid",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/work/{mbid}",
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "work",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"id",
										"inc",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"work",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"work_list": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "count",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "offset",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "works",
						"type": "`$ARRAY`",
					},
				},
				"name": "work_list",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "iswc",
											"orig": "iswc",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
									"query": []any{
										map[string]any{
											"example": "xml",
											"kind": "query",
											"name": "fmt",
											"orig": "fmt",
											"type": "`$STRING`",
										},
										map[string]any{
											"example": "artist-credits+genres",
											"kind": "query",
											"name": "inc",
											"orig": "inc",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/iswc/{iswc}",
								"segments": []any{
									map[string]any{
										"lit": "iswc",
									},
									map[string]any{
										"var": "iswc",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"fmt",
										"inc",
										"iswc",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"iswc",
									"{iswc}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"iswc",
						},
					},
				},
			},
		},
	}
}

// The plugin definitions the model selected per feature, as []any so a
// feature package can consume them without core naming its types. Empty
// when no active feature declares active plugin groups for this target.
var featurePlugins = map[string][]any{
}

// FeaturePlugins is the definitions list for one feature's chain.
func FeaturePlugins(name string) []any {
	return featurePlugins[name]
}

var (
	sharedConfigOnce sync.Once
	sharedConfigVal  map[string]any
)

// SharedConfig returns the process-wide config, built once on first use.
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client.
//
// The returned map is shared: treat it as read-only. Callers that need to
// mutate should use MakeConfig, which always returns a fresh copy.
func SharedConfig() map[string]any {
	sharedConfigOnce.Do(func() {
		sharedConfigVal = MakeConfig()
	})
	return sharedConfigVal
}

func makeFeature(name string) Feature {
	switch name {
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
