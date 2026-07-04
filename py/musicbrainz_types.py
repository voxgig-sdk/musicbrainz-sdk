# Typed models for the Musicbrainz SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.

from __future__ import annotations

from dataclasses import dataclass
from typing import Optional, Any


@dataclass
class Area:
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    life_span: Optional[dict] = None
    name: Optional[str] = None
    sort_name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class AreaLoadMatch:
    id: str


@dataclass
class AreaListMatch:
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    life_span: Optional[dict] = None
    name: Optional[str] = None
    sort_name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class Artist:
    country: Optional[str] = None
    disambiguation: Optional[str] = None
    gender: Optional[str] = None
    id: Optional[str] = None
    life_span: Optional[dict] = None
    name: Optional[str] = None
    sort_name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class ArtistLoadMatch:
    id: str


@dataclass
class ArtistListMatch:
    country: Optional[str] = None
    disambiguation: Optional[str] = None
    gender: Optional[str] = None
    id: Optional[str] = None
    life_span: Optional[dict] = None
    name: Optional[str] = None
    sort_name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class Collection:
    editor: Optional[str] = None
    entity_type: Optional[str] = None
    id: Optional[str] = None
    name: Optional[str] = None


@dataclass
class CollectionListMatch:
    editor: Optional[str] = None
    entity_type: Optional[str] = None
    id: Optional[str] = None
    name: Optional[str] = None


@dataclass
class Event:
    cancelled: Optional[bool] = None
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    life_span: Optional[dict] = None
    name: Optional[str] = None
    time: Optional[str] = None
    type: Optional[str] = None


@dataclass
class EventLoadMatch:
    id: str


@dataclass
class EventListMatch:
    cancelled: Optional[bool] = None
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    life_span: Optional[dict] = None
    name: Optional[str] = None
    time: Optional[str] = None
    type: Optional[str] = None


@dataclass
class Genre:
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    name: Optional[str] = None


@dataclass
class GenreLoadMatch:
    id: str


@dataclass
class GenreListMatch:
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    name: Optional[str] = None


@dataclass
class Instrument:
    description: Optional[str] = None
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class InstrumentLoadMatch:
    id: str


@dataclass
class InstrumentListMatch:
    description: Optional[str] = None
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class Label:
    country: Optional[str] = None
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    label_code: Optional[int] = None
    life_span: Optional[dict] = None
    name: Optional[str] = None
    sort_name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class LabelLoadMatch:
    id: str


@dataclass
class LabelListMatch:
    country: Optional[str] = None
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    label_code: Optional[int] = None
    life_span: Optional[dict] = None
    name: Optional[str] = None
    sort_name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class Place:
    address: Optional[str] = None
    coordinate: Optional[dict] = None
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    life_span: Optional[dict] = None
    name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class PlaceLoadMatch:
    id: str


@dataclass
class PlaceListMatch:
    address: Optional[str] = None
    coordinate: Optional[dict] = None
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    life_span: Optional[dict] = None
    name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class Rating:
    pass


@dataclass
class RatingLoadMatch:
    pass


@dataclass
class RatingCreateData:
    pass


@dataclass
class Recording:
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    length: Optional[int] = None
    title: Optional[str] = None
    video: Optional[bool] = None


@dataclass
class RecordingLoadMatch:
    id: str


@dataclass
class RecordingListMatch:
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    length: Optional[int] = None
    title: Optional[str] = None
    video: Optional[bool] = None


@dataclass
class RecordingList:
    count: Optional[int] = None
    offset: Optional[int] = None
    recording: Optional[list] = None


@dataclass
class RecordingListLoadMatch:
    isrc: str


@dataclass
class Release:
    barcode: Optional[str] = None
    country: Optional[str] = None
    date: Optional[str] = None
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    packaging: Optional[str] = None
    status: Optional[str] = None
    title: Optional[str] = None


@dataclass
class ReleaseLoadMatch:
    id: str


@dataclass
class ReleaseListMatch:
    barcode: Optional[str] = None
    country: Optional[str] = None
    date: Optional[str] = None
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    packaging: Optional[str] = None
    status: Optional[str] = None
    title: Optional[str] = None


@dataclass
class ReleaseGroup:
    disambiguation: Optional[str] = None
    first_release_date: Optional[str] = None
    id: Optional[str] = None
    primary_type: Optional[str] = None
    secondary_type: Optional[list] = None
    title: Optional[str] = None


@dataclass
class ReleaseGroupLoadMatch:
    id: str


@dataclass
class ReleaseGroupListMatch:
    disambiguation: Optional[str] = None
    first_release_date: Optional[str] = None
    id: Optional[str] = None
    primary_type: Optional[str] = None
    secondary_type: Optional[list] = None
    title: Optional[str] = None


@dataclass
class ReleaseList:
    count: Optional[int] = None
    offset: Optional[int] = None
    release: Optional[list] = None


@dataclass
class ReleaseListLoadMatch:
    discid: str


@dataclass
class Series:
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class SeriesLoadMatch:
    id: str


@dataclass
class SeriesListMatch:
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    name: Optional[str] = None
    type: Optional[str] = None


@dataclass
class Tag:
    pass


@dataclass
class TagLoadMatch:
    pass


@dataclass
class TagCreateData:
    pass


@dataclass
class Url:
    id: Optional[str] = None
    resource: Optional[str] = None


@dataclass
class UrlLoadMatch:
    id: str


@dataclass
class UrlListMatch:
    id: Optional[str] = None
    resource: Optional[str] = None


@dataclass
class Work:
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    language: Optional[str] = None
    title: Optional[str] = None
    type: Optional[str] = None


@dataclass
class WorkLoadMatch:
    id: str


@dataclass
class WorkListMatch:
    disambiguation: Optional[str] = None
    id: Optional[str] = None
    language: Optional[str] = None
    title: Optional[str] = None
    type: Optional[str] = None


@dataclass
class WorkList:
    count: Optional[int] = None
    offset: Optional[int] = None
    work: Optional[list] = None


@dataclass
class WorkListLoadMatch:
    iswc: str

