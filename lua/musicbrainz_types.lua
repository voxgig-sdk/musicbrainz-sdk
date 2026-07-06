-- Typed models for the Musicbrainz SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Area
---@field disambiguation? string
---@field id? string
---@field life_span? table
---@field name? string
---@field sort_name? string
---@field type? string

---@class AreaLoadMatch
---@field id string

---@class AreaListMatch
---@field disambiguation? string
---@field id? string
---@field life_span? table
---@field name? string
---@field sort_name? string
---@field type? string

---@class Artist
---@field country? string
---@field disambiguation? string
---@field gender? string
---@field id? string
---@field life_span? table
---@field name? string
---@field sort_name? string
---@field type? string

---@class ArtistLoadMatch
---@field id string

---@class ArtistListMatch
---@field country? string
---@field disambiguation? string
---@field gender? string
---@field id? string
---@field life_span? table
---@field name? string
---@field sort_name? string
---@field type? string

---@class Collection
---@field editor? string
---@field entity_type? string
---@field id? string
---@field name? string

---@class CollectionListMatch
---@field editor? string
---@field entity_type? string
---@field id? string
---@field name? string

---@class Event
---@field cancelled? boolean
---@field disambiguation? string
---@field id? string
---@field life_span? table
---@field name? string
---@field time? string
---@field type? string

---@class EventLoadMatch
---@field id string

---@class EventListMatch
---@field cancelled? boolean
---@field disambiguation? string
---@field id? string
---@field life_span? table
---@field name? string
---@field time? string
---@field type? string

---@class Genre
---@field disambiguation? string
---@field id? string
---@field name? string

---@class GenreLoadMatch
---@field id string

---@class GenreListMatch
---@field disambiguation? string
---@field id? string
---@field name? string

---@class Instrument
---@field description? string
---@field disambiguation? string
---@field id? string
---@field name? string
---@field type? string

---@class InstrumentLoadMatch
---@field id string

---@class InstrumentListMatch
---@field description? string
---@field disambiguation? string
---@field id? string
---@field name? string
---@field type? string

---@class Label
---@field country? string
---@field disambiguation? string
---@field id? string
---@field label_code? number
---@field life_span? table
---@field name? string
---@field sort_name? string
---@field type? string

---@class LabelLoadMatch
---@field id string

---@class LabelListMatch
---@field country? string
---@field disambiguation? string
---@field id? string
---@field label_code? number
---@field life_span? table
---@field name? string
---@field sort_name? string
---@field type? string

---@class Place
---@field address? string
---@field coordinate? table
---@field disambiguation? string
---@field id? string
---@field life_span? table
---@field name? string
---@field type? string

---@class PlaceLoadMatch
---@field id string

---@class PlaceListMatch
---@field address? string
---@field coordinate? table
---@field disambiguation? string
---@field id? string
---@field life_span? table
---@field name? string
---@field type? string

---@class Rating

---@class RatingLoadMatch

---@class RatingCreateData

---@class Recording
---@field disambiguation? string
---@field id? string
---@field length? number
---@field title? string
---@field video? boolean

---@class RecordingLoadMatch
---@field id string

---@class RecordingListMatch
---@field disambiguation? string
---@field id? string
---@field length? number
---@field title? string
---@field video? boolean

---@class RecordingList
---@field count? number
---@field offset? number
---@field recording? table

---@class RecordingListLoadMatch
---@field isrc string

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

---@class ReleaseListMatch
---@field barcode? string
---@field country? string
---@field date? string
---@field disambiguation? string
---@field id? string
---@field packaging? string
---@field status? string
---@field title? string

---@class ReleaseGroup
---@field disambiguation? string
---@field first_release_date? string
---@field id? string
---@field primary_type? string
---@field secondary_type? table
---@field title? string

---@class ReleaseGroupLoadMatch
---@field id string

---@class ReleaseGroupListMatch
---@field disambiguation? string
---@field first_release_date? string
---@field id? string
---@field primary_type? string
---@field secondary_type? table
---@field title? string

---@class ReleaseList
---@field count? number
---@field offset? number
---@field release? table

---@class ReleaseListLoadMatch
---@field discid string

---@class Series
---@field disambiguation? string
---@field id? string
---@field name? string
---@field type? string

---@class SeriesLoadMatch
---@field id string

---@class SeriesListMatch
---@field disambiguation? string
---@field id? string
---@field name? string
---@field type? string

---@class Tag

---@class TagLoadMatch

---@class TagCreateData

---@class Url
---@field id? string
---@field resource? string

---@class UrlLoadMatch
---@field id string

---@class UrlListMatch
---@field id? string
---@field resource? string

---@class Work
---@field disambiguation? string
---@field id? string
---@field language? string
---@field title? string
---@field type? string

---@class WorkLoadMatch
---@field id string

---@class WorkListMatch
---@field disambiguation? string
---@field id? string
---@field language? string
---@field title? string
---@field type? string

---@class WorkList
---@field count? number
---@field offset? number
---@field work? table

---@class WorkListLoadMatch
---@field iswc string

local M = {}

return M
