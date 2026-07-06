// Typed models for the Musicbrainz SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import "encoding/json"

// Area is the typed data model for the area entity.
type Area struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	LifeSpan *map[string]any `json:"life_span,omitempty"`
	Name *string `json:"name,omitempty"`
	SortName *string `json:"sort_name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// AreaLoadMatch is the typed request payload for Area.LoadTyped.
type AreaLoadMatch struct {
	Id string `json:"id"`
}

// AreaListMatch is the typed request payload for Area.ListTyped.
type AreaListMatch struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	LifeSpan *map[string]any `json:"life_span,omitempty"`
	Name *string `json:"name,omitempty"`
	SortName *string `json:"sort_name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// Artist is the typed data model for the artist entity.
type Artist struct {
	Country *string `json:"country,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Gender *string `json:"gender,omitempty"`
	Id *string `json:"id,omitempty"`
	LifeSpan *map[string]any `json:"life_span,omitempty"`
	Name *string `json:"name,omitempty"`
	SortName *string `json:"sort_name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// ArtistLoadMatch is the typed request payload for Artist.LoadTyped.
type ArtistLoadMatch struct {
	Id string `json:"id"`
}

// ArtistListMatch is the typed request payload for Artist.ListTyped.
type ArtistListMatch struct {
	Country *string `json:"country,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Gender *string `json:"gender,omitempty"`
	Id *string `json:"id,omitempty"`
	LifeSpan *map[string]any `json:"life_span,omitempty"`
	Name *string `json:"name,omitempty"`
	SortName *string `json:"sort_name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// Collection is the typed data model for the collection entity.
type Collection struct {
	Editor *string `json:"editor,omitempty"`
	EntityType *string `json:"entity_type,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
}

// CollectionListMatch is the typed request payload for Collection.ListTyped.
type CollectionListMatch struct {
	Editor *string `json:"editor,omitempty"`
	EntityType *string `json:"entity_type,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
}

// Event is the typed data model for the event entity.
type Event struct {
	Cancelled *bool `json:"cancelled,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	LifeSpan *map[string]any `json:"life_span,omitempty"`
	Name *string `json:"name,omitempty"`
	Time *string `json:"time,omitempty"`
	Type *string `json:"type,omitempty"`
}

// EventLoadMatch is the typed request payload for Event.LoadTyped.
type EventLoadMatch struct {
	Id string `json:"id"`
}

// EventListMatch is the typed request payload for Event.ListTyped.
type EventListMatch struct {
	Cancelled *bool `json:"cancelled,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	LifeSpan *map[string]any `json:"life_span,omitempty"`
	Name *string `json:"name,omitempty"`
	Time *string `json:"time,omitempty"`
	Type *string `json:"type,omitempty"`
}

// Genre is the typed data model for the genre entity.
type Genre struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
}

// GenreLoadMatch is the typed request payload for Genre.LoadTyped.
type GenreLoadMatch struct {
	Id string `json:"id"`
}

// GenreListMatch is the typed request payload for Genre.ListTyped.
type GenreListMatch struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
}

