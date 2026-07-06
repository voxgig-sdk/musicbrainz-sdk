# frozen_string_literal: true

# Typed models for the Musicbrainz SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Area entity data model.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] life_span
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] sort_name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Area = Struct.new(
  :disambiguation,
  :id,
  :life_span,
  :name,
  :sort_name,
  :type,
  keyword_init: true
)

# Request payload for Area#load.
#
# @!attribute [rw] id
#   @return [String]
AreaLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Area#list.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] life_span
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] sort_name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
AreaListMatch = Struct.new(
  :disambiguation,
  :id,
  :life_span,
  :name,
  :sort_name,
  :type,
  keyword_init: true
)

# Artist entity data model.
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] gender
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] life_span
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] sort_name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Artist = Struct.new(
  :country,
  :disambiguation,
  :gender,
  :id,
  :life_span,
  :name,
  :sort_name,
  :type,
  keyword_init: true
)

# Request payload for Artist#load.
#
# @!attribute [rw] id
#   @return [String]
ArtistLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Artist#list.
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] gender
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] life_span
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] sort_name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
ArtistListMatch = Struct.new(
  :country,
  :disambiguation,
  :gender,
  :id,
  :life_span,
  :name,
  :sort_name,
  :type,
  keyword_init: true
)

# Collection entity data model.
#
# @!attribute [rw] editor
#   @return [String, nil]
#
# @!attribute [rw] entity_type
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
Collection = Struct.new(
  :editor,
  :entity_type,
  :id,
  :name,
  keyword_init: true
)

# Request payload for Collection#list.
#
# @!attribute [rw] editor
#   @return [String, nil]
#
# @!attribute [rw] entity_type
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
CollectionListMatch = Struct.new(
  :editor,
  :entity_type,
  :id,
  :name,
  keyword_init: true
)

# Event entity data model.
#
# @!attribute [rw] cancelled
#   @return [Boolean, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] life_span
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] time
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Event = Struct.new(
  :cancelled,
  :disambiguation,
  :id,
  :life_span,
  :name,
  :time,
  :type,
  keyword_init: true
)

# Request payload for Event#load.
#
# @!attribute [rw] id
#   @return [String]
EventLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Event#list.
#
# @!attribute [rw] cancelled
#   @return [Boolean, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] life_span
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] time
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
EventListMatch = Struct.new(
  :cancelled,
  :disambiguation,
  :id,
  :life_span,
  :name,
  :time,
  :type,
  keyword_init: true
)

# Genre entity data model.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
Genre = Struct.new(
  :disambiguation,
  :id,
  :name,
  keyword_init: true
)

# Request payload for Genre#load.
#
# @!attribute [rw] id
#   @return [String]
GenreLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Genre#list.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
GenreListMatch = Struct.new(
  :disambiguation,
  :id,
  :name,
  keyword_init: true
)

# Instrument entity data model.
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Instrument = Struct.new(
  :description,
  :disambiguation,
  :id,
  :name,
  :type,
  keyword_init: true
)

# Request payload for Instrument#load.
#
# @!attribute [rw] id
#   @return [String]
InstrumentLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Instrument#list.
#
# @!attribute [rw] description
#   @return [String, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
InstrumentListMatch = Struct.new(
  :description,
  :disambiguation,
  :id,
  :name,
  :type,
  keyword_init: true
)

# Label entity data model.
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] label_code
#   @return [Integer, nil]
#
# @!attribute [rw] life_span
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] sort_name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Label = Struct.new(
  :country,
  :disambiguation,
  :id,
  :label_code,
  :life_span,
  :name,
  :sort_name,
  :type,
  keyword_init: true
)

# Request payload for Label#load.
#
# @!attribute [rw] id
#   @return [String]
LabelLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Label#list.
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] label_code
#   @return [Integer, nil]
#
# @!attribute [rw] life_span
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] sort_name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
LabelListMatch = Struct.new(
  :country,
  :disambiguation,
  :id,
  :label_code,
  :life_span,
  :name,
  :sort_name,
  :type,
  keyword_init: true
)

# Place entity data model.
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] coordinate
#   @return [Hash, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] life_span
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Place = Struct.new(
  :address,
  :coordinate,
  :disambiguation,
  :id,
  :life_span,
  :name,
  :type,
  keyword_init: true
)

# Request payload for Place#load.
#
# @!attribute [rw] id
#   @return [String]
PlaceLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Place#list.
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] coordinate
#   @return [Hash, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] life_span
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
PlaceListMatch = Struct.new(
  :address,
  :coordinate,
  :disambiguation,
  :id,
  :life_span,
  :name,
  :type,
  keyword_init: true
)

# Rating entity data model.
class Rating
end

# Request payload for Rating#load.
class RatingLoadMatch
end

