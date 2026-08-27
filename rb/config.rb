# Musicbrainz SDK configuration

module MusicbrainzConfig
  # Return the process-wide config, built once on first use. The SDK reads
  # the config on every request and never writes to it, so one instance is
  # shared by every client rather than rebuilt per client.
  #
  # The returned hash is shared: treat it as read-only. Callers that need to
  # mutate should use make_config, which always returns a fresh copy.
  def self.shared_config
    @shared_config ||= make_config
  end


  # Build a fresh, fully materialised config hash. Every call rebuilds the
  # whole structure, so prefer shared_config unless you need a private copy
  # you intend to mutate.
  def self.make_config
    {
      "main" => {
        "name" => "Musicbrainz",
        "slug" => "musicbrainz",
        "version" => "0.0.1",
        "target" => "rb",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
          "transport" => "base",
        },
      },
      "options" => {
        "base" => "https://musicbrainz.org/ws/2",
        "auth" => {
          "prefix" => "Bearer",
        },
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "area" => {},
          "artist" => {},
          "collection" => {},
          "event" => {},
          "genre" => {},
          "instrument" => {},
          "label" => {},
          "place" => {},
          "rating" => {},
          "recording" => {},
          "recording_list" => {},
          "release" => {},
          "release_group" => {},
          "release_list" => {},
          "series" => {},
          "tag" => {},
          "url" => {},
          "work" => {},
          "work_list" => {},
        },
      },
      "entity" => {
        "area" => {
          "fields" => [
            {
              "name" => "begin",
              "short" => "Begin date",
              "type" => "`$STRING`",
            },
            {
              "name" => "disambiguation",
              "short" => "Disambiguation comment",
              "type" => "`$STRING`",
            },
            {
              "name" => "end",
              "short" => "End date",
              "type" => "`$STRING`",
            },
            {
              "name" => "ended",
              "short" => "Whether the entity has ended",
              "type" => "`$BOOLEAN`",
            },
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "lifespan",
              "type" => "`$OBJECT`",
            },
            {
              "name" => "name",
              "short" => "Area name",
              "type" => "`$STRING`",
            },
            {
              "name" => "sortname",
              "short" => "Sort name",
              "type" => "`$STRING`",
            },
            {
              "name" => "type",
              "short" => "Area type",
              "type" => "`$STRING`",
            },
          ],
          "name" => "area",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/area",
                  "parts" => [
                    "area",
                  ],
                  "select" => {
                    "exist" => [
                      "fmt",
                      "inc",
                      "limit",
                      "offset",
                      "query",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.areas`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/area/{mbid}",
                  "parts" => [
                    "area",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                      "inc",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.life-span`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "artist" => {
          "fields" => [
            {
              "name" => "begin",
              "short" => "Begin date",
              "type" => "`$STRING`",
            },
            {
              "name" => "country",
              "short" => "Country code",
              "type" => "`$STRING`",
            },
            {
              "name" => "disambiguation",
              "short" => "Disambiguation comment",
              "type" => "`$STRING`",
            },
            {
              "name" => "end",
              "short" => "End date",
              "type" => "`$STRING`",
            },
            {
              "name" => "ended",
              "short" => "Whether the entity has ended",
              "type" => "`$BOOLEAN`",
            },
            {
              "name" => "gender",
              "short" => "Gender (for person type)",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "lifespan",
              "type" => "`$OBJECT`",
            },
            {
              "name" => "name",
              "short" => "Artist name",
              "type" => "`$STRING`",
            },
            {
              "name" => "sortname",
              "short" => "Sort name",
              "type" => "`$STRING`",
            },
            {
              "name" => "type",
              "short" => "Artist type (person, group, etc.)",
              "type" => "`$STRING`",
            },
          ],
          "name" => "artist",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "area",
                        "orig" => "area",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "collection",
                        "orig" => "collection",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "recording",
                        "orig" => "recording",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "release",
                        "orig" => "release",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "release_group",
                        "orig" => "release_group",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "work",
                        "orig" => "work",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/artist",
                  "parts" => [
                    "artist",
                  ],
                  "select" => {
                    "exist" => [
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
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.artists`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "status",
                        "orig" => "status",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "type",
                        "orig" => "type",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/artist/{mbid}",
                  "parts" => [
                    "artist",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                      "inc",
                      "status",
                      "type",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.life-span`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "collection" => {
          "fields" => [
            {
              "name" => "editor",
              "type" => "`$STRING`",
            },
            {
              "name" => "entitytype",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "type" => "`$STRING`",
            },
            {
              "name" => "name",
              "type" => "`$STRING`",
            },
          ],
          "name" => "collection",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/collection",
                  "parts" => [
                    "collection",
                  ],
                  "select" => {
                    "exist" => [
                      "fmt",
                      "inc",
                      "limit",
                      "offset",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.collections`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "event" => {
          "fields" => [
            {
              "name" => "begin",
              "short" => "Begin date",
              "type" => "`$STRING`",
            },
            {
              "name" => "cancelled",
              "short" => "Whether the event was cancelled",
              "type" => "`$BOOLEAN`",
            },
            {
              "name" => "disambiguation",
              "short" => "Disambiguation comment",
              "type" => "`$STRING`",
            },
            {
              "name" => "end",
              "short" => "End date",
              "type" => "`$STRING`",
            },
            {
              "name" => "ended",
              "short" => "Whether the entity has ended",
              "type" => "`$BOOLEAN`",
            },
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "lifespan",
              "type" => "`$OBJECT`",
            },
            {
              "name" => "name",
              "short" => "Event name",
              "type" => "`$STRING`",
            },
            {
              "name" => "time",
              "short" => "Event time",
              "type" => "`$STRING`",
            },
            {
              "name" => "type",
              "short" => "Event type",
              "type" => "`$STRING`",
            },
          ],
          "name" => "event",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "area",
                        "orig" => "area",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "artist",
                        "orig" => "artist",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "place",
                        "orig" => "place",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/event",
                  "parts" => [
                    "event",
                  ],
                  "select" => {
                    "exist" => [
                      "area",
                      "artist",
                      "fmt",
                      "inc",
                      "limit",
                      "offset",
                      "place",
                      "query",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.events`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/event/{mbid}",
                  "parts" => [
                    "event",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                      "inc",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.life-span`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "genre" => {
          "fields" => [
            {
              "name" => "disambiguation",
              "short" => "Disambiguation comment",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "name",
              "short" => "Genre name",
              "type" => "`$STRING`",
            },
          ],
          "name" => "genre",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/genre/all",
                  "parts" => [
                    "genre",
                    "all",
                  ],
                  "select" => {
                    "$action" => "all",
                    "exist" => [
                      "fmt",
                      "limit",
                      "offset",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.genres`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/genre/{mbid}",
                  "parts" => [
                    "genre",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "instrument" => {
          "fields" => [
            {
              "name" => "description",
              "short" => "Instrument description",
              "type" => "`$STRING`",
            },
            {
              "name" => "disambiguation",
              "short" => "Disambiguation comment",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "name",
              "short" => "Instrument name",
              "type" => "`$STRING`",
            },
            {
              "name" => "type",
              "short" => "Instrument type",
              "type" => "`$STRING`",
            },
          ],
          "name" => "instrument",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "collection",
                        "orig" => "collection",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/instrument",
                  "parts" => [
                    "instrument",
                  ],
                  "select" => {
                    "exist" => [
                      "collection",
                      "fmt",
                      "inc",
                      "limit",
                      "offset",
                      "query",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.instruments`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/instrument/{mbid}",
                  "parts" => [
                    "instrument",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                      "inc",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "label" => {
          "fields" => [
            {
              "name" => "begin",
              "short" => "Begin date",
              "type" => "`$STRING`",
            },
            {
              "name" => "country",
              "short" => "Country code",
              "type" => "`$STRING`",
            },
            {
              "name" => "disambiguation",
              "short" => "Disambiguation comment",
              "type" => "`$STRING`",
            },
            {
              "name" => "end",
              "short" => "End date",
              "type" => "`$STRING`",
            },
            {
              "name" => "ended",
              "short" => "Whether the entity has ended",
              "type" => "`$BOOLEAN`",
            },
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "labelcode",
              "short" => "Label code",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "lifespan",
              "type" => "`$OBJECT`",
            },
            {
              "name" => "name",
              "short" => "Label name",
              "type" => "`$STRING`",
            },
            {
              "name" => "sortname",
              "short" => "Sort name",
              "type" => "`$STRING`",
            },
            {
              "name" => "type",
              "short" => "Label type",
              "type" => "`$STRING`",
            },
          ],
          "name" => "label",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "area",
                        "orig" => "area",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "collection",
                        "orig" => "collection",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "release",
                        "orig" => "release",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/label",
                  "parts" => [
                    "label",
                  ],
                  "select" => {
                    "exist" => [
                      "area",
                      "collection",
                      "fmt",
                      "inc",
                      "limit",
                      "offset",
                      "query",
                      "release",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.labels`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "status",
                        "orig" => "status",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "type",
                        "orig" => "type",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/label/{mbid}",
                  "parts" => [
                    "label",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                      "inc",
                      "status",
                      "type",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.life-span`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "place" => {
          "fields" => [
            {
              "name" => "address",
              "short" => "Place address",
              "type" => "`$STRING`",
            },
            {
              "name" => "coordinates",
              "type" => "`$OBJECT`",
            },
            {
              "name" => "disambiguation",
              "short" => "Disambiguation comment",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "lifespan",
              "type" => "`$OBJECT`",
            },
            {
              "name" => "name",
              "short" => "Place name",
              "type" => "`$STRING`",
            },
            {
              "name" => "type",
              "short" => "Place type",
              "type" => "`$STRING`",
            },
          ],
          "name" => "place",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "area",
                        "orig" => "area",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "collection",
                        "orig" => "collection",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/place",
                  "parts" => [
                    "place",
                  ],
                  "select" => {
                    "exist" => [
                      "area",
                      "collection",
                      "fmt",
                      "inc",
                      "limit",
                      "offset",
                      "query",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.places`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/place/{mbid}",
                  "parts" => [
                    "place",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                      "inc",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "rating" => {
          "fields" => [],
          "name" => "rating",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/rating",
                  "parts" => [
                    "rating",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/rating",
                  "parts" => [
                    "rating",
                  ],
                  "select" => {
                    "exist" => [
                      "fmt",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "recording" => {
          "fields" => [
            {
              "name" => "disambiguation",
              "short" => "Disambiguation comment",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "length",
              "short" => "Duration in milliseconds",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "title",
              "short" => "Recording title",
              "type" => "`$STRING`",
            },
            {
              "name" => "video",
              "short" => "Whether this is a video recording",
              "type" => "`$BOOLEAN`",
            },
          ],
          "name" => "recording",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "artist",
                        "orig" => "artist",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "collection",
                        "orig" => "collection",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "release",
                        "orig" => "release",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "work",
                        "orig" => "work",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/recording",
                  "parts" => [
                    "recording",
                  ],
                  "select" => {
                    "exist" => [
                      "artist",
                      "collection",
                      "fmt",
                      "inc",
                      "limit",
                      "offset",
                      "query",
                      "release",
                      "work",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.recordings`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "status",
                        "orig" => "status",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "type",
                        "orig" => "type",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/recording/{mbid}",
                  "parts" => [
                    "recording",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                      "inc",
                      "status",
                      "type",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "recording_list" => {
          "fields" => [
            {
              "name" => "count",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "offset",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "recordings",
              "type" => "`$ARRAY`",
            },
          ],
          "name" => "recording_list",
          "op" => {
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "isrc",
                        "orig" => "isrc",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/isrc/{isrc}",
                  "parts" => [
                    "isrc",
                    "{isrc}",
                  ],
                  "select" => {
                    "exist" => [
                      "fmt",
                      "inc",
                      "isrc",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "isrc",
              ],
            ],
          },
        },
        "release" => {
          "fields" => [
            {
              "name" => "barcode",
              "short" => "Barcode",
              "type" => "`$STRING`",
            },
            {
              "name" => "country",
              "short" => "Release country",
              "type" => "`$STRING`",
            },
            {
              "name" => "date",
              "short" => "Release date",
              "type" => "`$STRING`",
            },
            {
              "name" => "disambiguation",
              "short" => "Disambiguation comment",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "packaging",
              "short" => "Packaging type",
              "type" => "`$STRING`",
            },
            {
              "name" => "status",
              "short" => "Release status (official, promotion, bootleg, pseudo-release)",
              "type" => "`$STRING`",
            },
            {
              "name" => "title",
              "short" => "Release title",
              "type" => "`$STRING`",
            },
          ],
          "name" => "release",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "area",
                        "orig" => "area",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "artist",
                        "orig" => "artist",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "collection",
                        "orig" => "collection",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "label",
                        "orig" => "label",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "recording",
                        "orig" => "recording",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "release_group",
                        "orig" => "release_group",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "status",
                        "orig" => "status",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "track",
                        "orig" => "track",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "track_artist",
                        "orig" => "track_artist",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "type",
                        "orig" => "type",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/release",
                  "parts" => [
                    "release",
                  ],
                  "select" => {
                    "exist" => [
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
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.releases`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/release/{mbid}",
                  "parts" => [
                    "release",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                      "inc",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "release_group" => {
          "fields" => [
            {
              "name" => "disambiguation",
              "short" => "Disambiguation comment",
              "type" => "`$STRING`",
            },
            {
              "name" => "firstreleasedate",
              "short" => "Date of first release",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "primarytype",
              "short" => "Primary type (album, single, ep, broadcast, other)",
              "type" => "`$STRING`",
            },
            {
              "name" => "secondarytypes",
              "short" => "Secondary types (compilation, soundtrack, etc.)",
              "type" => "`$ARRAY`",
            },
            {
              "name" => "title",
              "short" => "Release group title",
              "type" => "`$STRING`",
            },
          ],
          "name" => "release_group",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "artist",
                        "orig" => "artist",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "collection",
                        "orig" => "collection",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "release",
                        "orig" => "release",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "type",
                        "orig" => "type",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/release-group",
                  "parts" => [
                    "release-group",
                  ],
                  "select" => {
                    "exist" => [
                      "artist",
                      "collection",
                      "fmt",
                      "inc",
                      "limit",
                      "offset",
                      "query",
                      "release",
                      "type",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.release-groups`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "status",
                        "orig" => "status",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "type",
                        "orig" => "type",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/release-group/{mbid}",
                  "parts" => [
                    "release-group",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                      "inc",
                      "status",
                      "type",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "release_list" => {
          "fields" => [
            {
              "name" => "count",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "offset",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "releases",
              "type" => "`$ARRAY`",
            },
          ],
          "name" => "release_list",
          "op" => {
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "discid",
                        "orig" => "discid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/discid/{discid}",
                  "parts" => [
                    "discid",
                    "{discid}",
                  ],
                  "select" => {
                    "exist" => [
                      "discid",
                      "fmt",
                      "inc",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "discid",
              ],
            ],
          },
        },
        "series" => {
          "fields" => [
            {
              "name" => "disambiguation",
              "short" => "Disambiguation comment",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "name",
              "short" => "Series name",
              "type" => "`$STRING`",
            },
            {
              "name" => "type",
              "short" => "Series type",
              "type" => "`$STRING`",
            },
          ],
          "name" => "series",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "collection",
                        "orig" => "collection",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/series",
                  "parts" => [
                    "series",
                  ],
                  "select" => {
                    "exist" => [
                      "collection",
                      "fmt",
                      "inc",
                      "limit",
                      "offset",
                      "query",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.series`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/series/{mbid}",
                  "parts" => [
                    "series",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                      "inc",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "tag" => {
          "fields" => [],
          "name" => "tag",
          "op" => {
            "create" => {
              "input" => "data",
              "name" => "create",
              "points" => [
                {
                  "args" => {},
                  "kind" => "http",
                  "method" => "POST",
                  "orig" => "/tag",
                  "parts" => [
                    "tag",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/tag",
                  "parts" => [
                    "tag",
                  ],
                  "select" => {
                    "exist" => [
                      "fmt",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "url" => {
          "fields" => [
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "resource",
              "short" => "The URL resource",
              "type" => "`$STRING`",
            },
          ],
          "name" => "url",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "resource",
                        "orig" => "resource",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/url",
                  "parts" => [
                    "url",
                  ],
                  "select" => {
                    "exist" => [
                      "fmt",
                      "inc",
                      "limit",
                      "offset",
                      "query",
                      "resource",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.urls`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/url/{mbid}",
                  "parts" => [
                    "url",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                      "inc",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "work" => {
          "fields" => [
            {
              "name" => "disambiguation",
              "short" => "Disambiguation comment",
              "type" => "`$STRING`",
            },
            {
              "name" => "id",
              "short" => "MusicBrainz ID",
              "type" => "`$STRING`",
            },
            {
              "name" => "language",
              "short" => "Language code",
              "type" => "`$STRING`",
            },
            {
              "name" => "title",
              "short" => "Work title",
              "type" => "`$STRING`",
            },
            {
              "name" => "type",
              "short" => "Work type",
              "type" => "`$STRING`",
            },
          ],
          "name" => "work",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "args" => {
                    "query" => [
                      {
                        "kind" => "query",
                        "name" => "artist",
                        "orig" => "artist",
                        "type" => "`$STRING`",
                      },
                      {
                        "kind" => "query",
                        "name" => "collection",
                        "orig" => "collection",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => 25,
                        "kind" => "query",
                        "name" => "limit",
                        "orig" => "limit",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "example" => 0,
                        "kind" => "query",
                        "name" => "offset",
                        "orig" => "offset",
                        "type" => "`$INTEGER`",
                      },
                      {
                        "kind" => "query",
                        "name" => "query",
                        "orig" => "query",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/work",
                  "parts" => [
                    "work",
                  ],
                  "select" => {
                    "exist" => [
                      "artist",
                      "collection",
                      "fmt",
                      "inc",
                      "limit",
                      "offset",
                      "query",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body.works`",
                  },
                },
              ],
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "mbid",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/work/{mbid}",
                  "parts" => [
                    "work",
                    "{id}",
                  ],
                  "rename" => {
                    "param" => {
                      "mbid" => "id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "fmt",
                      "id",
                      "inc",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "work_list" => {
          "fields" => [
            {
              "name" => "count",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "offset",
              "type" => "`$INTEGER`",
            },
            {
              "name" => "works",
              "type" => "`$ARRAY`",
            },
          ],
          "name" => "work_list",
          "op" => {
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "args" => {
                    "params" => [
                      {
                        "kind" => "param",
                        "name" => "iswc",
                        "orig" => "iswc",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                    "query" => [
                      {
                        "example" => "xml",
                        "kind" => "query",
                        "name" => "fmt",
                        "orig" => "fmt",
                        "type" => "`$STRING`",
                      },
                      {
                        "example" => "artist-credits+genres",
                        "kind" => "query",
                        "name" => "inc",
                        "orig" => "inc",
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/iswc/{iswc}",
                  "parts" => [
                    "iswc",
                    "{iswc}",
                  ],
                  "select" => {
                    "exist" => [
                      "fmt",
                      "inc",
                      "iswc",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "iswc",
              ],
            ],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    MusicbrainzFeatures.make_feature(name)
  end
end
