<?php
declare(strict_types=1);

// Musicbrainz SDK configuration

class MusicbrainzConfig
{
    /** @var array<string,mixed>|null */
    private static ?array $shared_config = null;

    /**
     * Return the process-wide config, built once on first use. The SDK reads
     * the config on every request and never writes to it, so one instance is
     * shared by every client rather than rebuilt per client.
     *
     * PHP arrays are copy-on-write, so callers that do mutate the result get
     * their own copy and cannot disturb the shared one.
     */
    public static function shared_config(): array
    {
        if (self::$shared_config === null) {
            self::$shared_config = self::make_config();
        }
        return self::$shared_config;
    }

    /**
     * Build a fresh, fully materialised config array. Every call rebuilds the
     * whole structure, so prefer shared_config unless you need a private copy.
     */
    public static function make_config(): array
    {
        return [
            "main" => [
                "name" => "Musicbrainz",
            ],
            "feature" => [
                "test" => [
          'options' => [
            'active' => false,
          ],
        ],
            ],
            "options" => [
                "base" => "https://musicbrainz.org/ws/2",
                "auth" => [
                    "prefix" => "Bearer",
                ],
                "headers" => [
          'content-type' => 'application/json',
        ],
                "entity" => [
                    "area" => [],
                    "artist" => [],
                    "collection" => [],
                    "event" => [],
                    "genre" => [],
                    "instrument" => [],
                    "label" => [],
                    "place" => [],
                    "rating" => [],
                    "recording" => [],
                    "recording_list" => [],
                    "release" => [],
                    "release_group" => [],
                    "release_list" => [],
                    "series" => [],
                    "tag" => [],
                    "url" => [],
                    "work" => [],
                    "work_list" => [],
                ],
            ],
            "entity" => [
        'area' => [
          'fields' => [
            [
              'name' => 'begin',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'disambiguation',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'end',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'ended',
              'type' => '`$BOOLEAN`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'lifespan',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'sortname',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'area',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/area',
                  'parts' => [
                    'area',
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'inc',
                      'limit',
                      'offset',
                      'query',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.areas`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/area/{mbid}',
                  'parts' => [
                    'area',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                      'inc',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.life-span`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'artist' => [
          'fields' => [
            [
              'name' => 'begin',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'country',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'disambiguation',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'end',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'ended',
              'type' => '`$BOOLEAN`',
            ],
            [
              'name' => 'gender',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'lifespan',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'sortname',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'artist',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'area',
                        'orig' => 'area',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'collection',
                        'orig' => 'collection',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'recording',
                        'orig' => 'recording',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'release',
                        'orig' => 'release',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'release_group',
                        'orig' => 'release_group',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'work',
                        'orig' => 'work',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/artist',
                  'parts' => [
                    'artist',
                  ],
                  'select' => [
                    'exist' => [
                      'area',
                      'collection',
                      'fmt',
                      'inc',
                      'limit',
                      'offset',
                      'query',
                      'recording',
                      'release',
                      'release_group',
                      'work',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.artists`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'status',
                        'orig' => 'status',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'type',
                        'orig' => 'type',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/artist/{mbid}',
                  'parts' => [
                    'artist',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                      'inc',
                      'status',
                      'type',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.life-span`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'collection' => [
          'fields' => [
            [
              'name' => 'editor',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'entitytype',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'name',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'collection',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/collection',
                  'parts' => [
                    'collection',
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'inc',
                      'limit',
                      'offset',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.collections`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'event' => [
          'fields' => [
            [
              'name' => 'begin',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'cancelled',
              'type' => '`$BOOLEAN`',
            ],
            [
              'name' => 'disambiguation',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'end',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'ended',
              'type' => '`$BOOLEAN`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'lifespan',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'time',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'event',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'area',
                        'orig' => 'area',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'artist',
                        'orig' => 'artist',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'place',
                        'orig' => 'place',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/event',
                  'parts' => [
                    'event',
                  ],
                  'select' => [
                    'exist' => [
                      'area',
                      'artist',
                      'fmt',
                      'inc',
                      'limit',
                      'offset',
                      'place',
                      'query',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.events`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/event/{mbid}',
                  'parts' => [
                    'event',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                      'inc',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.life-span`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'genre' => [
          'fields' => [
            [
              'name' => 'disambiguation',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'name',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'genre',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/genre/all',
                  'parts' => [
                    'genre',
                    'all',
                  ],
                  'select' => [
                    '$action' => 'all',
                    'exist' => [
                      'fmt',
                      'limit',
                      'offset',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.genres`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/genre/{mbid}',
                  'parts' => [
                    'genre',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'instrument' => [
          'fields' => [
            [
              'name' => 'description',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'disambiguation',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'instrument',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'collection',
                        'orig' => 'collection',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/instrument',
                  'parts' => [
                    'instrument',
                  ],
                  'select' => [
                    'exist' => [
                      'collection',
                      'fmt',
                      'inc',
                      'limit',
                      'offset',
                      'query',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.instruments`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/instrument/{mbid}',
                  'parts' => [
                    'instrument',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                      'inc',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'label' => [
          'fields' => [
            [
              'name' => 'begin',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'country',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'disambiguation',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'end',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'ended',
              'type' => '`$BOOLEAN`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'labelcode',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'lifespan',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'sortname',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'label',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'area',
                        'orig' => 'area',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'collection',
                        'orig' => 'collection',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'release',
                        'orig' => 'release',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/label',
                  'parts' => [
                    'label',
                  ],
                  'select' => [
                    'exist' => [
                      'area',
                      'collection',
                      'fmt',
                      'inc',
                      'limit',
                      'offset',
                      'query',
                      'release',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.labels`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'status',
                        'orig' => 'status',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'type',
                        'orig' => 'type',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/label/{mbid}',
                  'parts' => [
                    'label',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                      'inc',
                      'status',
                      'type',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.life-span`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'place' => [
          'fields' => [
            [
              'name' => 'address',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'coordinates',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'disambiguation',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'lifespan',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'place',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'area',
                        'orig' => 'area',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'collection',
                        'orig' => 'collection',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/place',
                  'parts' => [
                    'place',
                  ],
                  'select' => [
                    'exist' => [
                      'area',
                      'collection',
                      'fmt',
                      'inc',
                      'limit',
                      'offset',
                      'query',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.places`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/place/{mbid}',
                  'parts' => [
                    'place',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                      'inc',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'rating' => [
          'fields' => [],
          'name' => 'rating',
          'op' => [
            'create' => [
              'input' => 'data',
              'name' => 'create',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'POST',
                  'orig' => '/rating',
                  'parts' => [
                    'rating',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/rating',
                  'parts' => [
                    'rating',
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'recording' => [
          'fields' => [
            [
              'name' => 'disambiguation',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'length',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'title',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'video',
              'type' => '`$BOOLEAN`',
            ],
          ],
          'name' => 'recording',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'artist',
                        'orig' => 'artist',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'collection',
                        'orig' => 'collection',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'release',
                        'orig' => 'release',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'work',
                        'orig' => 'work',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/recording',
                  'parts' => [
                    'recording',
                  ],
                  'select' => [
                    'exist' => [
                      'artist',
                      'collection',
                      'fmt',
                      'inc',
                      'limit',
                      'offset',
                      'query',
                      'release',
                      'work',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.recordings`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'status',
                        'orig' => 'status',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'type',
                        'orig' => 'type',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/recording/{mbid}',
                  'parts' => [
                    'recording',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                      'inc',
                      'status',
                      'type',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'recording_list' => [
          'fields' => [
            [
              'name' => 'count',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'offset',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'recordings',
              'type' => '`$ARRAY`',
            ],
          ],
          'name' => 'recording_list',
          'op' => [
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'isrc',
                        'orig' => 'isrc',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/isrc/{isrc}',
                  'parts' => [
                    'isrc',
                    '{isrc}',
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'inc',
                      'isrc',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'isrc',
              ],
            ],
          ],
        ],
        'release' => [
          'fields' => [
            [
              'name' => 'barcode',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'country',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'date',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'disambiguation',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'packaging',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'status',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'title',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'release',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'area',
                        'orig' => 'area',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'artist',
                        'orig' => 'artist',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'collection',
                        'orig' => 'collection',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'label',
                        'orig' => 'label',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'recording',
                        'orig' => 'recording',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'release_group',
                        'orig' => 'release_group',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'status',
                        'orig' => 'status',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'track',
                        'orig' => 'track',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'track_artist',
                        'orig' => 'track_artist',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'type',
                        'orig' => 'type',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/release',
                  'parts' => [
                    'release',
                  ],
                  'select' => [
                    'exist' => [
                      'area',
                      'artist',
                      'collection',
                      'fmt',
                      'inc',
                      'label',
                      'limit',
                      'offset',
                      'query',
                      'recording',
                      'release_group',
                      'status',
                      'track',
                      'track_artist',
                      'type',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.releases`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/release/{mbid}',
                  'parts' => [
                    'release',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                      'inc',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'release_group' => [
          'fields' => [
            [
              'name' => 'disambiguation',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'firstreleasedate',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'primarytype',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'secondarytypes',
              'type' => '`$ARRAY`',
            ],
            [
              'name' => 'title',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'release_group',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'artist',
                        'orig' => 'artist',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'collection',
                        'orig' => 'collection',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'release',
                        'orig' => 'release',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'type',
                        'orig' => 'type',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/release-group',
                  'parts' => [
                    'release-group',
                  ],
                  'select' => [
                    'exist' => [
                      'artist',
                      'collection',
                      'fmt',
                      'inc',
                      'limit',
                      'offset',
                      'query',
                      'release',
                      'type',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.release-groups`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'status',
                        'orig' => 'status',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'type',
                        'orig' => 'type',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/release-group/{mbid}',
                  'parts' => [
                    'release-group',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                      'inc',
                      'status',
                      'type',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'release_list' => [
          'fields' => [
            [
              'name' => 'count',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'offset',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'releases',
              'type' => '`$ARRAY`',
            ],
          ],
          'name' => 'release_list',
          'op' => [
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'discid',
                        'orig' => 'discid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/discid/{discid}',
                  'parts' => [
                    'discid',
                    '{discid}',
                  ],
                  'select' => [
                    'exist' => [
                      'discid',
                      'fmt',
                      'inc',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'discid',
              ],
            ],
          ],
        ],
        'series' => [
          'fields' => [
            [
              'name' => 'disambiguation',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'series',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'collection',
                        'orig' => 'collection',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/series',
                  'parts' => [
                    'series',
                  ],
                  'select' => [
                    'exist' => [
                      'collection',
                      'fmt',
                      'inc',
                      'limit',
                      'offset',
                      'query',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.series`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/series/{mbid}',
                  'parts' => [
                    'series',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                      'inc',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'tag' => [
          'fields' => [],
          'name' => 'tag',
          'op' => [
            'create' => [
              'input' => 'data',
              'name' => 'create',
              'points' => [
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'POST',
                  'orig' => '/tag',
                  'parts' => [
                    'tag',
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/tag',
                  'parts' => [
                    'tag',
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'url' => [
          'fields' => [
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'resource',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'url',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'resource',
                        'orig' => 'resource',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/url',
                  'parts' => [
                    'url',
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'inc',
                      'limit',
                      'offset',
                      'query',
                      'resource',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.urls`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/url/{mbid}',
                  'parts' => [
                    'url',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                      'inc',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'work' => [
          'fields' => [
            [
              'name' => 'disambiguation',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'language',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'title',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'work',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'artist',
                        'orig' => 'artist',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'collection',
                        'orig' => 'collection',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 25,
                        'kind' => 'query',
                        'name' => 'limit',
                        'orig' => 'limit',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'offset',
                        'orig' => 'offset',
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'query',
                        'orig' => 'query',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/work',
                  'parts' => [
                    'work',
                  ],
                  'select' => [
                    'exist' => [
                      'artist',
                      'collection',
                      'fmt',
                      'inc',
                      'limit',
                      'offset',
                      'query',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body.works`',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'mbid',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/work/{mbid}',
                  'parts' => [
                    'work',
                    '{id}',
                  ],
                  'rename' => [
                    'param' => [
                      'mbid' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'id',
                      'inc',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'work_list' => [
          'fields' => [
            [
              'name' => 'count',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'offset',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'works',
              'type' => '`$ARRAY`',
            ],
          ],
          'name' => 'work_list',
          'op' => [
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'iswc',
                        'orig' => 'iswc',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                    'query' => [
                      [
                        'example' => 'xml',
                        'kind' => 'query',
                        'name' => 'fmt',
                        'orig' => 'fmt',
                        'type' => '`$STRING`',
                      ],
                      [
                        'example' => 'artist-credits+genres',
                        'kind' => 'query',
                        'name' => 'inc',
                        'orig' => 'inc',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/iswc/{iswc}',
                  'parts' => [
                    'iswc',
                    '{iswc}',
                  ],
                  'select' => [
                    'exist' => [
                      'fmt',
                      'inc',
                      'iswc',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'iswc',
              ],
            ],
          ],
        ],
      ],
        ];
    }


    public static function make_feature(string $name)
    {
        require_once __DIR__ . '/features.php';
        return MusicbrainzFeatures::make_feature($name);
    }
}
