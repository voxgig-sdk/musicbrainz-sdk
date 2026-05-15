package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/musicbrainz-sdk"
	"github.com/voxgig-sdk/musicbrainz-sdk/core"

	vs "github.com/voxgig/struct"
)

func TestGenreEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.Genre(nil)
		if ent == nil {
			t.Fatal("expected non-nil GenreEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := genreBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"list", "load"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "genre." + _op, _mode); _shouldSkip {
				if _reason == "" {
					_reason = "skipped via sdk-test-control.json"
				}
				t.Skip(_reason)
				return
			}
		}
		// The basic flow consumes synthetic IDs from the fixture. In live mode
		// without an *_ENTID env override, those IDs hit the live API and 4xx.
		if setup.syntheticOnly {
			t.Skip("live entity test uses synthetic IDs from fixture — set MUSICBRAINZ_TEST_GENRE_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		genreRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.genre", setup.data)))
		var genreRef01Data map[string]any
		if len(genreRef01DataRaw) > 0 {
			genreRef01Data = core.ToMapAny(genreRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = genreRef01Data

		// LIST
		genreRef01Ent := client.Genre(nil)
		genreRef01Match := map[string]any{}

		genreRef01ListResult, err := genreRef01Ent.List(genreRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		_, genreRef01ListOk := genreRef01ListResult.([]any)
		if !genreRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", genreRef01ListResult)
		}

		// LOAD
		genreRef01MatchDt0 := map[string]any{
			"id": genreRef01Data["id"],
		}
		genreRef01DataDt0Loaded, err := genreRef01Ent.Load(genreRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		genreRef01DataDt0LoadResult := core.ToMapAny(genreRef01DataDt0Loaded)
		if genreRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if genreRef01DataDt0LoadResult["id"] != genreRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

	})
}

func genreBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "genre", "GenreTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read genre test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse genre test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"genre01", "genre02", "genre03"},
		map[string]any{
			"`$PACK`": []any{"", map[string]any{
				"`$KEY`": "`$COPY`",
				"`$VAL`": []any{"`$FORMAT`", "upper", "`$COPY`"},
			}},
		},
	)

	// Detect ENTID env override before envOverride consumes it. When live
	// mode is on without a real override, the basic test runs against synthetic
	// IDs from the fixture and 4xx's. Surface this so the test can skip.
	entidEnvRaw := os.Getenv("MUSICBRAINZ_TEST_GENRE_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"MUSICBRAINZ_TEST_GENRE_ENTID": idmap,
		"MUSICBRAINZ_TEST_LIVE":      "FALSE",
		"MUSICBRAINZ_TEST_EXPLAIN":   "FALSE",
		"MUSICBRAINZ_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["MUSICBRAINZ_TEST_GENRE_ENTID"])
	if idmapResolved == nil {
		idmapResolved = core.ToMapAny(idmap)
	}

	if env["MUSICBRAINZ_TEST_LIVE"] == "TRUE" {
		mergedOpts := vs.Merge([]any{
			map[string]any{
				"apikey": env["MUSICBRAINZ_APIKEY"],
			},
			extra,
		})
		client = sdk.NewMusicbrainzSDK(core.ToMapAny(mergedOpts))
	}

	live := env["MUSICBRAINZ_TEST_LIVE"] == "TRUE"
	return &entityTestSetup{
		client:        client,
		data:          entityData,
		idmap:         idmapResolved,
		env:           env,
		explain:       env["MUSICBRAINZ_TEST_EXPLAIN"] == "TRUE",
		live:          live,
		syntheticOnly: live && !idmapOverridden,
		now:           time.Now().UnixMilli(),
	}
}