// Instrument is the typed data model for the instrument entity.
type Instrument struct {
	Description *string `json:"description,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// InstrumentLoadMatch is the typed request payload for Instrument.LoadTyped.
type InstrumentLoadMatch struct {
	Id string `json:"id"`
}

// InstrumentListMatch is the typed request payload for Instrument.ListTyped.
type InstrumentListMatch struct {
	Description *string `json:"description,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// Label is the typed data model for the label entity.
type Label struct {
	Country *string `json:"country,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	LabelCode *int `json:"label_code,omitempty"`
	LifeSpan *map[string]any `json:"life_span,omitempty"`
	Name *string `json:"name,omitempty"`
	SortName *string `json:"sort_name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// LabelLoadMatch is the typed request payload for Label.LoadTyped.
type LabelLoadMatch struct {
	Id string `json:"id"`
}

// LabelListMatch is the typed request payload for Label.ListTyped.
type LabelListMatch struct {
	Country *string `json:"country,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	LabelCode *int `json:"label_code,omitempty"`
	LifeSpan *map[string]any `json:"life_span,omitempty"`
	Name *string `json:"name,omitempty"`
	SortName *string `json:"sort_name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// Place is the typed data model for the place entity.
type Place struct {
	Address *string `json:"address,omitempty"`
	Coordinate *map[string]any `json:"coordinate,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	LifeSpan *map[string]any `json:"life_span,omitempty"`
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// PlaceLoadMatch is the typed request payload for Place.LoadTyped.
type PlaceLoadMatch struct {
	Id string `json:"id"`
}

// PlaceListMatch is the typed request payload for Place.ListTyped.
type PlaceListMatch struct {
	Address *string `json:"address,omitempty"`
	Coordinate *map[string]any `json:"coordinate,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	LifeSpan *map[string]any `json:"life_span,omitempty"`
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// Rating is the typed data model for the rating entity.
type Rating struct {
}

// RatingLoadMatch is the typed request payload for Rating.LoadTyped.
type RatingLoadMatch struct {
}

// RatingCreateData is the typed request payload for Rating.CreateTyped.
type RatingCreateData struct {
}

// Recording is the typed data model for the recording entity.
type Recording struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Length *int `json:"length,omitempty"`
	Title *string `json:"title,omitempty"`
	Video *bool `json:"video,omitempty"`
}

// RecordingLoadMatch is the typed request payload for Recording.LoadTyped.
type RecordingLoadMatch struct {
	Id string `json:"id"`
}

// RecordingListMatch is the typed request payload for Recording.ListTyped.
type RecordingListMatch struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Length *int `json:"length,omitempty"`
	Title *string `json:"title,omitempty"`
	Video *bool `json:"video,omitempty"`
}

// RecordingList is the typed data model for the recording_list entity.
type RecordingList struct {
	Count *int `json:"count,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Recording *[]any `json:"recording,omitempty"`
}

// RecordingListLoadMatch is the typed request payload for RecordingList.LoadTyped.
type RecordingListLoadMatch struct {
	Isrc string `json:"isrc"`
}

// Release is the typed data model for the release entity.
type Release struct {
	Barcode *string `json:"barcode,omitempty"`
	Country *string `json:"country,omitempty"`
	Date *string `json:"date,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Packaging *string `json:"packaging,omitempty"`
	Status *string `json:"status,omitempty"`
	Title *string `json:"title,omitempty"`
}

// ReleaseLoadMatch is the typed request payload for Release.LoadTyped.
type ReleaseLoadMatch struct {
	Id string `json:"id"`
}

// ReleaseListMatch is the typed request payload for Release.ListTyped.
type ReleaseListMatch struct {
	Barcode *string `json:"barcode,omitempty"`
	Country *string `json:"country,omitempty"`
	Date *string `json:"date,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Packaging *string `json:"packaging,omitempty"`
	Status *string `json:"status,omitempty"`
	Title *string `json:"title,omitempty"`
}

// ReleaseGroup is the typed data model for the release_group entity.
type ReleaseGroup struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	FirstReleaseDate *string `json:"first_release_date,omitempty"`
	Id *string `json:"id,omitempty"`
	PrimaryType *string `json:"primary_type,omitempty"`
	SecondaryType *[]any `json:"secondary_type,omitempty"`
	Title *string `json:"title,omitempty"`
}

// ReleaseGroupLoadMatch is the typed request payload for ReleaseGroup.LoadTyped.
type ReleaseGroupLoadMatch struct {
	Id string `json:"id"`
}

// ReleaseGroupListMatch is the typed request payload for ReleaseGroup.ListTyped.
type ReleaseGroupListMatch struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	FirstReleaseDate *string `json:"first_release_date,omitempty"`
	Id *string `json:"id,omitempty"`
	PrimaryType *string `json:"primary_type,omitempty"`
	SecondaryType *[]any `json:"secondary_type,omitempty"`
	Title *string `json:"title,omitempty"`
}

// ReleaseList is the typed data model for the release_list entity.
type ReleaseList struct {
	Count *int `json:"count,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Release *[]any `json:"release,omitempty"`
}

// ReleaseListLoadMatch is the typed request payload for ReleaseList.LoadTyped.
type ReleaseListLoadMatch struct {
	Discid string `json:"discid"`
}

// Series is the typed data model for the series entity.
type Series struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// SeriesLoadMatch is the typed request payload for Series.LoadTyped.
type SeriesLoadMatch struct {
	Id string `json:"id"`
}

// SeriesListMatch is the typed request payload for Series.ListTyped.
type SeriesListMatch struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// Tag is the typed data model for the tag entity.
type Tag struct {
}

// TagLoadMatch is the typed request payload for Tag.LoadTyped.
type TagLoadMatch struct {
}

// TagCreateData is the typed request payload for Tag.CreateTyped.
type TagCreateData struct {
}

// Url is the typed data model for the url entity.
type Url struct {
	Id *string `json:"id,omitempty"`
	Resource *string `json:"resource,omitempty"`
}

// UrlLoadMatch is the typed request payload for Url.LoadTyped.
type UrlLoadMatch struct {
	Id string `json:"id"`
}

// UrlListMatch is the typed request payload for Url.ListTyped.
type UrlListMatch struct {
	Id *string `json:"id,omitempty"`
	Resource *string `json:"resource,omitempty"`
}

// Work is the typed data model for the work entity.
type Work struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Language *string `json:"language,omitempty"`
	Title *string `json:"title,omitempty"`
	Type *string `json:"type,omitempty"`
}

// WorkLoadMatch is the typed request payload for Work.LoadTyped.
type WorkLoadMatch struct {
	Id string `json:"id"`
}

// WorkListMatch is the typed request payload for Work.ListTyped.
type WorkListMatch struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Language *string `json:"language,omitempty"`
	Title *string `json:"title,omitempty"`
	Type *string `json:"type,omitempty"`
}

// WorkList is the typed data model for the work_list entity.
type WorkList struct {
	Count *int `json:"count,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Work *[]any `json:"work,omitempty"`
}

// WorkListLoadMatch is the typed request payload for WorkList.LoadTyped.
type WorkListLoadMatch struct {
	Iswc string `json:"iswc"`
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedFrom decodes a runtime value (a map[string]any produced by the op
// pipeline) into a typed model T via a JSON round-trip. On any error it
// returns the zero value of T; the op's own (value, error) tuple carries the
// real error.
func typedFrom[T any](v any) T {
	var out T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value ([]any of maps) into a typed
// slice []T via a JSON round-trip, for list ops.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
