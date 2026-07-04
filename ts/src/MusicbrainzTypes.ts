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

export type AreaListMatch = Partial<Area>

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

export type ArtistListMatch = Partial<Artist>

export interface Collection {
  editor?: string
  entity_type?: string
  id?: string
  name?: string
}

export type CollectionListMatch = Partial<Collection>

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

export type EventListMatch = Partial<Event>

export interface Genre {
  disambiguation?: string
  id?: string
  name?: string
}

export interface GenreLoadMatch {
  id: string
}

export type GenreListMatch = Partial<Genre>

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

export type InstrumentListMatch = Partial<Instrument>

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

export type LabelListMatch = Partial<Label>

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

export type PlaceListMatch = Partial<Place>

export interface Rating {
}

export type RatingLoadMatch = Partial<Rating>

export type RatingCreateData = Partial<Rating>

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

export type RecordingListMatch = Partial<Recording>

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

export type ReleaseListMatch = Partial<Release>

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

export type ReleaseGroupListMatch = Partial<ReleaseGroup>

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

export type SeriesListMatch = Partial<Series>

export interface Tag {
}

export type TagLoadMatch = Partial<Tag>

export type TagCreateData = Partial<Tag>

export interface Url {
  id?: string
  resource?: string
}

export interface UrlLoadMatch {
  id: string
}

export type UrlListMatch = Partial<Url>

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

export type WorkListMatch = Partial<Work>

export interface WorkList {
  count?: number
  offset?: number
  work?: any[]
}

export interface WorkListLoadMatch {
  iswc: string
}

