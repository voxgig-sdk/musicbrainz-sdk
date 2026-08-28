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
# @!attribute [rw] begin
#   @return [String, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] end
#   @return [String, nil]
#
# @!attribute [rw] ended
#   @return [Boolean, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] lifespan
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] sortname
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Area = Struct.new(
  :begin,
  :disambiguation,
  :end,
  :ended,
  :id,
  :lifespan,
  :name,
  :sortname,
  :type,
  keyword_init: true
)

# Request payload for Area#load.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
AreaLoadMatch = Struct.new(
  :id,
  :fmt,
  :inc,
  keyword_init: true
)

# Request payload for Area#list.
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] query
#   @return [String, nil]
AreaListMatch = Struct.new(
  :fmt,
  :inc,
  :limit,
  :offset,
  :query,
  keyword_init: true
)

# Artist entity data model.
#
# @!attribute [rw] begin
#   @return [String, nil]
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] end
#   @return [String, nil]
#
# @!attribute [rw] ended
#   @return [Boolean, nil]
#
# @!attribute [rw] gender
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] lifespan
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] sortname
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Artist = Struct.new(
  :begin,
  :country,
  :disambiguation,
  :end,
  :ended,
  :gender,
  :id,
  :lifespan,
  :name,
  :sortname,
  :type,
  keyword_init: true
)

# Request payload for Artist#load.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
ArtistLoadMatch = Struct.new(
  :id,
  :fmt,
  :inc,
  :status,
  :type,
  keyword_init: true
)

# Request payload for Artist#list.
#
# @!attribute [rw] area
#   @return [String, nil]
#
# @!attribute [rw] collection
#   @return [String, nil]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] query
#   @return [String, nil]
#
# @!attribute [rw] recording
#   @return [String, nil]
#
# @!attribute [rw] release
#   @return [String, nil]
#
# @!attribute [rw] release_group
#   @return [String, nil]
#
# @!attribute [rw] work
#   @return [String, nil]
ArtistListMatch = Struct.new(
  :area,
  :collection,
  :fmt,
  :inc,
  :limit,
  :offset,
  :query,
  :recording,
  :release,
  :release_group,
  :work,
  keyword_init: true
)

# Collection entity data model.
#
# @!attribute [rw] editor
#   @return [String, nil]
#
# @!attribute [rw] entitytype
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
Collection = Struct.new(
  :editor,
  :entitytype,
  :id,
  :name,
  keyword_init: true
)

# Request payload for Collection#list.
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
CollectionListMatch = Struct.new(
  :fmt,
  :inc,
  :limit,
  :offset,
  keyword_init: true
)

# Event entity data model.
#
# @!attribute [rw] begin
#   @return [String, nil]
#
# @!attribute [rw] cancelled
#   @return [Boolean, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] end
#   @return [String, nil]
#
# @!attribute [rw] ended
#   @return [Boolean, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] lifespan
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
  :begin,
  :cancelled,
  :disambiguation,
  :end,
  :ended,
  :id,
  :lifespan,
  :name,
  :time,
  :type,
  keyword_init: true
)

# Request payload for Event#load.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
EventLoadMatch = Struct.new(
  :id,
  :fmt,
  :inc,
  keyword_init: true
)

