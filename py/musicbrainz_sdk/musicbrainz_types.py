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
    begin: str
    disambiguation: str
    end: str
    ended: bool
    id: str
    lifespan: dict
    name: str
    sortname: str
    type: str


class AreaLoadMatchRequired(TypedDict):
    id: str


class AreaLoadMatch(AreaLoadMatchRequired, total=False):
    fmt: str
    inc: str


class AreaListMatch(TypedDict, total=False):
    fmt: str
    inc: str
    limit: int
    offset: int
    query: str


class Artist(TypedDict, total=False):
    begin: str
    country: str
    disambiguation: str
    end: str
    ended: bool
    gender: str
    id: str
    lifespan: dict
    name: str
    sortname: str
    type: str


class ArtistLoadMatchRequired(TypedDict):
    id: str


class ArtistLoadMatch(ArtistLoadMatchRequired, total=False):
    fmt: str
    inc: str
    status: str
    type: str


class ArtistListMatch(TypedDict, total=False):
    area: str
    collection: str
    fmt: str
    inc: str
    limit: int
    offset: int
    query: str
    recording: str
    release: str
    release_group: str
    work: str


class Collection(TypedDict, total=False):
    editor: str
    entitytype: str
    id: str
    name: str


class CollectionListMatch(TypedDict, total=False):
    fmt: str
    inc: str
    limit: int
    offset: int


class Event(TypedDict, total=False):
    begin: str
    cancelled: bool
    disambiguation: str
    end: str
    ended: bool
    id: str
    lifespan: dict
    name: str
    time: str
    type: str


class EventLoadMatchRequired(TypedDict):
    id: str


class EventLoadMatch(EventLoadMatchRequired, total=False):
    fmt: str
    inc: str


class EventListMatch(TypedDict, total=False):
    area: str
    artist: str
    fmt: str
    inc: str
    limit: int
    offset: int
    place: str
    query: str


class Genre(TypedDict, total=False):
    disambiguation: str
    id: str
    name: str


class GenreLoadMatchRequired(TypedDict):
    id: str


class GenreLoadMatch(GenreLoadMatchRequired, total=False):
    fmt: str


class GenreListMatch(TypedDict, total=False):
    fmt: str
    limit: int
    offset: int


class Instrument(TypedDict, total=False):
    description: str
    disambiguation: str
    id: str
    name: str
    type: str


class InstrumentLoadMatchRequired(TypedDict):
    id: str


class InstrumentLoadMatch(InstrumentLoadMatchRequired, total=False):
    fmt: str
    inc: str


class InstrumentListMatch(TypedDict, total=False):
    collection: str
    fmt: str
    inc: str
    limit: int
    offset: int
    query: str


class Label(TypedDict, total=False):
    begin: str
    country: str
    disambiguation: str
    end: str
    ended: bool
    id: str
    labelcode: int
    lifespan: dict
    name: str
    sortname: str
    type: str


class LabelLoadMatchRequired(TypedDict):
    id: str


class LabelLoadMatch(LabelLoadMatchRequired, total=False):
    fmt: str
    inc: str
    status: str
    type: str


class LabelListMatch(TypedDict, total=False):
    area: str
    collection: str
    fmt: str
    inc: str
    limit: int
    offset: int
    query: str
    release: str


class Place(TypedDict, total=False):
    address: str
    coordinates: dict
    disambiguation: str
    id: str
    lifespan: dict
    name: str
    type: str


class PlaceLoadMatchRequired(TypedDict):
    id: str


class PlaceLoadMatch(PlaceLoadMatchRequired, total=False):
    fmt: str
    inc: str


class PlaceListMatch(TypedDict, total=False):
    area: str
    collection: str
    fmt: str
    inc: str
    limit: int
    offset: int
    query: str


class Rating(TypedDict):
    pass


class RatingLoadMatch(TypedDict, total=False):
    fmt: str


class RatingCreateData(TypedDict):
    pass


