// Typed models for the Musicbrainz SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Area {
  disambiguation?: string
  id?: string
  life_span?: Record<string, any>
  name?: string
  sort_name?: string
  type?: string
}

export interface AreaLoadMatch {
  id: string
}

export interface AreaListMatch {
  disambiguation?: string
  id?: string
  life_span?: Record<string, any>
  name?: string
  sort_name?: string
  type?: string
}

export interface Artist {
  country?: string
  disambiguation?: string
  gender?: string
  id?: string
  life_span?: Record<string, any>
  name?: string
  sort_name?: string
  type?: string
}

export interface ArtistLoadMatch {
  id: string
}

export interface ArtistListMatch {
  country?: string
  disambiguation?: string
  gender?: string
  id?: string
  life_span?: Record<string, any>
  name?: string
  sort_name?: string
  type?: string
}

export interface Collection {
  editor?: string
  entity_type?: string
  id?: string
  name?: string
}

export interface CollectionListMatch {
  editor?: string
  entity_type?: string
  id?: string
  name?: string
}

export interface Event {
  cancelled?: boolean
  disambiguation?: string
  id?: string
  life_span?: Record<string, any>
  name?: string
  time?: string
  type?: string
}

export interface EventLoadMatch {
  id: string
}

export interface EventListMatch {
  cancelled?: boolean
  disambiguation?: string
  id?: string
  life_span?: Record<string, any>
  name?: string
  time?: string
  type?: string
}

export interface Genre {
  disambiguation?: string
  id?: string
  name?: string
}

export interface GenreLoadMatch {
  id: string
}

export interface GenreListMatch {
  disambiguation?: string
  id?: string
  name?: string
}

export interface Instrument {
  description?: string
  disambiguation?: string
  id?: string
  name?: string
  type?: string
}

export interface InstrumentLoadMatch {
  id: string
}

export interface InstrumentListMatch {
  description?: string
  disambiguation?: string
  id?: string
  name?: string
  type?: string
}

export interface Label {
  country?: string
  disambiguation?: string
  id?: string
  label_code?: number
  life_span?: Record<string, any>
  name?: string
  sort_name?: string
  type?: string
}

export interface LabelLoadMatch {
  id: string
}

export interface LabelListMatch {
  country?: string
  disambiguation?: string
  id?: string
  label_code?: number
  life_span?: Record<string, any>
  name?: string
  sort_name?: string
  type?: string
}

export interface Place {
  address?: string
  coordinate?: Record<string, any>
  disambiguation?: string
  id?: string
  life_span?: Record<string, any>
  name?: string
  type?: string
}

export interface PlaceLoadMatch {
  id: string
}

export interface PlaceListMatch {
  address?: string
  coordinate?: Record<string, any>
  disambiguation?: string
  id?: string
  life_span?: Record<string, any>
  name?: string
  type?: string
}

export interface Rating {
}

export interface RatingLoadMatch {
}

export interface RatingCreateData {
}

export interface Recording {
  disambiguation?: string
  id?: string
  length?: number
  title?: string
  video?: boolean
}

export interface RecordingLoadMatch {
  id: string
}

export interface RecordingListMatch {
  disambiguation?: string
  id?: string
  length?: number
  title?: string
  video?: boolean
}

export interface RecordingList {
  count?: number
  offset?: number
  recording?: any[]
}

export interface RecordingListLoadMatch {
  isrc: string
}

export interface Release {
  barcode?: string
  country?: string
  date?: string
  disambiguation?: string
  id?: string
  packaging?: string
  status?: string
  title?: string
}

export interface ReleaseLoadMatch {
  id: string
}

export interface ReleaseListMatch {
  barcode?: string
  country?: string
  date?: string
  disambiguation?: string
  id?: string
  packaging?: string
  status?: string
  title?: string
}

export interface ReleaseGroup {
  disambiguation?: string
  first_release_date?: string
  id?: string
  primary_type?: string
  secondary_type?: any[]
  title?: string
}

export interface ReleaseGroupLoadMatch {
  id: string
}

export interface ReleaseGroupListMatch {
  disambiguation?: string
  first_release_date?: string
  id?: string
  primary_type?: string
  secondary_type?: any[]
  title?: string
}

export interface ReleaseList {
  count?: number
  offset?: number
  release?: any[]
}

export interface ReleaseListLoadMatch {
  discid: string
}

export interface Series {
  disambiguation?: string
  id?: string
  name?: string
  type?: string
}

export interface SeriesLoadMatch {
  id: string
}

export interface SeriesListMatch {
  disambiguation?: string
  id?: string
  name?: string
  type?: string
}

export interface Tag {
}

export interface TagLoadMatch {
}

export interface TagCreateData {
}

export interface Url {
  id?: string
  resource?: string
}

export interface UrlLoadMatch {
  id: string
}

export interface UrlListMatch {
  id?: string
  resource?: string
}

export interface Work {
  disambiguation?: string
  id?: string
  language?: string
  title?: string
  type?: string
}

export interface WorkLoadMatch {
  id: string
}

export interface WorkListMatch {
  disambiguation?: string
  id?: string
  language?: string
  title?: string
  type?: string
}

export interface WorkList {
  count?: number
  offset?: number
  work?: any[]
}

export interface WorkListLoadMatch {
  iswc: string
}