# Request payload for Event#list.
#
# @!attribute [rw] area
#   @return [String, nil]
#
# @!attribute [rw] artist
#   @return [String, nil]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] place
#   @return [String, nil]
#
# @!attribute [rw] query
#   @return [String, nil]
EventListMatch = Struct.new(
  :area,
  :artist,
  :fmt,
  :inc,
  :limit,
  :offset,
  :place,
  :query,
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
#
# @!attribute [rw] fmt
#   @return [String, nil]
GenreLoadMatch = Struct.new(
  :id,
  :fmt,
  keyword_init: true
)

# Request payload for Genre#list.
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
GenreListMatch = Struct.new(
  :fmt,
  :limit,
  :offset,
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
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
InstrumentLoadMatch = Struct.new(
  :id,
  :fmt,
  :inc,
  keyword_init: true
)

# Request payload for Instrument#list.
#
# @!attribute [rw] collection
#   @return [String, nil]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] query
#   @return [String, nil]
InstrumentListMatch = Struct.new(
  :collection,
  :fmt,
  :inc,
  :limit,
  :offset,
  :query,
  keyword_init: true
)

# Label entity data model.
#
# @!attribute [rw] begin
#   @return [String, nil]
#
# @!attribute [rw] country
#   @return [String, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] end
#   @return [String, nil]
#
# @!attribute [rw] ended
#   @return [Boolean, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] labelcode
#   @return [Integer, nil]
#
# @!attribute [rw] lifespan
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] sortname
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Label = Struct.new(
  :begin,
  :country,
  :disambiguation,
  :end,
  :ended,
  :id,
  :labelcode,
  :lifespan,
  :name,
  :sortname,
  :type,
  keyword_init: true
)

# Request payload for Label#load.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
LabelLoadMatch = Struct.new(
  :id,
  :fmt,
  :inc,
  :status,
  :type,
  keyword_init: true
)

# Request payload for Label#list.
#
# @!attribute [rw] area
#   @return [String, nil]
#
# @!attribute [rw] collection
#   @return [String, nil]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] query
#   @return [String, nil]
#
# @!attribute [rw] release
#   @return [String, nil]
LabelListMatch = Struct.new(
  :area,
  :collection,
  :fmt,
  :inc,
  :limit,
  :offset,
  :query,
  :release,
  keyword_init: true
)

# Place entity data model.
#
# @!attribute [rw] address
#   @return [String, nil]
#
# @!attribute [rw] coordinates
#   @return [Hash, nil]
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] lifespan
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Place = Struct.new(
  :address,
  :coordinates,
  :disambiguation,
  :id,
  :lifespan,
  :name,
  :type,
  keyword_init: true
)

# Request payload for Place#load.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
PlaceLoadMatch = Struct.new(
  :id,
  :fmt,
  :inc,
  keyword_init: true
)

# Request payload for Place#list.
#
# @!attribute [rw] area
#   @return [String, nil]
#
# @!attribute [rw] collection
#   @return [String, nil]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] query
#   @return [String, nil]
PlaceListMatch = Struct.new(
  :area,
  :collection,
  :fmt,
  :inc,
  :limit,
  :offset,
  :query,
  keyword_init: true
)

# Rating entity data model.
class Rating
end

# Request payload for Rating#load.
#
# @!attribute [rw] fmt
#   @return [String, nil]
RatingLoadMatch = Struct.new(
  :fmt,
  keyword_init: true
)

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
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
RecordingLoadMatch = Struct.new(
  :id,
  :fmt,
  :inc,
  :status,
  :type,
  keyword_init: true
)