class Recording(TypedDict, total=False):
    disambiguation: str
    id: str
    length: int
    title: str
    video: bool


class RecordingLoadMatchRequired(TypedDict):
    id: str


class RecordingLoadMatch(RecordingLoadMatchRequired, total=False):
    fmt: str
    inc: str
    status: str
    type: str


class RecordingListMatch(TypedDict, total=False):
    artist: str
    collection: str
    fmt: str
    inc: str
    limit: int
    offset: int
    query: str
    release: str
    work: str


class RecordingList(TypedDict, total=False):
    count: int
    offset: int
    recordings: list


class RecordingListLoadMatchRequired(TypedDict):
    isrc: str


class RecordingListLoadMatch(RecordingListLoadMatchRequired, total=False):
    fmt: str
    inc: str


class Release(TypedDict, total=False):
    barcode: str
    country: str
    date: str
    disambiguation: str
    id: str
    packaging: str
    status: str
    title: str


class ReleaseLoadMatchRequired(TypedDict):
    id: str


class ReleaseLoadMatch(ReleaseLoadMatchRequired, total=False):
    fmt: str
    inc: str


class ReleaseListMatch(TypedDict, total=False):
    area: str
    artist: str
    collection: str
    fmt: str
    inc: str
    label: str
    limit: int
    offset: int
    query: str
    recording: str
    release_group: str
    status: str
    track: str
    track_artist: str
    type: str


class ReleaseGroup(TypedDict, total=False):
    disambiguation: str
    firstreleasedate: str
    id: str
    primarytype: str
    secondarytypes: list
    title: str


class ReleaseGroupLoadMatchRequired(TypedDict):
    id: str


class ReleaseGroupLoadMatch(ReleaseGroupLoadMatchRequired, total=False):
    fmt: str
    inc: str
    status: str
    type: str


class ReleaseGroupListMatch(TypedDict, total=False):
    artist: str
    collection: str
    fmt: str
    inc: str
    limit: int
    offset: int
    query: str
    release: str
    type: str


class ReleaseList(TypedDict, total=False):
    count: int
    offset: int
    releases: list


class ReleaseListLoadMatchRequired(TypedDict):
    discid: str


class ReleaseListLoadMatch(ReleaseListLoadMatchRequired, total=False):
    fmt: str
    inc: str


class Series(TypedDict, total=False):
    disambiguation: str
    id: str
    name: str
    type: str


class SeriesLoadMatchRequired(TypedDict):
    id: str


class SeriesLoadMatch(SeriesLoadMatchRequired, total=False):
    fmt: str
    inc: str


class SeriesListMatch(TypedDict, total=False):
    collection: str
    fmt: str
    inc: str
    limit: int
    offset: int
    query: str


class Tag(TypedDict):
    pass


class TagLoadMatch(TypedDict, total=False):
    fmt: str


class TagCreateData(TypedDict):
    pass


class Url(TypedDict, total=False):
    id: str
    resource: str


class UrlLoadMatchRequired(TypedDict):
    id: str


class UrlLoadMatch(UrlLoadMatchRequired, total=False):
    fmt: str
    inc: str


class UrlListMatch(TypedDict, total=False):
    fmt: str
    inc: str
    limit: int
    offset: int
    query: str
    resource: str


class Work(TypedDict, total=False):
    disambiguation: str
    id: str
    language: str
    title: str
    type: str


class WorkLoadMatchRequired(TypedDict):
    id: str


class WorkLoadMatch(WorkLoadMatchRequired, total=False):
    fmt: str
    inc: str


class WorkListMatch(TypedDict, total=False):
    artist: str
    collection: str
    fmt: str
    inc: str
    limit: int
    offset: int
    query: str


class WorkList(TypedDict, total=False):
    count: int
    offset: int
    works: list


class WorkListLoadMatchRequired(TypedDict):
    iswc: str


class WorkListLoadMatch(WorkListLoadMatchRequired, total=False):
    fmt: str
    inc: str
