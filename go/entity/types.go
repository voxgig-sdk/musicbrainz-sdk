// Typed models for the Musicbrainz SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import (
	"encoding/json"

	"github.com/voxgig-sdk/musicbrainz-sdk/go/core"
)

// Area is the typed data model for the area entity.
type Area struct {
	Begin *string `json:"begin,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	End *string `json:"end,omitempty"`
	Ended *bool `json:"ended,omitempty"`
	Id *string `json:"id,omitempty"`
	Lifespan *map[string]any `json:"lifespan,omitempty"`
	Name *string `json:"name,omitempty"`
	Sortname *string `json:"sortname,omitempty"`
	Type *string `json:"type,omitempty"`
}

// AreaLoadMatch is the typed request payload for Area.LoadTyped.
type AreaLoadMatch struct {
	Id string `json:"id"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
}

// AreaListMatch is the typed request payload for Area.ListTyped.
type AreaListMatch struct {
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Query *string `json:"query,omitempty"`
}

// Artist is the typed data model for the artist entity.
type Artist struct {
	Begin *string `json:"begin,omitempty"`
	Country *string `json:"country,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	End *string `json:"end,omitempty"`
	Ended *bool `json:"ended,omitempty"`
	Gender *string `json:"gender,omitempty"`
	Id *string `json:"id,omitempty"`
	Lifespan *map[string]any `json:"lifespan,omitempty"`
	Name *string `json:"name,omitempty"`
	Sortname *string `json:"sortname,omitempty"`
	Type *string `json:"type,omitempty"`
}

// ArtistLoadMatch is the typed request payload for Artist.LoadTyped.
type ArtistLoadMatch struct {
	Id string `json:"id"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Status *string `json:"status,omitempty"`
	Type *string `json:"type,omitempty"`
}

// ArtistListMatch is the typed request payload for Artist.ListTyped.
type ArtistListMatch struct {
	Area *string `json:"area,omitempty"`
	Collection *string `json:"collection,omitempty"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Query *string `json:"query,omitempty"`
	Recording *string `json:"recording,omitempty"`
	Release *string `json:"release,omitempty"`
	ReleaseGroup *string `json:"release_group,omitempty"`
	Work *string `json:"work,omitempty"`
}

// Collection is the typed data model for the collection entity.
type Collection struct {
	Editor *string `json:"editor,omitempty"`
	Entitytype *string `json:"entitytype,omitempty"`
	Id *string `json:"id,omitempty"`
	Name *string `json:"name,omitempty"`
}

// CollectionListMatch is the typed request payload for Collection.ListTyped.
type CollectionListMatch struct {
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
}

// Event is the typed data model for the event entity.
type Event struct {
	Begin *string `json:"begin,omitempty"`
	Cancelled *bool `json:"cancelled,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	End *string `json:"end,omitempty"`
	Ended *bool `json:"ended,omitempty"`
	Id *string `json:"id,omitempty"`
	Lifespan *map[string]any `json:"lifespan,omitempty"`
	Name *string `json:"name,omitempty"`
	Time *string `json:"time,omitempty"`
	Type *string `json:"type,omitempty"`
}

// EventLoadMatch is the typed request payload for Event.LoadTyped.
type EventLoadMatch struct {
	Id string `json:"id"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
}

// EventListMatch is the typed request payload for Event.ListTyped.
type EventListMatch struct {
	Area *string `json:"area,omitempty"`
	Artist *string `json:"artist,omitempty"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Place *string `json:"place,omitempty"`
	Query *string `json:"query,omitempty"`
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
	Fmt *string `json:"fmt,omitempty"`
}

// GenreListMatch is the typed request payload for Genre.ListTyped.
type GenreListMatch struct {
	Fmt *string `json:"fmt,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
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
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
}

// InstrumentListMatch is the typed request payload for Instrument.ListTyped.
type InstrumentListMatch struct {
	Collection *string `json:"collection,omitempty"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Query *string `json:"query,omitempty"`
}

// Label is the typed data model for the label entity.
type Label struct {
	Begin *string `json:"begin,omitempty"`
	Country *string `json:"country,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	End *string `json:"end,omitempty"`
	Ended *bool `json:"ended,omitempty"`
	Id *string `json:"id,omitempty"`
	Labelcode *int `json:"labelcode,omitempty"`
	Lifespan *map[string]any `json:"lifespan,omitempty"`
	Name *string `json:"name,omitempty"`
	Sortname *string `json:"sortname,omitempty"`
	Type *string `json:"type,omitempty"`
}

// LabelLoadMatch is the typed request payload for Label.LoadTyped.
type LabelLoadMatch struct {
	Id string `json:"id"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Status *string `json:"status,omitempty"`
	Type *string `json:"type,omitempty"`
}

// LabelListMatch is the typed request payload for Label.ListTyped.
type LabelListMatch struct {
	Area *string `json:"area,omitempty"`
	Collection *string `json:"collection,omitempty"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Query *string `json:"query,omitempty"`
	Release *string `json:"release,omitempty"`
}

// Place is the typed data model for the place entity.
type Place struct {
	Address *string `json:"address,omitempty"`
	Coordinates *map[string]any `json:"coordinates,omitempty"`
	Disambiguation *string `json:"disambiguation,omitempty"`
	Id *string `json:"id,omitempty"`
	Lifespan *map[string]any `json:"lifespan,omitempty"`
	Name *string `json:"name,omitempty"`
	Type *string `json:"type,omitempty"`
}

// PlaceLoadMatch is the typed request payload for Place.LoadTyped.
type PlaceLoadMatch struct {
	Id string `json:"id"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
}

