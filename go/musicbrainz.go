package voxgigmusicbrainzsdk

import (
	"github.com/voxgig-sdk/musicbrainz-sdk/go/core"
	"github.com/voxgig-sdk/musicbrainz-sdk/go/entity"
	"github.com/voxgig-sdk/musicbrainz-sdk/go/feature"
	_ "github.com/voxgig-sdk/musicbrainz-sdk/go/utility"
)

// Type aliases preserve external API.
type MusicbrainzSDK = core.MusicbrainzSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type MusicbrainzEntity = core.MusicbrainzEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type MusicbrainzError = core.MusicbrainzError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewAreaEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewAreaEntity(client, entopts)
	}
	core.NewArtistEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewArtistEntity(client, entopts)
	}
	core.NewCollectionEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewCollectionEntity(client, entopts)
	}
	core.NewEventEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewEventEntity(client, entopts)
	}
	core.NewGenreEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewGenreEntity(client, entopts)
	}
	core.NewInstrumentEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewInstrumentEntity(client, entopts)
	}
	core.NewLabelEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewLabelEntity(client, entopts)
	}
	core.NewPlaceEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewPlaceEntity(client, entopts)
	}
	core.NewRatingEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewRatingEntity(client, entopts)
	}
	core.NewRecordingEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewRecordingEntity(client, entopts)
	}
	core.NewRecordingListEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewRecordingListEntity(client, entopts)
	}
	core.NewReleaseEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewReleaseEntity(client, entopts)
	}
	core.NewReleaseGroupEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewReleaseGroupEntity(client, entopts)
	}
	core.NewReleaseListEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewReleaseListEntity(client, entopts)
	}
	core.NewSeriesEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewSeriesEntity(client, entopts)
	}
	core.NewTagEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewTagEntity(client, entopts)
	}
	core.NewUrlEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewUrlEntity(client, entopts)
	}
	core.NewWorkEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewWorkEntity(client, entopts)
	}
	core.NewWorkListEntityFunc = func(client *core.MusicbrainzSDK, entopts map[string]any) core.MusicbrainzEntity {
		return entity.NewWorkListEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewMusicbrainzSDK = core.NewMusicbrainzSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var SharedConfig = core.SharedConfig

// No-arg convenience constructors. Go has no default-argument syntax,
// so these aliases let callers write `sdk.New()` / `sdk.Test()`
// instead of `sdk.NewMusicbrainzSDK(nil)` / `sdk.TestSDK(nil, nil)`
// for the common no-options case.
func New() *MusicbrainzSDK  { return NewMusicbrainzSDK(nil) }
func Test() *MusicbrainzSDK { return TestSDK(nil, nil) }
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
