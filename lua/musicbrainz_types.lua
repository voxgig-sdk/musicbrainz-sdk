-- Typed models for the Musicbrainz SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Area
---@field begin? string
---@field disambiguation? string
---@field end? string
---@field ended? boolean
---@field id? string
---@field lifespan? table
---@field name? string
---@field sortname? string
---@field type? string

---@class AreaLoadMatch
---@field id string
---@field fmt? string
---@field inc? string

---@class AreaListMatch
---@field fmt? string
---@field inc? string
---@field limit? number
---@field offset? number
---@field query? string

---@class Artist
---@field begin? string
---@field country? string
---@field disambiguation? string
---@field end? string
---@field ended? boolean
---@field gender? string
---@field id? string
---@field lifespan? table
---@field name? string
---@field sortname? string
---@field type? string

---@class ArtistLoadMatch
---@field id string
---@field fmt? string
---@field inc? string
---@field status? string
---@field type? string

---@class ArtistListMatch
---@field area? string
---@field collection? string
---@field fmt? string
---@field inc? string
---@field limit? number
---@field offset? number
---@field query? string
---@field recording? string
---@field release? string
---@field release_group? string
---@field work? string

---@class Collection
---@field editor? string
---@field entitytype? string
---@field id? string
---@field name? string

---@class CollectionListMatch
---@field fmt? string
---@field inc? string
---@field limit? number
---@field offset? number

---@class Event
---@field begin? string
---@field cancelled? boolean
---@field disambiguation? string
---@field end? string
---@field ended? boolean
---@field id? string
---@field lifespan? table
---@field name? string
---@field time? string
---@field type? string

---@class EventLoadMatch
---@field id string
---@field fmt? string
---@field inc? string

---@class EventListMatch
---@field area? string
---@field artist? string
---@field fmt? string
---@field inc? string
---@field limit? number
---@field offset? number
---@field place? string
---@field query? string

---@class Genre
---@field disambiguation? string
---@field id? string
---@field name? string

---@class GenreLoadMatch
---@field id string
---@field fmt? string

---@class GenreListMatch
---@field fmt? string
---@field limit? number
---@field offset? number

---@class Instrument
---@field description? string
---@field disambiguation? string
---@field id? string
---@field name? string
---@field type? string

---@class InstrumentLoadMatch
---@field id string
---@field fmt? string
---@field inc? string

---@class InstrumentListMatch
---@field collection? string
---@field fmt? string
---@field inc? string
---@field limit? number
---@field offset? number
---@field query? string

---@class Label
---@field begin? string
---@field country? string
---@field disambiguation? string
---@field end? string
---@field ended? boolean
---@field id? string
---@field labelcode? number
---@field lifespan? table
---@field name? string
---@field sortname? string
---@field type? string

---@class LabelLoadMatch
---@field id string
---@field fmt? string
---@field inc? string
---@field status? string
---@field type? string

---@class LabelListMatch
---@field area? string
---@field collection? string
---@field fmt? string
---@field inc? string
---@field limit? number
---@field offset? number
---@field query? string
---@field release? string

---@class Place
---@field address? string
---@field coordinates? table
---@field disambiguation? string
---@field id? string
---@field lifespan? table
---@field name? string
---@field type? string

---@class PlaceLoadMatch
---@field id string
---@field fmt? string
---@field inc? string

---@class PlaceListMatch
---@field area? string
---@field collection? string
---@field fmt? string
---@field inc? string
---@field limit? number
---@field offset? number
---@field query? string

---@class Rating

---@class RatingLoadMatch
---@field fmt? string

---@class RatingCreateData

---@class Recording
---@field disambiguation? string
---@field id? string
---@field length? number
---@field title? string
---@field video? boolean

---@class RecordingLoadMatch
---@field id string
---@field fmt? string
---@field inc? string
---@field status? string
---@field type? string

---@class RecordingListMatch
---@field artist? string
---@field collection? string
---@field fmt? string
---@field inc? string
---@field limit? number
---@field offset? number
---@field query? string
---@field release? string
---@field work? string

---@class RecordingList
---@field count? number
---@field offset? number
---@field recordings? table

---@class RecordingListLoadMatch
---@field isrc string
---@field fmt? string
---@field inc? string

---@class Release
---@field barcode? string
---@field country? string
---@field date? string
---@field disambiguation? string
---@field id? string
---@field packaging? string
---@field status? string
---@field title? string

---@class ReleaseLoadMatch
---@field id string
---@field fmt? string
---@field inc? string

---@class ReleaseListMatch
---@field area? string
---@field artist? string
---@field collection? string
---@field fmt? string
---@field inc? string
---@field label? string
---@field limit? number
---@field offset? number
---@field query? string
---@field recording? string
---@field release_group? string
---@field status? string
---@field track? string
---@field track_artist? string
---@field type? string

---@class ReleaseGroup
---@field disambiguation? string
---@field firstreleasedate? string
---@field id? string
---@field primarytype? string
---@field secondarytypes? table
---@field title? string

---@class ReleaseGroupLoadMatch
---@field id string
---@field fmt? string
---@field inc? string
---@field status? string
---@field type? string

---@class ReleaseGroupListMatch
---@field artist? string
---@field collection? string
---@field fmt? string
---@field inc? string
---@field limit? number
---@field offset? number
---@field query? string
---@field release? string
---@field type? string

---@class ReleaseList
---@field count? number
---@field offset? number
---@field releases? table

---@class ReleaseListLoadMatch
---@field discid string
---@field fmt? string
---@field inc? string

---@class Series
---@field disambiguation? string
---@field id? string
---@field name? string
---@field type? string

---@class SeriesLoadMatch
---@field id string
---@field fmt? string
---@field inc? string

---@class SeriesListMatch
---@field collection? string
---@field fmt? string
---@field inc? string
---@field limit? number
---@field offset? number
---@field query? string

---@class Tag

---@class TagLoadMatch
---@field fmt? string

---@class TagCreateData

---@class Url
---@field id? string
---@field resource? string

---@class UrlLoadMatch
---@field id string
---@field fmt? string
---@field inc? string

---@class UrlListMatch
---@field fmt? string
---@field inc? string
---@field limit? number
---@field offset? number
---@field query? string
---@field resource? string

---@class Work
---@field disambiguation? string
---@field id? string
---@field language? string
---@field title? string
---@field type? string

---@class WorkLoadMatch
---@field id string
---@field fmt? string
---@field inc? string

---@class WorkListMatch
---@field artist? string
---@field collection? string
---@field fmt? string
---@field inc? string
---@field limit? number
---@field offset? number
---@field query? string

---@class WorkList
---@field count? number
---@field offset? number
---@field works? table

---@class WorkListLoadMatch
---@field iswc string
---@field fmt? string
---@field inc? string

local M = {}

return M
