<?php
declare(strict_types=1);

// Musicbrainz SDK

require_once __DIR__ . '/utility/struct/Struct.php';
require_once __DIR__ . '/core/UtilityType.php';
require_once __DIR__ . '/core/Spec.php';
require_once __DIR__ . '/core/Helpers.php';

// Load utility registration
require_once __DIR__ . '/utility/Register.php';

// Load config and features
require_once __DIR__ . '/config.php';
require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/features.php';

use Voxgig\Struct\Struct;

class MusicbrainzSDK
{
    public string $mode;
    public array $features;
    public ?array $options;

    private $_utility;
    private $_rootctx;

    public function __construct(array $options = [])
    {
        $this->mode = "live";
        $this->features = [];
        $this->options = null;

        $utility = new MusicbrainzUtility();
        $this->_utility = $utility;

        $config = MusicbrainzConfig::make_config();

        $this->_rootctx = ($utility->make_context)([
            "client" => $this,
            "utility" => $utility,
            "config" => $config,
            "options" => $options ?? [],
            "shared" => [],
        ], null);

        $this->options = ($utility->make_options)($this->_rootctx);

        if (Struct::getpath($this->options, "feature.test.active") === true) {
            $this->mode = "test";
        }

        $this->_rootctx->options = $this->options;

        // Add features from config.
        $feature_opts = MusicbrainzHelpers::to_map(Struct::getprop($this->options, "feature"));
        if ($feature_opts) {
            $items = Struct::items($feature_opts);
            if ($items) {
                foreach ($items as $item) {
                    $fname = $item[0];
                    $fopts = MusicbrainzHelpers::to_map($item[1]);
                    if ($fopts && isset($fopts["active"]) && $fopts["active"] === true) {
                        ($utility->feature_add)($this->_rootctx, MusicbrainzFeatures::make_feature($fname));
                    }
                }
            }
        }

        // Add extension features.
        $extend_val = Struct::getprop($this->options, "extend");
        if (is_array($extend_val)) {
            foreach ($extend_val as $f) {
                if (is_object($f) && method_exists($f, 'get_name')) {
                    ($utility->feature_add)($this->_rootctx, $f);
                }
            }
        }

        // Initialize features.
        foreach ($this->features as $f) {
            ($utility->feature_init)($this->_rootctx, $f);
        }

        ($utility->feature_hook)($this->_rootctx, "PostConstruct");
    }

    public function options_map(): array
    {
        $out = Struct::clone($this->options);
        return is_array($out) ? $out : [];
    }

    public function get_utility()
    {
        return MusicbrainzUtility::copy($this->_utility);
    }

    public function get_root_ctx()
    {
        return $this->_rootctx;
    }

    public function prepare(array $fetchargs = []): mixed
    {
        $utility = $this->_utility;
        $fetchargs = $fetchargs ?? [];

        $ctrl = MusicbrainzHelpers::to_map(Struct::getprop($fetchargs, "ctrl")) ?? [];

        $ctx = ($utility->make_context)([
            "opname" => "prepare",
            "ctrl" => $ctrl,
        ], $this->_rootctx);

        $opts = $this->options;
        $path = Struct::getprop($fetchargs, "path") ?? "";
        $path = is_string($path) ? $path : "";
        $method_val = Struct::getprop($fetchargs, "method") ?? "GET";
        $method_val = is_string($method_val) ? $method_val : "GET";
        $params = MusicbrainzHelpers::to_map(Struct::getprop($fetchargs, "params")) ?? [];
        $query = MusicbrainzHelpers::to_map(Struct::getprop($fetchargs, "query")) ?? [];
        $headers = ($utility->prepare_headers)($ctx);

        $base = Struct::getprop($opts, "base") ?? "";
        $base = is_string($base) ? $base : "";
        $prefix = Struct::getprop($opts, "prefix") ?? "";
        $prefix = is_string($prefix) ? $prefix : "";
        $suffix = Struct::getprop($opts, "suffix") ?? "";
        $suffix = is_string($suffix) ? $suffix : "";

        $ctx->spec = new MusicbrainzSpec([
            "base" => $base, "prefix" => $prefix, "suffix" => $suffix,
            "path" => $path, "method" => $method_val,
            "params" => $params, "query" => $query, "headers" => $headers,
            "body" => Struct::getprop($fetchargs, "body"),
            "step" => "start",
        ]);

        // Merge user-provided headers.
        $uh = Struct::getprop($fetchargs, "headers");
        if (is_array($uh)) {
            foreach ($uh as $k => $v) {
                $ctx->spec->headers[$k] = $v;
            }
        }

        [$_, $err] = ($utility->prepare_auth)($ctx);
        if ($err) {
            return ($utility->make_error)($ctx, $err);
        }

        [$fetchdef, $fd_err] = ($utility->make_fetch_def)($ctx);
        if ($fd_err) {
            return ($utility->make_error)($ctx, $fd_err);
        }
        return $fetchdef;
    }

