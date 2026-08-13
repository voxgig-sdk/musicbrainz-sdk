<?php
declare(strict_types=1);

// Rating entity test

require_once __DIR__ . '/../musicbrainz_sdk.php';
require_once __DIR__ . '/Runner.php';

use PHPUnit\Framework\TestCase;
use Voxgig\Struct\Struct as Vs;

class RatingEntityTest extends TestCase
{
    public function test_create_instance(): void
    {
        $testsdk = MusicbrainzSDK::test(null, null);
        $ent = $testsdk->Rating(null);
        $this->assertNotNull($ent);
    }

    public function test_basic_flow(): void
    {
        $setup = rating_basic_setup(null);
        // Per-op sdk-test-control.json skip.
        $_live = !empty($setup["live"]);
        foreach (["create", "load"] as $_op) {
            [$_shouldSkip, $_reason] = Runner::is_control_skipped("entityOp", "rating." . $_op, $_live ? "live" : "unit");
            if ($_shouldSkip) {
                $this->markTestSkipped($_reason ?? "skipped via sdk-test-control.json");
                return;
            }
        }
        // The basic flow consumes synthetic IDs from the fixture. In live mode
        // without an *_ENTID env override, those IDs hit the live API and 4xx.
        if (!empty($setup["synthetic_only"])) {
            $this->markTestSkipped("live entity test uses synthetic IDs from fixture — set MUSICBRAINZ_TEST_RATING_ENTID JSON to run live");
            return;
        }
        $client = $setup["client"];

        // CREATE
        $rating_ref01_ent = $client->Rating(null);
        $rating_ref01_data = Helpers::to_map(Vs::getprop(
            Vs::getpath($setup["data"], "new.rating"), "rating_ref01"));

        $rating_ref01_data_result = $rating_ref01_ent->create($rating_ref01_data, null);
        $rating_ref01_data = Helpers::to_map(is_object($rating_ref01_data_result) && method_exists($rating_ref01_data_result, 'data_get') ? $rating_ref01_data_result->data_get() : $rating_ref01_data_result);
        $this->assertNotNull($rating_ref01_data);

        // LOAD
        $rating_ref01_match_dt0 = [];
        $rating_ref01_data_dt0_loaded = $rating_ref01_ent->load($rating_ref01_match_dt0, null);
        $this->assertNotNull($rating_ref01_data_dt0_loaded);

    }
}

function rating_basic_setup($extra)
{
    Runner::load_env_local();

    $entity_data_file = __DIR__ . '/../../.sdk/test/entity/rating/RatingTestData.json';
    $entity_data_source = file_get_contents($entity_data_file);
    $entity_data = json_decode($entity_data_source, true);

    $options = [];
    $options["entity"] = $entity_data["existing"];

    $client = MusicbrainzSDK::test($options, $extra);

    // Generate idmap.
    $idmap = [];
    foreach (["rating01", "rating02", "rating03"] as $k) {
        $idmap[$k] = strtoupper($k);
    }

    // Detect ENTID env override before envOverride consumes it. When live
    // mode is on without a real override, the basic test runs against synthetic
    // IDs from the fixture and 4xx's. Surface this so the test can skip.
    $entid_env_raw = getenv("MUSICBRAINZ_TEST_RATING_ENTID");
    $idmap_overridden = $entid_env_raw !== false && str_starts_with(trim($entid_env_raw), "{");

    $env = Runner::env_override([
        "MUSICBRAINZ_TEST_RATING_ENTID" => $idmap,
        "MUSICBRAINZ_TEST_LIVE" => "FALSE",
        "MUSICBRAINZ_TEST_EXPLAIN" => "FALSE",
        "MUSICBRAINZ_APIKEY" => "NONE",
    ]);

    $idmap_resolved = Helpers::to_map(
        $env["MUSICBRAINZ_TEST_RATING_ENTID"]);
    if ($idmap_resolved === null) {
        $idmap_resolved = Helpers::to_map($idmap);
    }

    if ($env["MUSICBRAINZ_TEST_LIVE"] === "TRUE") {
        $merged_opts = Vs::merge([
            [
                "apikey" => $env["MUSICBRAINZ_APIKEY"],
            ],
            $extra ?? [],
        ]);
        $client = new MusicbrainzSDK(Helpers::to_map($merged_opts));
    }

    $live = $env["MUSICBRAINZ_TEST_LIVE"] === "TRUE";
    return [
        "client" => $client,
        "data" => $entity_data,
        "idmap" => $idmap_resolved,
        "env" => $env,
        "explain" => $env["MUSICBRAINZ_TEST_EXPLAIN"] === "TRUE",
        "live" => $live,
        "synthetic_only" => $live && !$idmap_overridden,
        "now" => (int)(microtime(true) * 1000),
    ];
}
