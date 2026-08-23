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
								"parts": []any{
									"area",
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
								"parts": []any{
									"area",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
								"parts": []any{
									"artist",
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
								"parts": []any{
									"artist",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
						"name": "id",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "name",
						"type": "`$STRING`",
					},
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
								"parts": []any{
									"collection",
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
								"parts": []any{
									"event",
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
								"parts": []any{
									"event",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
								"parts": []any{
									"genre",
									"all",
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
								"parts": []any{
									"genre",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
								"parts": []any{
									"instrument",
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
								"parts": []any{
									"instrument",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
								"parts": []any{
									"label",
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
								"parts": []any{
									"label",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
								"parts": []any{
									"place",
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
								"parts": []any{
									"place",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
								"parts": []any{
									"rating",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
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
								"parts": []any{
									"rating",
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
								"parts": []any{
									"recording",
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
								"parts": []any{
									"recording",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
								"parts": []any{
									"isrc",
									"{isrc}",
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
								"parts": []any{
									"release",
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
								"parts": []any{
									"release",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
								"parts": []any{
									"release-group",
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
								"parts": []any{
									"release-group",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
								"parts": []any{
									"discid",
									"{discid}",
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
								"parts": []any{
									"series",
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
								"parts": []any{
									"series",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
								"parts": []any{
									"tag",
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
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
								"parts": []any{
									"tag",
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
						"name": "id",
						"short": "MusicBrainz ID",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "resource",
						"short": "The URL resource",
						"type": "`$STRING`",
					},
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
								"parts": []any{
									"url",
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
								"parts": []any{
									"url",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
								"parts": []any{
									"work",
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
								"parts": []any{
									"work",
									"{id}",
								},
								"rename": map[string]any{
									"param": map[string]any{
										"mbid": "id",
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
								"parts": []any{
									"iswc",
									"{iswc}",
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