    public function direct(array $fetchargs = []): mixed
    {
        $utility = $this->_utility;

        // direct() is the raw-HTTP escape hatch: it never throws, it returns
        // an {ok, err, ...} dict. prepare() now raises on error, so catch it
        // and surface the failure through the dict instead.
        try {
            $fetchdef = $this->prepare($fetchargs);
        } catch (\Throwable $err) {
            return ["ok" => false, "err" => $err];
        }

        $fetchargs = $fetchargs ?? [];
        $ctrl = MusicbrainzHelpers::to_map(Struct::getprop($fetchargs, "ctrl")) ?? [];

        $ctx = ($utility->make_context)([
            "opname" => "direct",
            "ctrl" => $ctrl,
        ], $this->_rootctx);

        $url = $fetchdef["url"] ?? "";
        [$fetched, $fetch_err] = ($utility->fetcher)($ctx, $url, $fetchdef);

        if ($fetch_err) {
            return ["ok" => false, "err" => $fetch_err];
        }

        if ($fetched === null) {
            return [
                "ok" => false,
                "err" => $ctx->make_error("direct_no_response", "response: undefined"),
            ];
        }

        if (is_array($fetched)) {
            $status = MusicbrainzHelpers::to_int(Struct::getprop($fetched, "status"));
            $headers = Struct::getprop($fetched, "headers") ?? [];

            // No-body responses (204, 304) and explicit zero content-length
            // must skip JSON parsing — calling json() on an empty body errors.
            $content_length = is_array($headers) ? ($headers["content-length"] ?? null) : null;
            $no_body = $status === 204 || $status === 304 || (string)$content_length === "0";

            $json_data = null;
            if (!$no_body) {
                $jf = Struct::getprop($fetched, "json");
                if (is_callable($jf)) {
                    try {
                        $json_data = $jf();
                    } catch (\Throwable $e) {
                        // Non-JSON body — leave data null but keep status/ok.
                        $json_data = null;
                    }
                }
            }

            return [
                "ok" => $status >= 200 && $status < 300,
                "status" => $status,
                "headers" => Struct::getprop($fetched, "headers"),
                "data" => $json_data,
            ];
        }

        return [
            "ok" => false,
            "err" => $ctx->make_error("direct_invalid", "invalid response type"),
        ];
    }


    private $_area = null;

    // Canonical facade: $client->Area()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->area()
    // resolves here too.
    public function Area($data = null)
    {
        require_once __DIR__ . '/entity/area_entity.php';
        if ($data === null) {
            if ($this->_area === null) {
                $this->_area = new AreaEntity($this, null);
            }
            return $this->_area;
        }
        return new AreaEntity($this, $data);
    }


    private $_artist = null;

    // Canonical facade: $client->Artist()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->artist()
    // resolves here too.
    public function Artist($data = null)
    {
        require_once __DIR__ . '/entity/artist_entity.php';
        if ($data === null) {
            if ($this->_artist === null) {
                $this->_artist = new ArtistEntity($this, null);
            }
            return $this->_artist;
        }
        return new ArtistEntity($this, $data);
    }


