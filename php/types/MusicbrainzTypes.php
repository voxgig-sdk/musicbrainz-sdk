<?php
declare(strict_types=1);

// Typed models for the Musicbrainz SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Area entity data model. */
class Area
{
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?array $life_span = null;
    public ?string $name = null;
    public ?string $sort_name = null;
    public ?string $type = null;
}

/** Request payload for Area#load. */
class AreaLoadMatch
{
    public string $id;
}

/** Match filter for Area#list (any subset of Area fields). */
class AreaListMatch
{
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?array $life_span = null;
    public ?string $name = null;
    public ?string $sort_name = null;
    public ?string $type = null;
}

/** Artist entity data model. */
class Artist
{
    public ?string $country = null;
    public ?string $disambiguation = null;
    public ?string $gender = null;
    public ?string $id = null;
    public ?array $life_span = null;
    public ?string $name = null;
    public ?string $sort_name = null;
    public ?string $type = null;
}

/** Request payload for Artist#load. */
class ArtistLoadMatch
{
    public string $id;
}

/** Match filter for Artist#list (any subset of Artist fields). */
class ArtistListMatch
{
    public ?string $country = null;
    public ?string $disambiguation = null;
    public ?string $gender = null;
    public ?string $id = null;
    public ?array $life_span = null;
    public ?string $name = null;
    public ?string $sort_name = null;
    public ?string $type = null;
}

/** Collection entity data model. */
class Collection
{
    public ?string $editor = null;
    public ?string $entity_type = null;
    public ?string $id = null;
    public ?string $name = null;
}

/** Match filter for Collection#list (any subset of Collection fields). */
class CollectionListMatch
{
    public ?string $editor = null;
    public ?string $entity_type = null;
    public ?string $id = null;
    public ?string $name = null;
}

/** Event entity data model. */
class Event
{
    public ?bool $cancelled = null;
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?array $life_span = null;
    public ?string $name = null;
    public ?string $time = null;
    public ?string $type = null;
}

/** Request payload for Event#load. */
class EventLoadMatch
{
    public string $id;
}

/** Match filter for Event#list (any subset of Event fields). */
class EventListMatch
{
    public ?bool $cancelled = null;
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?array $life_span = null;
    public ?string $name = null;
    public ?string $time = null;
    public ?string $type = null;
}

/** Genre entity data model. */
class Genre
{
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?string $name = null;
}

/** Request payload for Genre#load. */
class GenreLoadMatch
{
    public string $id;
}

/** Match filter for Genre#list (any subset of Genre fields). */
class GenreListMatch
{
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?string $name = null;
}

/** Instrument entity data model. */
class Instrument
{
    public ?string $description = null;
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?string $name = null;
    public ?string $type = null;
}

/** Request payload for Instrument#load. */
class InstrumentLoadMatch
{
    public string $id;
}

/** Match filter for Instrument#list (any subset of Instrument fields). */
class InstrumentListMatch
{
    public ?string $description = null;
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?string $name = null;
    public ?string $type = null;
}

/** Label entity data model. */
class Label
{
    public ?string $country = null;
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?int $label_code = null;
    public ?array $life_span = null;
    public ?string $name = null;
    public ?string $sort_name = null;
    public ?string $type = null;
}

/** Request payload for Label#load. */
class LabelLoadMatch
{
    public string $id;
}

/** Match filter for Label#list (any subset of Label fields). */
class LabelListMatch
{
    public ?string $country = null;
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?int $label_code = null;
    public ?array $life_span = null;
    public ?string $name = null;
    public ?string $sort_name = null;
    public ?string $type = null;
}

/** Place entity data model. */
class Place
{
    public ?string $address = null;
    public ?array $coordinate = null;
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?array $life_span = null;
    public ?string $name = null;
    public ?string $type = null;
}

/** Request payload for Place#load. */
class PlaceLoadMatch
{
    public string $id;
}

/** Match filter for Place#list (any subset of Place fields). */
class PlaceListMatch
{
    public ?string $address = null;
    public ?array $coordinate = null;
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?array $life_span = null;
    public ?string $name = null;
    public ?string $type = null;
}

