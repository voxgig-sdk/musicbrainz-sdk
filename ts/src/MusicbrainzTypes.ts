// Typed models for the Musicbrainz SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Area {
  begin?: string
  disambiguation?: string
  end?: string
  ended?: boolean
  id?: string
  lifespan?: Record<string, any>
  name?: string
  sortname?: string
  type?: string
}

export interface AreaLoadMatch {
  id: string
  fmt?: string
  inc?: string
}

export interface AreaListMatch {
  fmt?: string
  inc?: string
  limit?: number
  offset?: number
  query?: string
}

export interface Artist {
  begin?: string
  country?: string
  disambiguation?: string
  end?: string
  ended?: boolean
  gender?: string
  id?: string
  lifespan?: Record<string, any>
  name?: string
  sortname?: string
  type?: string
}

export interface ArtistLoadMatch {
  id: string
  fmt?: string
  inc?: string
  status?: string
  type?: string
}

export interface ArtistListMatch {
  area?: string
  collection?: string
  fmt?: string
  inc?: string
  limit?: number
  offset?: number
  query?: string
  recording?: string
  release?: string
  release_group?: string
  work?: string
}

export interface Collection {
  editor?: string
  entitytype?: string
  id?: string
  name?: string
}

export interface CollectionListMatch {
  fmt?: string
  inc?: string
  limit?: number
  offset?: number
}

export interface Event {
  begin?: string
  cancelled?: boolean
  disambiguation?: string
  end?: string
  ended?: boolean
  id?: string
  lifespan?: Record<string, any>
  name?: string
  time?: string
  type?: string
}

export interface EventLoadMatch {
  id: string
  fmt?: string
  inc?: string
}

export interface EventListMatch {
  area?: string
  artist?: string
  fmt?: string
  inc?: string
  limit?: number
  offset?: number
  place?: string
  query?: string
}

export interface Genre {
  disambiguation?: string
  id?: string
  name?: string
}

export interface GenreLoadMatch {
  id: string
  fmt?: string
}

export interface GenreListMatch {
  fmt?: string
  limit?: number
  offset?: number

  // Selects a custom action instead of the plain list:
  //   'all'
  // The remaining keys are that action's own payload.
  $action?: string
  [action: string]: any
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
  fmt?: string
  inc?: string
}

export interface InstrumentListMatch {
  collection?: string
  fmt?: string
  inc?: string
  limit?: number
  offset?: number
  query?: string
}

export interface Label {
  begin?: string
  country?: string
  disambiguation?: string
  end?: string
  ended?: boolean
  id?: string
  labelcode?: number
  lifespan?: Record<string, any>
  name?: string
  sortname?: string
  type?: string
}

export interface LabelLoadMatch {
  id: string
  fmt?: string
  inc?: string
  status?: string
  type?: string
}

export interface LabelListMatch {
  area?: string
  collection?: string
  fmt?: string
  inc?: string
  limit?: number
  offset?: number
  query?: string
  release?: string
}

export interface Place {
  address?: string
  coordinates?: Record<string, any>
  disambiguation?: string
  id?: string
  lifespan?: Record<string, any>
  name?: string
  type?: string
}

export interface PlaceLoadMatch {
  id: string
  fmt?: string
  inc?: string
}

export interface PlaceListMatch {
  area?: string
  collection?: string
  fmt?: string
  inc?: string
  limit?: number
  offset?: number
  query?: string
}

export interface Rating {
}

export interface RatingLoadMatch {
  fmt?: string
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
  fmt?: string
  inc?: string
  status?: string
  type?: string
}

export interface RecordingListMatch {
  artist?: string
  collection?: string
  fmt?: string
  inc?: string
  limit?: number
  offset?: number
  query?: string
  release?: string
  work?: string
}

export interface RecordingList {
  count?: number
  offset?: number
  recordings?: any[]
}

export interface RecordingListLoadMatch {
  isrc: string
  fmt?: string
  inc?: string
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
  fmt?: string
  inc?: string
}

export interface ReleaseListMatch {
  area?: string
  artist?: string
  collection?: string
  fmt?: string
  inc?: string
  label?: string
  limit?: number
  offset?: number
  query?: string
  recording?: string
  release_group?: string
  status?: string
  track?: string
  track_artist?: string
  type?: string
}

export interface ReleaseGroup {
  disambiguation?: string
  firstreleasedate?: string
  id?: string
  primarytype?: string
  secondarytypes?: any[]
  title?: string
}

export interface ReleaseGroupLoadMatch {
  id: string
  fmt?: string
  inc?: string
  status?: string
  type?: string
}

export interface ReleaseGroupListMatch {
  artist?: string
  collection?: string
  fmt?: string
  inc?: string
  limit?: number
  offset?: number
  query?: string
  release?: string
  type?: string
}

export interface ReleaseList {
  count?: number
  offset?: number
  releases?: any[]
}

export interface ReleaseListLoadMatch {
  discid: string
  fmt?: string
  inc?: string
}

export interface Series {
  disambiguation?: string
  id?: string
  name?: string
  type?: string
}

export interface SeriesLoadMatch {
  id: string
  fmt?: string
  inc?: string
}

export interface SeriesListMatch {
  collection?: string
  fmt?: string
  inc?: string
  limit?: number
  offset?: number
  query?: string
}

export interface Tag {
}

export interface TagLoadMatch {
  fmt?: string
}

export interface TagCreateData {
}

export interface Url {
  id?: string
  resource?: string
}

export interface UrlLoadMatch {
  id: string
  fmt?: string
  inc?: string
}

export interface UrlListMatch {
  fmt?: string
  inc?: string
  limit?: number
  offset?: number
  query?: string
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
  fmt?: string
  inc?: string
}

export interface WorkListMatch {
  artist?: string
  collection?: string
  fmt?: string
  inc?: string
  limit?: number
  offset?: number
  query?: string
}

export interface WorkList {
  count?: number
  offset?: number
  works?: any[]
}

export interface WorkListLoadMatch {
  iswc: string
  fmt?: string
  inc?: string
}