    private $_collection = null;

    // Canonical facade: $client->Collection()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->collection()
    // resolves here too.
    public function Collection($data = null)
    {
        require_once __DIR__ . '/entity/collection_entity.php';
        if ($data === null) {
            if ($this->_collection === null) {
                $this->_collection = new CollectionEntity($this, null);
            }
            return $this->_collection;
        }
        return new CollectionEntity($this, $data);
    }


    private $_event = null;

    // Canonical facade: $client->Event()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->event()
    // resolves here too.
    public function Event($data = null)
    {
        require_once __DIR__ . '/entity/event_entity.php';
        if ($data === null) {
            if ($this->_event === null) {
                $this->_event = new EventEntity($this, null);
            }
            return $this->_event;
        }
        return new EventEntity($this, $data);
    }


    private $_genre = null;

    // Canonical facade: $client->Genre()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->genre()
    // resolves here too.
    public function Genre($data = null)
    {
        require_once __DIR__ . '/entity/genre_entity.php';
        if ($data === null) {
            if ($this->_genre === null) {
                $this->_genre = new GenreEntity($this, null);
            }
            return $this->_genre;
        }
        return new GenreEntity($this, $data);
    }


    private $_instrument = null;

    // Canonical facade: $client->Instrument()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->instrument()
    // resolves here too.
    public function Instrument($data = null)
    {
        require_once __DIR__ . '/entity/instrument_entity.php';
        if ($data === null) {
            if ($this->_instrument === null) {
                $this->_instrument = new InstrumentEntity($this, null);
            }
            return $this->_instrument;
        }
        return new InstrumentEntity($this, $data);
    }


    private $_label = null;

    // Canonical facade: $client->Label()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->label()
    // resolves here too.
    public function Label($data = null)
    {
        require_once __DIR__ . '/entity/label_entity.php';
        if ($data === null) {
            if ($this->_label === null) {
                $this->_label = new LabelEntity($this, null);
            }
            return $this->_label;
        }
        return new LabelEntity($this, $data);
    }


    private $_place = null;

    // Canonical facade: $client->Place()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->place()
    // resolves here too.
    public function Place($data = null)
    {
        require_once __DIR__ . '/entity/place_entity.php';
        if ($data === null) {
            if ($this->_place === null) {
                $this->_place = new PlaceEntity($this, null);
            }
            return $this->_place;
        }
        return new PlaceEntity($this, $data);
    }


    private $_rating = null;

    // Canonical facade: $client->Rating()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->rating()
    // resolves here too.
    public function Rating($data = null)
    {
        require_once __DIR__ . '/entity/rating_entity.php';
        if ($data === null) {
            if ($this->_rating === null) {
                $this->_rating = new RatingEntity($this, null);
            }
            return $this->_rating;
        }
        return new RatingEntity($this, $data);
    }


    private $_recording = null;

    // Canonical facade: $client->Recording()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->recording()
    // resolves here too.
    public function Recording($data = null)
    {
        require_once __DIR__ . '/entity/recording_entity.php';
        if ($data === null) {
            if ($this->_recording === null) {
                $this->_recording = new RecordingEntity($this, null);
            }
            return $this->_recording;
        }
        return new RecordingEntity($this, $data);
    }


    private $_recording_list = null;

    // Canonical facade: $client->RecordingList()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->recording_list()
    // resolves here too.
    public function RecordingList($data = null)
    {
        require_once __DIR__ . '/entity/recording_list_entity.php';
        if ($data === null) {
            if ($this->_recording_list === null) {
                $this->_recording_list = new RecordingListEntity($this, null);
            }
            return $this->_recording_list;
        }
        return new RecordingListEntity($this, $data);
    }


    private $_release = null;