// PlaceListMatch is the typed request payload for Place.ListTyped.
type PlaceListMatch struct {
	Area *string `json:"area,omitempty"`
	Collection *string `json:"collection,omitempty"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Query *string `json:"query,omitempty"`
}

// Rating is the typed data model for the rating entity.
type Rating struct {
}

// RatingLoadMatch is the typed request payload for Rating.LoadTyped.
type RatingLoadMatch struct {
	Fmt *string `json:"fmt,omitempty"`
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
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Status *string `json:"status,omitempty"`
	Type *string `json:"type,omitempty"`
}

// RecordingListMatch is the typed request payload for Recording.ListTyped.
type RecordingListMatch struct {
	Artist *string `json:"artist,omitempty"`
	Collection *string `json:"collection,omitempty"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Query *string `json:"query,omitempty"`
	Release *string `json:"release,omitempty"`
	Work *string `json:"work,omitempty"`
}

// RecordingList is the typed data model for the recording_list entity.
type RecordingList struct {
	Count *int `json:"count,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Recordings *[]any `json:"recordings,omitempty"`
}

// RecordingListLoadMatch is the typed request payload for RecordingList.LoadTyped.
type RecordingListLoadMatch struct {
	Isrc string `json:"isrc"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
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
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
}

// ReleaseListMatch is the typed request payload for Release.ListTyped.
type ReleaseListMatch struct {
	Area *string `json:"area,omitempty"`
	Artist *string `json:"artist,omitempty"`
	Collection *string `json:"collection,omitempty"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Label *string `json:"label,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Query *string `json:"query,omitempty"`
	Recording *string `json:"recording,omitempty"`
	ReleaseGroup *string `json:"release_group,omitempty"`
	Status *string `json:"status,omitempty"`
	Track *string `json:"track,omitempty"`
	TrackArtist *string `json:"track_artist,omitempty"`
	Type *string `json:"type,omitempty"`
}

// ReleaseGroup is the typed data model for the release_group entity.
type ReleaseGroup struct {
	Disambiguation *string `json:"disambiguation,omitempty"`
	Firstreleasedate *string `json:"firstreleasedate,omitempty"`
	Id *string `json:"id,omitempty"`
	Primarytype *string `json:"primarytype,omitempty"`
	Secondarytypes *[]any `json:"secondarytypes,omitempty"`
	Title *string `json:"title,omitempty"`
}

// ReleaseGroupLoadMatch is the typed request payload for ReleaseGroup.LoadTyped.
type ReleaseGroupLoadMatch struct {
	Id string `json:"id"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Status *string `json:"status,omitempty"`
	Type *string `json:"type,omitempty"`
}

// ReleaseGroupListMatch is the typed request payload for ReleaseGroup.ListTyped.
type ReleaseGroupListMatch struct {
	Artist *string `json:"artist,omitempty"`
	Collection *string `json:"collection,omitempty"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Query *string `json:"query,omitempty"`
	Release *string `json:"release,omitempty"`
	Type *string `json:"type,omitempty"`
}

// ReleaseList is the typed data model for the release_list entity.
type ReleaseList struct {
	Count *int `json:"count,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Releases *[]any `json:"releases,omitempty"`
}

// ReleaseListLoadMatch is the typed request payload for ReleaseList.LoadTyped.
type ReleaseListLoadMatch struct {
	Discid string `json:"discid"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
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
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
}

// SeriesListMatch is the typed request payload for Series.ListTyped.
type SeriesListMatch struct {
	Collection *string `json:"collection,omitempty"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Query *string `json:"query,omitempty"`
}

// Tag is the typed data model for the tag entity.
type Tag struct {
}

// TagLoadMatch is the typed request payload for Tag.LoadTyped.
type TagLoadMatch struct {
	Fmt *string `json:"fmt,omitempty"`
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
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
}

// UrlListMatch is the typed request payload for Url.ListTyped.
type UrlListMatch struct {
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Query *string `json:"query,omitempty"`
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
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
}

// WorkListMatch is the typed request payload for Work.ListTyped.
type WorkListMatch struct {
	Artist *string `json:"artist,omitempty"`
	Collection *string `json:"collection,omitempty"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
	Limit *int `json:"limit,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Query *string `json:"query,omitempty"`
}

// WorkList is the typed data model for the work_list entity.
type WorkList struct {
	Count *int `json:"count,omitempty"`
	Offset *int `json:"offset,omitempty"`
	Works *[]any `json:"works,omitempty"`
}

// WorkListLoadMatch is the typed request payload for WorkList.LoadTyped.
type WorkListLoadMatch struct {
	Iswc string `json:"iswc"`
	Fmt *string `json:"fmt,omitempty"`
	Inc *string `json:"inc,omitempty"`
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

// entityData unwraps an entity to its data map.
//
// Operations resolve to the ENTITY, not the raw data (see AGENTS.md), and an
// entity's fields are UNEXPORTED — marshalling one directly yields `{}`, so
// every typed accessor would silently hand back a zero-valued struct. The
// typed boundary therefore takes the data hop first.
func entityData(v any) any {
	if ent, ok := v.(core.Entity); ok {
		return ent.Data()
	}
	return v
}

// typedFrom decodes a runtime value (an entity, or the map[string]any the op
// pipeline produced) into a typed model T via a JSON round-trip. On any error
// it returns the zero value of T; the op's own (value, error) tuple carries
// the real error.
func typedFrom[T any](v any) T {
	var out T
	v = entityData(v)
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

// typedSliceFrom decodes a runtime list value into a typed slice []T via a
// JSON round-trip, for list ops. `list` resolves to a slice of ENTITY
// instances, so each element takes the data hop.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	if list, ok := v.([]any); ok {
		unwrapped := make([]any, 0, len(list))
		for _, item := range list {
			unwrapped = append(unwrapped, entityData(item))
		}
		v = unwrapped
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
