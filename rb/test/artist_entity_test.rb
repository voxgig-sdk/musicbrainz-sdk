# Artist entity test

require "minitest/autorun"
require "json"
require_relative "../Musicbrainz_sdk"
require_relative "runner"

class ArtistEntityTest < Minitest::Test
  def test_create_instance
    testsdk = MusicbrainzSDK.test(nil, nil)
    ent = testsdk.Artist(nil)
    assert !ent.nil?
  end

  def test_basic_flow
    setup = artist_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["list", "load"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "artist." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set MUSICBRAINZ_TEST_ARTIST_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # Bootstrap entity data from existing test data.
    artist_ref01_data_raw = Vs.items(Helpers.to_map(
      Vs.getpath(setup[:data], "existing.artist")))
    artist_ref01_data = nil
    if artist_ref01_data_raw.length > 0
      artist_ref01_data = Helpers.to_map(artist_ref01_data_raw[0][1])
    end

    # LIST
    artist_ref01_ent = client.Artist(nil)
    artist_ref01_match = {}

    artist_ref01_list_result = artist_ref01_ent.list(artist_ref01_match, nil)
    assert artist_ref01_list_result.is_a?(Array)

    # LOAD
    artist_ref01_match_dt0 = {
      "id" => artist_ref01_data["id"],
    }
    artist_ref01_data_dt0_loaded = artist_ref01_ent.load(artist_ref01_match_dt0, nil)
    artist_ref01_data_dt0_load_result = Helpers.to_map(artist_ref01_data_dt0_loaded)
    assert !artist_ref01_data_dt0_load_result.nil?
    assert_equal artist_ref01_data_dt0_load_result["id"], artist_ref01_data["id"]

  end
end

def artist_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "artist", "ArtistTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = MusicbrainzSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["artist01", "artist02", "artist03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Detect ENTID env override before envOverride consumes it. When live
  # mode is on without a real override, the basic test runs against synthetic
  # IDs from the fixture and 4xx's. Surface this so the test can skip.
  entid_env_raw = ENV["MUSICBRAINZ_TEST_ARTIST_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "MUSICBRAINZ_TEST_ARTIST_ENTID" => idmap,
    "MUSICBRAINZ_TEST_LIVE" => "FALSE",
    "MUSICBRAINZ_TEST_EXPLAIN" => "FALSE",
    "MUSICBRAINZ_APIKEY" => "NONE",
  })

  idmap_resolved = Helpers.to_map(
    env["MUSICBRAINZ_TEST_ARTIST_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["MUSICBRAINZ_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
        "apikey" => env["MUSICBRAINZ_APIKEY"],
      },
      extra || {},
    ])
    client = MusicbrainzSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["MUSICBRAINZ_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["MUSICBRAINZ_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