    // Canonical facade: $client->Release()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->release()
    // resolves here too.
    public function Release($data = null)
    {
        require_once __DIR__ . '/entity/release_entity.php';
        if ($data === null) {
            if ($this->_release === null) {
                $this->_release = new ReleaseEntity($this, null);
            }
            return $this->_release;
        }
        return new ReleaseEntity($this, $data);
    }


    private $_release_group = null;

    // Canonical facade: $client->ReleaseGroup()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->release_group()
    // resolves here too.
    public function ReleaseGroup($data = null)
    {
        require_once __DIR__ . '/entity/release_group_entity.php';
        if ($data === null) {
            if ($this->_release_group === null) {
                $this->_release_group = new ReleaseGroupEntity($this, null);
            }
            return $this->_release_group;
        }
        return new ReleaseGroupEntity($this, $data);
    }


    private $_release_list = null;

    // Canonical facade: $client->ReleaseList()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->release_list()
    // resolves here too.
    public function ReleaseList($data = null)
    {
        require_once __DIR__ . '/entity/release_list_entity.php';
        if ($data === null) {
            if ($this->_release_list === null) {
                $this->_release_list = new ReleaseListEntity($this, null);
            }
            return $this->_release_list;
        }
        return new ReleaseListEntity($this, $data);
    }


    private $_series = null;

    // Canonical facade: $client->Series()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->series()
    // resolves here too.
    public function Series($data = null)
    {
        require_once __DIR__ . '/entity/series_entity.php';
        if ($data === null) {
            if ($this->_series === null) {
                $this->_series = new SeriesEntity($this, null);
            }
            return $this->_series;
        }
        return new SeriesEntity($this, $data);
    }


    private $_tag = null;

    // Canonical facade: $client->Tag()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->tag()
    // resolves here too.
    public function Tag($data = null)
    {
        require_once __DIR__ . '/entity/tag_entity.php';
        if ($data === null) {
            if ($this->_tag === null) {
                $this->_tag = new TagEntity($this, null);
            }
            return $this->_tag;
        }
        return new TagEntity($this, $data);
    }


    private $_url = null;

    // Canonical facade: $client->Url()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->url()
    // resolves here too.
    public function Url($data = null)
    {
        require_once __DIR__ . '/entity/url_entity.php';
        if ($data === null) {
            if ($this->_url === null) {
                $this->_url = new UrlEntity($this, null);
            }
            return $this->_url;
        }
        return new UrlEntity($this, $data);
    }


    private $_work = null;

    // Canonical facade: $client->Work()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->work()
    // resolves here too.
    public function Work($data = null)
    {
        require_once __DIR__ . '/entity/work_entity.php';
        if ($data === null) {
            if ($this->_work === null) {
                $this->_work = new WorkEntity($this, null);
            }
            return $this->_work;
        }
        return new WorkEntity($this, $data);
    }


    private $_work_list = null;

    // Canonical facade: $client->WorkList()->list() / ->load(["id" => ...]).
    // PHP method names are case-insensitive, so lowercase $client->work_list()
    // resolves here too.
    public function WorkList($data = null)
    {
        require_once __DIR__ . '/entity/work_list_entity.php';
        if ($data === null) {
            if ($this->_work_list === null) {
                $this->_work_list = new WorkListEntity($this, null);
            }
            return $this->_work_list;
        }
        return new WorkListEntity($this, $data);
    }



    public static function test(?array $testopts = null, ?array $sdkopts = null): self
    {
        $sdkopts = $sdkopts ?? [];
        $sdkopts = Struct::clone($sdkopts);
        $sdkopts = is_array($sdkopts) ? $sdkopts : [];

        $testopts = $testopts ?? [];
        $testopts = Struct::clone($testopts);
        $testopts = is_array($testopts) ? $testopts : [];
        $testopts["active"] = true;

        if (!isset($sdkopts["feature"])) {
            $sdkopts["feature"] = [];
        }
        $sdkopts["feature"]["test"] = $testopts;

        $sdk = new MusicbrainzSDK($sdkopts);
        $sdk->mode = "test";
        return $sdk;
    }
}
