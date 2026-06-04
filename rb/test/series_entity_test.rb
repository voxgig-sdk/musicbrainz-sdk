# Series entity test

require "minitest/autorun"
require "json"
require_relative "../Musicbrainz_sdk"
require_relative "runner"

class SeriesEntityTest < Minitest::Test
  def test_create_instance
    testsdk = MusicbrainzSDK.test(nil, nil)
    ent = testsdk.Series(nil)
    assert !ent.nil?
  end

  def test_basic_flow
    setup = series_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["list", "load"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "series." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    # The basic flow consumes synthetic IDs from the fixture. In live mode
    # without an *_ENTID env override, those IDs hit the live API and 4xx.
    if setup[:synthetic_only]
      skip "live entity test uses synthetic IDs from fixture — set MUSICBRAINZ_TEST_SERIES_ENTID JSON to run live"
      return
    end
    client = setup[:client]

    # Bootstrap entity data from existing test data.
    series_ref01_data_raw = Vs.items(Helpers.to_map(
      Vs.getpath(setup[:data], "existing.series")))
    series_ref01_data = nil
    if series_ref01_data_raw.length > 0
      series_ref01_data = Helpers.to_map(series_ref01_data_raw[0][1])
    end

    # LIST
    series_ref01_ent = client.Series(nil)
    series_ref01_match = {}

    series_ref01_list_result, err = series_ref01_ent.list(series_ref01_match, nil)
    assert_nil err
    assert series_ref01_list_result.is_a?(Array)

    # LOAD
    series_ref01_match_dt0 = {
      "id" => series_ref01_data["id"],
    }
    series_ref01_data_dt0_loaded, err = series_ref01_ent.load(series_ref01_match_dt0, nil)
    assert_nil err
    series_ref01_data_dt0_load_result = Helpers.to_map(series_ref01_data_dt0_loaded)
    assert !series_ref01_data_dt0_load_result.nil?
    assert_equal series_ref01_data_dt0_load_result["id"], series_ref01_data["id"]

  end
end

def series_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "series", "SeriesTestData.json")
  entity_data_source = File.read(entity_data_file)
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = MusicbrainzSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["series01", "series02", "series03"],
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
  entid_env_raw = ENV["MUSICBRAINZ_TEST_SERIES_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "MUSICBRAINZ_TEST_SERIES_ENTID" => idmap,
    "MUSICBRAINZ_TEST_LIVE" => "FALSE",
    "MUSICBRAINZ_TEST_EXPLAIN" => "FALSE",
  })

  idmap_resolved = Helpers.to_map(
    env["MUSICBRAINZ_TEST_SERIES_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["MUSICBRAINZ_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      {
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
