package sdktest

import (
	"encoding/json"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	sdk "github.com/voxgig-sdk/musicbrainz-sdk/go"
	"github.com/voxgig-sdk/musicbrainz-sdk/go/core"

	vs "github.com/voxgig-sdk/musicbrainz-sdk/go/utility/struct"
)

func TestRecordingListEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.RecordingList(nil)
		if ent == nil {
			t.Fatal("expected non-nil RecordingListEntity")
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := recording_listBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"load"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "recording_list." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set MUSICBRAINZ_TEST_RECORDING_LIST_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		recordingListRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.recording_list", setup.data)))
		var recordingListRef01Data map[string]any
		if len(recordingListRef01DataRaw) > 0 {
			recordingListRef01Data = core.ToMapAny(recordingListRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = recordingListRef01Data

		// LOAD
		recordingListRef01Ent := client.RecordingList(nil)
		recordingListRef01MatchDt0 := map[string]any{}
		recordingListRef01DataDt0Loaded, err := recordingListRef01Ent.Load(recordingListRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		if recordingListRef01DataDt0Loaded == nil {
			t.Fatal("expected load result to be non-nil")
		}

	})
}

func recording_listBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "recording_list", "RecordingListTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read recording_list test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse recording_list test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"recording_list01", "recording_list02", "recording_list03", "isrc01", "isrc02", "isrc03"},
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
	entidEnvRaw := os.Getenv("MUSICBRAINZ_TEST_RECORDING_LIST_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"MUSICBRAINZ_TEST_RECORDING_LIST_ENTID": idmap,
		"MUSICBRAINZ_TEST_LIVE":      "FALSE",
		"MUSICBRAINZ_TEST_EXPLAIN":   "FALSE",
		"MUSICBRAINZ_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["MUSICBRAINZ_TEST_RECORDING_LIST_ENTID"])
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