# Request payload for Recording#list.
#
# @!attribute [rw] artist
#   @return [String, nil]
#
# @!attribute [rw] collection
#   @return [String, nil]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] query
#   @return [String, nil]
#
# @!attribute [rw] release
#   @return [String, nil]
#
# @!attribute [rw] work
#   @return [String, nil]
RecordingListMatch = Struct.new(
  :artist,
  :collection,
  :fmt,
  :inc,
  :limit,
  :offset,
  :query,
  :release,
  :work,
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
# @!attribute [rw] recordings
#   @return [Array, nil]
RecordingList = Struct.new(
  :count,
  :offset,
  :recordings,
  keyword_init: true
)

# Request payload for RecordingList#load.
#
# @!attribute [rw] isrc
#   @return [String]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
RecordingListLoadMatch = Struct.new(
  :isrc,
  :fmt,
  :inc,
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
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
ReleaseLoadMatch = Struct.new(
  :id,
  :fmt,
  :inc,
  keyword_init: true
)

# Request payload for Release#list.
#
# @!attribute [rw] area
#   @return [String, nil]
#
# @!attribute [rw] artist
#   @return [String, nil]
#
# @!attribute [rw] collection
#   @return [String, nil]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] label
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] query
#   @return [String, nil]
#
# @!attribute [rw] recording
#   @return [String, nil]
#
# @!attribute [rw] release_group
#   @return [String, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
#
# @!attribute [rw] track
#   @return [String, nil]
#
# @!attribute [rw] track_artist
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
ReleaseListMatch = Struct.new(
  :area,
  :artist,
  :collection,
  :fmt,
  :inc,
  :label,
  :limit,
  :offset,
  :query,
  :recording,
  :release_group,
  :status,
  :track,
  :track_artist,
  :type,
  keyword_init: true
)

# ReleaseGroup entity data model.
#
# @!attribute [rw] disambiguation
#   @return [String, nil]
#
# @!attribute [rw] firstreleasedate
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [String, nil]
#
# @!attribute [rw] primarytype
#   @return [String, nil]
#
# @!attribute [rw] secondarytypes
#   @return [Array, nil]
#
# @!attribute [rw] title
#   @return [String, nil]
ReleaseGroup = Struct.new(
  :disambiguation,
  :firstreleasedate,
  :id,
  :primarytype,
  :secondarytypes,
  :title,
  keyword_init: true
)

# Request payload for ReleaseGroup#load.
#
# @!attribute [rw] id
#   @return [String]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
ReleaseGroupLoadMatch = Struct.new(
  :id,
  :fmt,
  :inc,
  :status,
  :type,
  keyword_init: true
)

# Request payload for ReleaseGroup#list.
#
# @!attribute [rw] artist
#   @return [String, nil]
#
# @!attribute [rw] collection
#   @return [String, nil]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] query
#   @return [String, nil]
#
# @!attribute [rw] release
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
ReleaseGroupListMatch = Struct.new(
  :artist,
  :collection,
  :fmt,
  :inc,
  :limit,
  :offset,
  :query,
  :release,
  :type,
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
# @!attribute [rw] releases
#   @return [Array, nil]
ReleaseList = Struct.new(
  :count,
  :offset,
  :releases,
  keyword_init: true
)

# Request payload for ReleaseList#load.
#
# @!attribute [rw] discid
#   @return [String]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
ReleaseListLoadMatch = Struct.new(
  :discid,
  :fmt,
  :inc,
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
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
SeriesLoadMatch = Struct.new(
  :id,
  :fmt,
  :inc,
  keyword_init: true
)

# Request payload for Series#list.
#
# @!attribute [rw] collection
#   @return [String, nil]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] query
#   @return [String, nil]
SeriesListMatch = Struct.new(
  :collection,
  :fmt,
  :inc,
  :limit,
  :offset,
  :query,
  keyword_init: true
)

# Tag entity data model.
class Tag
end

# Request payload for Tag#load.
#
# @!attribute [rw] fmt
#   @return [String, nil]
TagLoadMatch = Struct.new(
  :fmt,
  keyword_init: true
)

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
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
UrlLoadMatch = Struct.new(
  :id,
  :fmt,
  :inc,
  keyword_init: true
)

# Request payload for Url#list.
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] query
#   @return [String, nil]
#
# @!attribute [rw] resource
#   @return [String, nil]
UrlListMatch = Struct.new(
  :fmt,
  :inc,
  :limit,
  :offset,
  :query,
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
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
WorkLoadMatch = Struct.new(
  :id,
  :fmt,
  :inc,
  keyword_init: true
)

# Request payload for Work#list.
#
# @!attribute [rw] artist
#   @return [String, nil]
#
# @!attribute [rw] collection
#   @return [String, nil]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
#
# @!attribute [rw] limit
#   @return [Integer, nil]
#
# @!attribute [rw] offset
#   @return [Integer, nil]
#
# @!attribute [rw] query
#   @return [String, nil]
WorkListMatch = Struct.new(
  :artist,
  :collection,
  :fmt,
  :inc,
  :limit,
  :offset,
  :query,
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
# @!attribute [rw] works
#   @return [Array, nil]
WorkList = Struct.new(
  :count,
  :offset,
  :works,
  keyword_init: true
)

# Request payload for WorkList#load.
#
# @!attribute [rw] iswc
#   @return [String]
#
# @!attribute [rw] fmt
#   @return [String, nil]
#
# @!attribute [rw] inc
#   @return [String, nil]
WorkListLoadMatch = Struct.new(
  :iswc,
  :fmt,
  :inc,
  keyword_init: true
)

