# Typed models for the Musicbrainz SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class Area(TypedDict, total=False):
    disambiguation: str
    id: str
    life_span: dict
    name: str
    sort_name: str
    type: str


class AreaLoadMatch(TypedDict):
    id: str


class AreaListMatch(TypedDict, total=False):
    disambiguation: str
    id: str
    life_span: dict
    name: str
    sort_name: str
    type: str


class Artist(TypedDict, total=False):
    country: str
    disambiguation: str
    gender: str
    id: str
    life_span: dict
    name: str
    sort_name: str
    type: str


class ArtistLoadMatch(TypedDict):
    id: str


class ArtistListMatch(TypedDict, total=False):
    country: str
    disambiguation: str
    gender: str
    id: str
    life_span: dict
    name: str
    sort_name: str
    type: str


class Collection(TypedDict, total=False):
    editor: str
    entity_type: str
    id: str
    name: str


class CollectionListMatch(TypedDict, total=False):
    editor: str
    entity_type: str
    id: str
    name: str


class Event(TypedDict, total=False):
    cancelled: bool
    disambiguation: str
    id: str
    life_span: dict
    name: str
    time: str
    type: str


class EventLoadMatch(TypedDict):
    id: str


class EventListMatch(TypedDict, total=False):
    cancelled: bool
    disambiguation: str
    id: str
    life_span: dict
    name: str
    time: str
    type: str


class Genre(TypedDict, total=False):
    disambiguation: str
    id: str
    name: str


class GenreLoadMatch(TypedDict):
    id: str


class GenreListMatch(TypedDict, total=False):
    disambiguation: str
    id: str
    name: str


class Instrument(TypedDict, total=False):
    description: str
    disambiguation: str
    id: str
    name: str
    type: str


class InstrumentLoadMatch(TypedDict):
    id: str


class InstrumentListMatch(TypedDict, total=False):
    description: str
    disambiguation: str
    id: str
    name: str
    type: str


class Label(TypedDict, total=False):
    country: str
    disambiguation: str
    id: str
    label_code: int
    life_span: dict
    name: str
    sort_name: str
    type: str


class LabelLoadMatch(TypedDict):
    id: str


class LabelListMatch(TypedDict, total=False):
    country: str
    disambiguation: str
    id: str
    label_code: int
    life_span: dict
    name: str
    sort_name: str
    type: str


class Place(TypedDict, total=False):
    address: str
    coordinate: dict
    disambiguation: str
    id: str
    life_span: dict
    name: str
    type: str


class PlaceLoadMatch(TypedDict):
    id: str


class PlaceListMatch(TypedDict, total=False):
    address: str
    coordinate: dict
    disambiguation: str
    id: str
    life_span: dict
    name: str
    type: str


class Rating(TypedDict):
    pass


class RatingLoadMatch(TypedDict):
    pass


class RatingCreateData(TypedDict):
    pass


class Recording(TypedDict, total=False):
    disambiguation: str
    id: str
    length: int
    title: str
    video: bool


class RecordingLoadMatch(TypedDict):
    id: str


class RecordingListMatch(TypedDict, total=False):
    disambiguation: str
    id: str
    length: int
    title: str
    video: bool


class RecordingList(TypedDict, total=False):
    count: int
    offset: int
    recording: list


class RecordingListLoadMatch(TypedDict):
    isrc: str


class Release(TypedDict, total=False):
    barcode: str
    country: str
    date: str
    disambiguation: str
    id: str
    packaging: str
    status: str
    title: str


class ReleaseLoadMatch(TypedDict):
    id: str


class ReleaseListMatch(TypedDict, total=False):
    barcode: str
    country: str
    date: str
    disambiguation: str
    id: str
    packaging: str
    status: str
    title: str


class ReleaseGroup(TypedDict, total=False):
    disambiguation: str
    first_release_date: str
    id: str
    primary_type: str
    secondary_type: list
    title: str


class ReleaseGroupLoadMatch(TypedDict):
    id: str


class ReleaseGroupListMatch(TypedDict, total=False):
    disambiguation: str
    first_release_date: str
    id: str
    primary_type: str
    secondary_type: list
    title: str


class ReleaseList(TypedDict, total=False):
    count: int
    offset: int
    release: list


class ReleaseListLoadMatch(TypedDict):
    discid: str


class Series(TypedDict, total=False):
    disambiguation: str
    id: str
    name: str
    type: str


class SeriesLoadMatch(TypedDict):
    id: str


class SeriesListMatch(TypedDict, total=False):
    disambiguation: str
    id: str
    name: str
    type: str


class Tag(TypedDict):
    pass


class TagLoadMatch(TypedDict):
    pass


class TagCreateData(TypedDict):
    pass


class Url(TypedDict, total=False):
    id: str
    resource: str


class UrlLoadMatch(TypedDict):
    id: str


class UrlListMatch(TypedDict, total=False):
    id: str
    resource: str


class Work(TypedDict, total=False):
    disambiguation: str
    id: str
    language: str
    title: str
    type: str


class WorkLoadMatch(TypedDict):
    id: str


class WorkListMatch(TypedDict, total=False):
    disambiguation: str
    id: str
    language: str
    title: str
    type: str


class WorkList(TypedDict, total=False):
    count: int
    offset: int
    work: list


class WorkListLoadMatch(TypedDict):
    iswc: str
