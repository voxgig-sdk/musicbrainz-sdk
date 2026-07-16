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

func TestReleaseGroupEntity(t *testing.T) {
	t.Run("instance", func(t *testing.T) {
		testsdk := sdk.TestSDK(nil, nil)
		ent := testsdk.ReleaseGroup(nil)
		if ent == nil {
			t.Fatal("expected non-nil ReleaseGroupEntity")
		}
	})

	// Feature #4: the entity Stream(action, ...) method runs the op pipeline and
	// returns a channel over result items. With the streaming feature active it
	// yields the feature's incremental output; otherwise it falls back to the
	// materialised list so Stream always yields.
	t.Run("stream", func(t *testing.T) {
		seed := map[string]any{
			"entity": map[string]any{
				"release_group": map[string]any{
					"s1": map[string]any{"id": "s1"},
					"s2": map[string]any{"id": "s2"},
					"s3": map[string]any{"id": "s3"},
				},
			},
		}

		// Fallback: streaming inactive -> yields the materialised list items.
		base := sdk.TestSDK(seed, nil)
		var seen []any
		for item := range base.ReleaseGroup(nil).Stream("list", nil, nil) {
			seen = append(seen, item)
		}
		if len(seen) != 3 {
			t.Fatalf("expected 3 streamed items, got %d", len(seen))
		}

		// Inbound: streaming active -> yields each item from the feature iterator.
		hasStreaming := false
		if fm, ok := core.MakeConfig()["feature"].(map[string]any); ok {
			_, hasStreaming = fm["streaming"]
		}
		if hasStreaming {
			streamSdk := sdk.TestSDK(seed, map[string]any{
				"feature": map[string]any{"streaming": map[string]any{"active": true}},
			})
			var got []any
			for item := range streamSdk.ReleaseGroup(nil).Stream("list", nil, nil) {
				if sub, ok := item.([]any); ok {
					got = append(got, sub...)
				} else {
					got = append(got, item)
				}
			}
			if len(got) != 3 {
				t.Fatalf("expected 3 items via streaming feature, got %d", len(got))
			}
		}
	})

	t.Run("basic", func(t *testing.T) {
		setup := release_groupBasicSetup(nil)
		// Per-op sdk-test-control.json skip — basic test exercises a flow
		// with multiple ops; skipping any op skips the whole flow.
		_mode := "unit"
		if setup.live {
			_mode = "live"
		}
		for _, _op := range []string{"list", "load"} {
			if _shouldSkip, _reason := isControlSkipped("entityOp", "release_group." + _op, _mode); _shouldSkip {
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
			t.Skip("live entity test uses synthetic IDs from fixture — set MUSICBRAINZ_TEST_RELEASE_GROUP_ENTID JSON to run live")
			return
		}
		client := setup.client

		// Bootstrap entity data from existing test data (no create step in flow).
		releaseGroupRef01DataRaw := vs.Items(core.ToMapAny(vs.GetPath("existing.release_group", setup.data)))
		var releaseGroupRef01Data map[string]any
		if len(releaseGroupRef01DataRaw) > 0 {
			releaseGroupRef01Data = core.ToMapAny(releaseGroupRef01DataRaw[0][1])
		}
		// Discard guards against Go's unused-var check when the flow's steps
		// happen not to consume the bootstrap data (e.g. list-only flows).
		_ = releaseGroupRef01Data

		// LIST
		releaseGroupRef01Ent := client.ReleaseGroup(nil)
		releaseGroupRef01Match := map[string]any{}

		releaseGroupRef01ListResult, err := releaseGroupRef01Ent.List(releaseGroupRef01Match, nil)
		if err != nil {
			t.Fatalf("list failed: %v", err)
		}
		_, releaseGroupRef01ListOk := releaseGroupRef01ListResult.([]any)
		if !releaseGroupRef01ListOk {
			t.Fatalf("expected list result to be an array, got %T", releaseGroupRef01ListResult)
		}

		// LOAD
		releaseGroupRef01MatchDt0 := map[string]any{
			"id": releaseGroupRef01Data["id"],
		}
		releaseGroupRef01DataDt0Loaded, err := releaseGroupRef01Ent.Load(releaseGroupRef01MatchDt0, nil)
		if err != nil {
			t.Fatalf("load failed: %v", err)
		}
		releaseGroupRef01DataDt0LoadResult := core.ToMapAny(releaseGroupRef01DataDt0Loaded)
		if releaseGroupRef01DataDt0LoadResult == nil {
			t.Fatal("expected load result to be a map")
		}
		if releaseGroupRef01DataDt0LoadResult["id"] != releaseGroupRef01Data["id"] {
			t.Fatal("expected load result id to match")
		}

	})
}

func release_groupBasicSetup(extra map[string]any) *entityTestSetup {
	loadEnvLocal()

	_, filename, _, _ := runtime.Caller(0)
	dir := filepath.Dir(filename)

	entityDataFile := filepath.Join(dir, "..", "..", ".sdk", "test", "entity", "release_group", "ReleaseGroupTestData.json")

	entityDataSource, err := os.ReadFile(entityDataFile)
	if err != nil {
		panic("failed to read release_group test data: " + err.Error())
	}

	var entityData map[string]any
	if err := json.Unmarshal(entityDataSource, &entityData); err != nil {
		panic("failed to parse release_group test data: " + err.Error())
	}

	options := map[string]any{}
	options["entity"] = entityData["existing"]

	client := sdk.TestSDK(options, extra)

	// Generate idmap via transform, matching TS pattern.
	idmap := vs.Transform(
		[]any{"release_group01", "release_group02", "release_group03"},
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
	entidEnvRaw := os.Getenv("MUSICBRAINZ_TEST_RELEASE_GROUP_ENTID")
	idmapOverridden := entidEnvRaw != "" && strings.HasPrefix(strings.TrimSpace(entidEnvRaw), "{")

	env := envOverride(map[string]any{
		"MUSICBRAINZ_TEST_RELEASE_GROUP_ENTID": idmap,
		"MUSICBRAINZ_TEST_LIVE":      "FALSE",
		"MUSICBRAINZ_TEST_EXPLAIN":   "FALSE",
		"MUSICBRAINZ_APIKEY":         "NONE",
	})

	idmapResolved := core.ToMapAny(env["MUSICBRAINZ_TEST_RELEASE_GROUP_ENTID"])
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
