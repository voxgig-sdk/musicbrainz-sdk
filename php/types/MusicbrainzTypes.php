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
    public ?string $begin = null;
    public ?string $disambiguation = null;
    public ?string $end = null;
    public ?bool $ended = null;
    public ?string $id = null;
    public ?array $lifespan = null;
    public ?string $name = null;
    public ?string $sortname = null;
    public ?string $type = null;
}

/** Request payload for Area#load. */
class AreaLoadMatch
{
    public string $id;
    public ?string $fmt = null;
    public ?string $inc = null;
}

/** Request payload for Area#list. */
class AreaListMatch
{
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $query = null;
}

/** Artist entity data model. */
class Artist
{
    public ?string $begin = null;
    public ?string $country = null;
    public ?string $disambiguation = null;
    public ?string $end = null;
    public ?bool $ended = null;
    public ?string $gender = null;
    public ?string $id = null;
    public ?array $lifespan = null;
    public ?string $name = null;
    public ?string $sortname = null;
    public ?string $type = null;
}

/** Request payload for Artist#load. */
class ArtistLoadMatch
{
    public string $id;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?string $status = null;
    public ?string $type = null;
}

/** Request payload for Artist#list. */
class ArtistListMatch
{
    public ?string $area = null;
    public ?string $collection = null;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $query = null;
    public ?string $recording = null;
    public ?string $release = null;
    public ?string $release_group = null;
    public ?string $work = null;
}

/** Collection entity data model. */
class Collection
{
    public ?string $editor = null;
    public ?string $entitytype = null;
    public ?string $id = null;
    public ?string $name = null;
}

/** Request payload for Collection#list. */
class CollectionListMatch
{
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?int $limit = null;
    public ?int $offset = null;
}

/** Event entity data model. */
class Event
{
    public ?string $begin = null;
    public ?bool $cancelled = null;
    public ?string $disambiguation = null;
    public ?string $end = null;
    public ?bool $ended = null;
    public ?string $id = null;
    public ?array $lifespan = null;
    public ?string $name = null;
    public ?string $time = null;
    public ?string $type = null;
}

/** Request payload for Event#load. */
class EventLoadMatch
{
    public string $id;
    public ?string $fmt = null;
    public ?string $inc = null;
}

/** Request payload for Event#list. */
class EventListMatch
{
    public ?string $area = null;
    public ?string $artist = null;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $place = null;
    public ?string $query = null;
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
    public ?string $fmt = null;
}

/** Request payload for Genre#list. */
class GenreListMatch
{
    public ?string $fmt = null;
    public ?int $limit = null;
    public ?int $offset = null;
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
    public ?string $fmt = null;
    public ?string $inc = null;
}

/** Request payload for Instrument#list. */
class InstrumentListMatch
{
    public ?string $collection = null;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $query = null;
}

/** Label entity data model. */
class Label
{
    public ?string $begin = null;
    public ?string $country = null;
    public ?string $disambiguation = null;
    public ?string $end = null;
    public ?bool $ended = null;
    public ?string $id = null;
    public ?int $labelcode = null;
    public ?array $lifespan = null;
    public ?string $name = null;
    public ?string $sortname = null;
    public ?string $type = null;
}

/** Request payload for Label#load. */
class LabelLoadMatch
{
    public string $id;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?string $status = null;
    public ?string $type = null;
}

/** Request payload for Label#list. */
class LabelListMatch
{
    public ?string $area = null;
    public ?string $collection = null;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $query = null;
    public ?string $release = null;
}

/** Place entity data model. */
class Place
{
    public ?string $address = null;
    public ?array $coordinates = null;
    public ?string $disambiguation = null;
    public ?string $id = null;
    public ?array $lifespan = null;
    public ?string $name = null;
    public ?string $type = null;
}

/** Request payload for Place#load. */
class PlaceLoadMatch
{
    public string $id;
    public ?string $fmt = null;
    public ?string $inc = null;
}

/** Request payload for Place#list. */
class PlaceListMatch
{
    public ?string $area = null;
    public ?string $collection = null;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $query = null;
}

/** Rating entity data model. */
class Rating
{
}

/** Request payload for Rating#load. */
class RatingLoadMatch
{
    public ?string $fmt = null;
}

/** Request payload for Rating#create. */
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
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?string $status = null;
    public ?string $type = null;
}

/** Request payload for Recording#list. */
class RecordingListMatch
{
    public ?string $artist = null;
    public ?string $collection = null;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $query = null;
    public ?string $release = null;
    public ?string $work = null;
}

/** RecordingList entity data model. */
class RecordingList
{
    public ?int $count = null;
    public ?int $offset = null;
    public ?array $recordings = null;
}

/** Request payload for RecordingList#load. */
class RecordingListLoadMatch
{
    public string $isrc;
    public ?string $fmt = null;
    public ?string $inc = null;
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
    public ?string $fmt = null;
    public ?string $inc = null;
}

/** Request payload for Release#list. */
class ReleaseListMatch
{
    public ?string $area = null;
    public ?string $artist = null;
    public ?string $collection = null;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?string $label = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $query = null;
    public ?string $recording = null;
    public ?string $release_group = null;
    public ?string $status = null;
    public ?string $track = null;
    public ?string $track_artist = null;
    public ?string $type = null;
}

/** ReleaseGroup entity data model. */
class ReleaseGroup
{
    public ?string $disambiguation = null;
    public ?string $firstreleasedate = null;
    public ?string $id = null;
    public ?string $primarytype = null;
    public ?array $secondarytypes = null;
    public ?string $title = null;
}

/** Request payload for ReleaseGroup#load. */
class ReleaseGroupLoadMatch
{
    public string $id;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?string $status = null;
    public ?string $type = null;
}

/** Request payload for ReleaseGroup#list. */
class ReleaseGroupListMatch
{
    public ?string $artist = null;
    public ?string $collection = null;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $query = null;
    public ?string $release = null;
    public ?string $type = null;
}

/** ReleaseList entity data model. */
class ReleaseList
{
    public ?int $count = null;
    public ?int $offset = null;
    public ?array $releases = null;
}

/** Request payload for ReleaseList#load. */
class ReleaseListLoadMatch
{
    public string $discid;
    public ?string $fmt = null;
    public ?string $inc = null;
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
    public ?string $fmt = null;
    public ?string $inc = null;
}

/** Request payload for Series#list. */
class SeriesListMatch
{
    public ?string $collection = null;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $query = null;
}

/** Tag entity data model. */
class Tag
{
}

/** Request payload for Tag#load. */
class TagLoadMatch
{
    public ?string $fmt = null;
}

/** Request payload for Tag#create. */
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
    public ?string $fmt = null;
    public ?string $inc = null;
}

/** Request payload for Url#list. */
class UrlListMatch
{
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $query = null;
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
    public ?string $fmt = null;
    public ?string $inc = null;
}

/** Request payload for Work#list. */
class WorkListMatch
{
    public ?string $artist = null;
    public ?string $collection = null;
    public ?string $fmt = null;
    public ?string $inc = null;
    public ?int $limit = null;
    public ?int $offset = null;
    public ?string $query = null;
}

/** WorkList entity data model. */
class WorkList
{
    public ?int $count = null;
    public ?int $offset = null;
    public ?array $works = null;
}

/** Request payload for WorkList#load. */
class WorkListLoadMatch
{
    public string $iswc;
    public ?string $fmt = null;
    public ?string $inc = null;
}