/** Rating entity data model. */
class Rating
{
}

/** Match filter for Rating#load (any subset of Rating fields). */
class RatingLoadMatch
{
}

/** Match filter for Rating#create (any subset of Rating fields). */
class RatingCreateData
{
}

/** Recording entity data model. */
class Recording
{
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?int $length = null;
    public ?string $title = null;
    public ?bool $video = null;
}

/** Request payload for Recording#load. */
class RecordingLoadMatch
{
    public string $id;
}

/** Match filter for Recording#list (any subset of Recording fields). */
class RecordingListMatch
{
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?int $length = null;
    public ?string $title = null;
    public ?bool $video = null;
}

/** RecordingList entity data model. */
class RecordingList
{
    public ?int $count = null;
    public ?int $offset = null;
    public ?array $recording = null;
}

/** Request payload for RecordingList#load. */
class RecordingListLoadMatch
{
    public string $isrc;
}

/** Release entity data model. */
class Release
{
    public ?string $barcode = null;
    public ?string $country = null;
    public ?string $date = null;
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?string $packaging = null;
    public ?string $status = null;
    public ?string $title = null;
}

/** Request payload for Release#load. */
class ReleaseLoadMatch
{
    public string $id;
}

/** Match filter for Release#list (any subset of Release fields). */
class ReleaseListMatch
{
    public ?string $barcode = null;
    public ?string $country = null;
    public ?string $date = null;
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?string $packaging = null;
    public ?string $status = null;
    public ?string $title = null;
}

/** ReleaseGroup entity data model. */
class ReleaseGroup
{
    public ?string $disambiguation = null;
    public ?string $first_release_date = null;
    public ?string $id = null;
    public ?string $primary_type = null;
    public ?array $secondary_type = null;
    public ?string $title = null;
}

/** Request payload for ReleaseGroup#load. */
class ReleaseGroupLoadMatch
{
    public string $id;
}

/** Match filter for ReleaseGroup#list (any subset of ReleaseGroup fields). */
class ReleaseGroupListMatch
{
    public ?string $disambiguation = null;
    public ?string $first_release_date = null;
    public ?string $id = null;
    public ?string $primary_type = null;
    public ?array $secondary_type = null;
    public ?string $title = null;
}

/** ReleaseList entity data model. */
class ReleaseList
{
    public ?int $count = null;
    public ?int $offset = null;
    public ?array $release = null;
}

/** Request payload for ReleaseList#load. */
class ReleaseListLoadMatch
{
    public string $discid;
}

/** Series entity data model. */
class Series
{
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?string $name = null;
    public ?string $type = null;
}

/** Request payload for Series#load. */
class SeriesLoadMatch
{
    public string $id;
}

/** Match filter for Series#list (any subset of Series fields). */
class SeriesListMatch
{
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?string $name = null;
    public ?string $type = null;
}

/** Tag entity data model. */
class Tag
{
}

/** Match filter for Tag#load (any subset of Tag fields). */
class TagLoadMatch
{
}

/** Match filter for Tag#create (any subset of Tag fields). */
class TagCreateData
{
}

/** Url entity data model. */
class Url
{
    public ?string $id = null;
    public ?string $resource = null;
}

/** Request payload for Url#load. */
class UrlLoadMatch
{
    public string $id;
}

/** Match filter for Url#list (any subset of Url fields). */
class UrlListMatch
{
    public ?string $id = null;
    public ?string $resource = null;
}

/** Work entity data model. */
class Work
{
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?string $language = null;
    public ?string $title = null;
    public ?string $type = null;
}

/** Request payload for Work#load. */
class WorkLoadMatch
{
    public string $id;
}

/** Match filter for Work#list (any subset of Work fields). */
class WorkListMatch
{
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?string $language = null;
    public ?string $title = null;
    public ?string $type = null;
}

/** WorkList entity data model. */
class WorkList
{
    public ?int $count = null;
    public ?int $offset = null;
    public ?array $work = null;
}

/** Request payload for WorkList#load. */
class WorkListLoadMatch
{
    public string $iswc;
}