# Request payload for Rating#create.
class RatingCreateData
end

# Recording entity data model.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] length
#   @return [Integer, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] video
#   @return [Boolean, nil]
Recording = Struct.new(
  :disambiguation,
  :id,
  :length,
  :title,
  :video,
  keyword_init: true
)

# Request payload for Recording#load.
#
# @!attribute [rw] id
#   @return [String]
RecordingLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Recording#list.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] length
#   @return [Integer, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] video
#   @return [Boolean, nil]
RecordingListMatch = Struct.new(
  :disambiguation,
  :id,
  :length,
  :title,
  :video,
  keyword_init: true
)

# RecordingList entity data model.
#
# @!attribute [rw] count
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] recording
#   @return [Array, nil]
RecordingList = Struct.new(
  :count,
  :offset,
  :recording,
  keyword_init: true
)

# Request payload for RecordingList#load.
#
# @!attribute [rw] isrc
#   @return [String]
RecordingListLoadMatch = Struct.new(
  :isrc,
  keyword_init: true
)

# Release entity data model.
#
# @!attribute [rw] barcode
#   @return [String, nil]
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] date
#   @return [String, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] packaging
#   @return [String, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
Release = Struct.new(
  :barcode,
  :country,
  :date,
  :disambiguation,
  :id,
  :packaging,
  :status,
  :title,
  keyword_init: true
)

# Request payload for Release#load.
#
# @!attribute [rw] id
#   @return [String]
ReleaseLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Release#list.
#
# @!attribute [rw] barcode
#   @return [String, nil]
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] date
#   @return [String, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] packaging
#   @return [String, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
ReleaseListMatch = Struct.new(
  :barcode,
  :country,
  :date,
  :disambiguation,
  :id,
  :packaging,
  :status,
  :title,
  keyword_init: true
)

# ReleaseGroup entity data model.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] first_release_date
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] primary_type
#   @return [String, nil]
#
# @!attribute [rw] secondary_type
#   @return [Array, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
ReleaseGroup = Struct.new(
  :disambiguation,
  :first_release_date,
  :id,
  :primary_type,
  :secondary_type,
  :title,
  keyword_init: true
)

# Request payload for ReleaseGroup#load.
#
# @!attribute [rw] id
#   @return [String]
ReleaseGroupLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for ReleaseGroup#list.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] first_release_date
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] primary_type
#   @return [String, nil]
#
# @!attribute [rw] secondary_type
#   @return [Array, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
ReleaseGroupListMatch = Struct.new(
  :disambiguation,
  :first_release_date,
  :id,
  :primary_type,
  :secondary_type,
  :title,
  keyword_init: true
)

# ReleaseList entity data model.
#
# @!attribute [rw] count
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] release
#   @return [Array, nil]
ReleaseList = Struct.new(
  :count,
  :offset,
  :release,
  keyword_init: true
)

# Request payload for ReleaseList#load.
#
# @!attribute [rw] discid
#   @return [String]
ReleaseListLoadMatch = Struct.new(
  :discid,
  keyword_init: true
)

# Series entity data model.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Series = Struct.new(
  :disambiguation,
  :id,
  :name,
  :type,
  keyword_init: true
)

# Request payload for Series#load.
#
# @!attribute [rw] id
#   @return [String]
SeriesLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Series#list.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
SeriesListMatch = Struct.new(
  :disambiguation,
  :id,
  :name,
  :type,
  keyword_init: true
)

# Tag entity data model.
class Tag
end

# Request payload for Tag#load.
class TagLoadMatch
end

# Request payload for Tag#create.
class TagCreateData
end

# Url entity data model.
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] resource
#   @return [String, nil]
Url = Struct.new(
  :id,
  :resource,
  keyword_init: true
)

# Request payload for Url#load.
#
# @!attribute [rw] id
#   @return [String]
UrlLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Url#list.
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] resource
#   @return [String, nil]
UrlListMatch = Struct.new(
  :id,
  :resource,
  keyword_init: true
)

# Work entity data model.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Work = Struct.new(
  :disambiguation,
  :id,
  :language,
  :title,
  :type,
  keyword_init: true
)

# Request payload for Work#load.
#
# @!attribute [rw] id
#   @return [String]
WorkLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Work#list.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
WorkListMatch = Struct.new(
  :disambiguation,
  :id,
  :language,
  :title,
  :type,
  keyword_init: true
)

# WorkList entity data model.
#
# @!attribute [rw] count
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] work
#   @return [Array, nil]
WorkList = Struct.new(
  :count,
  :offset,
  :work,
  keyword_init: true
)

# Request payload for WorkList#load.
#
# @!attribute [rw] iswc
#   @return [String]
WorkListLoadMatch = Struct.new(
  :iswc,
  keyword_init: true
)

