package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewAreaEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewArtistEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewCollectionEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewEventEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewGenreEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewInstrumentEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewLabelEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewPlaceEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewRatingEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewRecordingEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewRecordingListEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewReleaseEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewReleaseGroupEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewReleaseListEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewSeriesEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewTagEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewUrlEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewWorkEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

var NewWorkListEntityFunc func(client *MusicbrainzSDK, entopts map[string]any) MusicbrainzEntity

