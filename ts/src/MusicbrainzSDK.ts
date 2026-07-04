// Musicbrainz Ts SDK

import { AreaEntity } from './entity/AreaEntity'
import { ArtistEntity } from './entity/ArtistEntity'
import { CollectionEntity } from './entity/CollectionEntity'
import { EventEntity } from './entity/EventEntity'
import { GenreEntity } from './entity/GenreEntity'
import { InstrumentEntity } from './entity/InstrumentEntity'
import { LabelEntity } from './entity/LabelEntity'
import { PlaceEntity } from './entity/PlaceEntity'
import { RatingEntity } from './entity/RatingEntity'
import { RecordingEntity } from './entity/RecordingEntity'
import { RecordingListEntity } from './entity/RecordingListEntity'
import { ReleaseEntity } from './entity/ReleaseEntity'
import { ReleaseGroupEntity } from './entity/ReleaseGroupEntity'
import { ReleaseListEntity } from './entity/ReleaseListEntity'
import { SeriesEntity } from './entity/SeriesEntity'
import { TagEntity } from './entity/TagEntity'
import { UrlEntity } from './entity/UrlEntity'
import { WorkEntity } from './entity/WorkEntity'
import { WorkListEntity } from './entity/WorkListEntity'

export type * from './MusicbrainzTypes'


import { inspect } from 'node:util'

import type { Context, Feature } from './types'

import { config } from './Config'
import { MusicbrainzEntityBase } from './MusicbrainzEntityBase'
import { Utility } from './utility/Utility'


import { BaseFeature } from './feature/base/BaseFeature'


const stdutil = new Utility()


class MusicbrainzSDK {
  _mode: string = 'live'
  _options: any
  _utility = new Utility()
  _features: Feature[]
  _rootctx: Context

  constructor(options?: any) {

    this._rootctx = this._utility.makeContext({
      client: this,
      utility: this._utility,
      config,
      options,
      shared: new WeakMap()
    })

    this._options = this._utility.makeOptions(this._rootctx)

    const struct = this._utility.struct
    const getpath = struct.getpath
    const items = struct.items

    if (true === getpath(this._options.feature, 'test.active')) {
      this._mode = 'test'
    }

    this._rootctx.options = this._options

    this._features = []

    const featureAdd = this._utility.featureAdd
    const featureInit = this._utility.featureInit

    items(this._options.feature, (fitem: [string, any]) => {
      const fname = fitem[0]
      const fopts = fitem[1]
      if (fopts.active) {
        featureAdd(this._rootctx, this._rootctx.config.makeFeature(fname))
      }
    })

    if (null != this._options.extend) {
      for (let f of this._options.extend) {
        featureAdd(this._rootctx, f)
      }
    }

    for (let f of this._features) {
      featureInit(this._rootctx, f)
    }

    const featureHook = this._utility.featureHook
    featureHook(this._rootctx, 'PostConstruct')
  }


  options() {
    return this._utility.struct.clone(this._options)
  }


  utility() {
    return this._utility.struct.clone(this._utility)
  }


  async prepare(fetchargs?: any) {
    const utility = this._utility
    const struct = utility.struct
    const clone = struct.clone

    const {
      makeContext,
      makeFetchDef,
      prepareHeaders,
      prepareAuth,
    } = utility

    fetchargs = fetchargs || {}

    let ctx: Context = makeContext({
      opname: 'prepare',
      ctrl: fetchargs.ctrl || {},
    }, this._rootctx)

    const options = this._options

    // Build spec directly from SDK options + user-provided fetch args.
    const spec: any = {
      base: options.base,
      prefix: options.prefix,
      suffix: options.suffix,
      path: fetchargs.path || '',
      method: fetchargs.method || 'GET',
      params: fetchargs.params || {},
      query: fetchargs.query || {},
      headers: prepareHeaders(ctx),
      body: fetchargs.body,
      step: 'start',
    }

    ctx.spec = spec

    // Merge user-provided headers over SDK defaults.
    if (fetchargs.headers) {
      const uheaders = fetchargs.headers
      for (let key in uheaders) {
        spec.headers[key] = uheaders[key]
      }
    }

    // Apply SDK auth (apikey, auth prefix, etc.)
    const authResult = prepareAuth(ctx)
    if (authResult instanceof Error) {
      return authResult
    }

    return makeFetchDef(ctx)
  }


  async direct(fetchargs?: any) {
    const utility = this._utility
    const fetcher = utility.fetcher
    const makeContext = utility.makeContext

    const fetchdef = await this.prepare(fetchargs)
    if (fetchdef instanceof Error) {
      return fetchdef
    }

    let ctx: Context = makeContext({
      opname: 'direct',
      ctrl: (fetchargs || {}).ctrl || {},
    }, this._rootctx)

    try {
      const fetched = await fetcher(ctx, fetchdef.url, fetchdef)

      if (null == fetched) {
        return { ok: false, err: ctx.error('direct_no_response', 'response: undefined') }
      }
      else if (fetched instanceof Error) {
        return { ok: false, err: fetched }
      }

      const status = fetched.status

      // No body responses (204 No Content, 304 Not Modified) and explicit
      // zero content-length must skip JSON parsing — fetched.json() would
      // throw `Unexpected end of JSON input` on an empty body.
      const headers = fetched.headers
      const contentLength = headers && 'function' === typeof headers.get
        ? headers.get('content-length')
        : (headers || {})['content-length']
      const noBody = 204 === status || 304 === status || '0' === String(contentLength)

      let json: any = undefined
      if (!noBody) {
        try {
          json = 'function' === typeof fetched.json ? await fetched.json() : fetched.json
        }
        catch (parseErr) {
          // Body wasn't valid JSON — surface the raw response rather than
          // throwing. data stays undefined; callers can inspect status/headers.
          json = undefined
        }
      }

      return {
        ok: status >= 200 && status < 300,
        status,
        headers: fetched.headers,
        data: json,
      }
    }
    catch (err: any) {
      return { ok: false, err }
    }
  }



  _area?: AreaEntity

  // Idiomatic facade: `client.area.list()` / `client.area.load({ id })`.
  get area(): AreaEntity {
    return (this._area ??= new AreaEntity(this, undefined))
  }

  /** @deprecated Use `client.area` instead. */
  Area(data?: any) {
    const self = this
    return new AreaEntity(self,data)
  }


  _artist?: ArtistEntity

  // Idiomatic facade: `client.artist.list()` / `client.artist.load({ id })`.
  get artist(): ArtistEntity {
    return (this._artist ??= new ArtistEntity(this, undefined))
  }

  /** @deprecated Use `client.artist` instead. */
  Artist(data?: any) {
    const self = this
    return new ArtistEntity(self,data)
  }


  _collection?: CollectionEntity

  // Idiomatic facade: `client.collection.list()` / `client.collection.load({ id })`.
  get collection(): CollectionEntity {
    return (this._collection ??= new CollectionEntity(this, undefined))
  }

  /** @deprecated Use `client.collection` instead. */
  Collection(data?: any) {
    const self = this
    return new CollectionEntity(self,data)
  }


  _event?: EventEntity

  // Idiomatic facade: `client.event.list()` / `client.event.load({ id })`.
  get event(): EventEntity {
    return (this._event ??= new EventEntity(this, undefined))
  }

  /** @deprecated Use `client.event` instead. */
  Event(data?: any) {
    const self = this
    return new EventEntity(self,data)
  }


  _genre?: GenreEntity

  // Idiomatic facade: `client.genre.list()` / `client.genre.load({ id })`.
  get genre(): GenreEntity {
    return (this._genre ??= new GenreEntity(this, undefined))
  }

  /** @deprecated Use `client.genre` instead. */
  Genre(data?: any) {
    const self = this
    return new GenreEntity(self,data)
  }


  _instrument?: InstrumentEntity

  // Idiomatic facade: `client.instrument.list()` / `client.instrument.load({ id })`.
  get instrument(): InstrumentEntity {
    return (this._instrument ??= new InstrumentEntity(this, undefined))
  }

  /** @deprecated Use `client.instrument` instead. */
  Instrument(data?: any) {
    const self = this
    return new InstrumentEntity(self,data)
  }


  _label?: LabelEntity

  // Idiomatic facade: `client.label.list()` / `client.label.load({ id })`.
  get label(): LabelEntity {
    return (this._label ??= new LabelEntity(this, undefined))
  }

  /** @deprecated Use `client.label` instead. */
  Label(data?: any) {
    const self = this
    return new LabelEntity(self,data)
  }


  _place?: PlaceEntity

  // Idiomatic facade: `client.place.list()` / `client.place.load({ id })`.
  get place(): PlaceEntity {
    return (this._place ??= new PlaceEntity(this, undefined))
  }

  /** @deprecated Use `client.place` instead. */
  Place(data?: any) {
    const self = this
    return new PlaceEntity(self,data)
  }


  _rating?: RatingEntity

  // Idiomatic facade: `client.rating.list()` / `client.rating.load({ id })`.
  get rating(): RatingEntity {
    return (this._rating ??= new RatingEntity(this, undefined))
  }

  /** @deprecated Use `client.rating` instead. */
  Rating(data?: any) {
    const self = this
    return new RatingEntity(self,data)
  }


  _recording?: RecordingEntity

  // Idiomatic facade: `client.recording.list()` / `client.recording.load({ id })`.
  get recording(): RecordingEntity {
    return (this._recording ??= new RecordingEntity(this, undefined))
  }

  /** @deprecated Use `client.recording` instead. */
  Recording(data?: any) {
    const self = this
    return new RecordingEntity(self,data)
  }


  _recording_list?: RecordingListEntity

  // Idiomatic facade: `client.recording_list.list()` / `client.recording_list.load({ id })`.
  get recording_list(): RecordingListEntity {
    return (this._recording_list ??= new RecordingListEntity(this, undefined))
  }

  /** @deprecated Use `client.recording_list` instead. */
  RecordingList(data?: any) {
    const self = this
    return new RecordingListEntity(self,data)
  }


  _release?: ReleaseEntity

  // Idiomatic facade: `client.release.list()` / `client.release.load({ id })`.
  get release(): ReleaseEntity {
    return (this._release ??= new ReleaseEntity(this, undefined))
  }

  /** @deprecated Use `client.release` instead. */
  Release(data?: any) {
    const self = this
    return new ReleaseEntity(self,data)
  }


  _release_group?: ReleaseGroupEntity

  // Idiomatic facade: `client.release_group.list()` / `client.release_group.load({ id })`.
  get release_group(): ReleaseGroupEntity {
    return (this._release_group ??= new ReleaseGroupEntity(this, undefined))
  }

  /** @deprecated Use `client.release_group` instead. */
  ReleaseGroup(data?: any) {
    const self = this
    return new ReleaseGroupEntity(self,data)
  }


  _release_list?: ReleaseListEntity

  // Idiomatic facade: `client.release_list.list()` / `client.release_list.load({ id })`.
  get release_list(): ReleaseListEntity {
    return (this._release_list ??= new ReleaseListEntity(this, undefined))
  }

  /** @deprecated Use `client.release_list` instead. */
  ReleaseList(data?: any) {
    const self = this
    return new ReleaseListEntity(self,data)
  }


  _series?: SeriesEntity

  // Idiomatic facade: `client.series.list()` / `client.series.load({ id })`.
  get series(): SeriesEntity {
    return (this._series ??= new SeriesEntity(this, undefined))
  }

  /** @deprecated Use `client.series` instead. */
  Series(data?: any) {
    const self = this
    return new SeriesEntity(self,data)
  }


  _tag?: TagEntity

  // Idiomatic facade: `client.tag.list()` / `client.tag.load({ id })`.
  get tag(): TagEntity {
    return (this._tag ??= new TagEntity(this, undefined))
  }

  /** @deprecated Use `client.tag` instead. */
  Tag(data?: any) {
    const self = this
    return new TagEntity(self,data)
  }


  _url?: UrlEntity

  // Idiomatic facade: `client.url.list()` / `client.url.load({ id })`.
  get url(): UrlEntity {
    return (this._url ??= new UrlEntity(this, undefined))
  }

  /** @deprecated Use `client.url` instead. */
  Url(data?: any) {
    const self = this
    return new UrlEntity(self,data)
  }


  _work?: WorkEntity

  // Idiomatic facade: `client.work.list()` / `client.work.load({ id })`.
  get work(): WorkEntity {
    return (this._work ??= new WorkEntity(this, undefined))
  }

  /** @deprecated Use `client.work` instead. */
  Work(data?: any) {
    const self = this
    return new WorkEntity(self,data)
  }


  _work_list?: WorkListEntity

  // Idiomatic facade: `client.work_list.list()` / `client.work_list.load({ id })`.
  get work_list(): WorkListEntity {
    return (this._work_list ??= new WorkListEntity(this, undefined))
  }

  /** @deprecated Use `client.work_list` instead. */
  WorkList(data?: any) {
    const self = this
    return new WorkListEntity(self,data)
  }




  static test(testoptsarg?: any, sdkoptsarg?: any) {
    const struct = stdutil.struct
    const setpath = struct.setpath
    const getdef = struct.getdef
    const clone = struct.clone
    const setprop = struct.setprop

    const sdkopts = getdef(clone(sdkoptsarg), {})
    const testopts = getdef(clone(testoptsarg), {})
    setprop(testopts, 'active', true)
    setpath(sdkopts, 'feature.test', testopts)

    const testsdk = new MusicbrainzSDK(sdkopts)
    testsdk._mode = 'test'

    return testsdk
  }


  tester(testopts?: any, sdkopts?: any) {
    return MusicbrainzSDK.test(testopts, sdkopts)
  }


  toJSON() {
    return { name: 'Musicbrainz' }
  }

  toString() {
    return 'Musicbrainz ' + this._utility.struct.jsonify(this.toJSON())
  }

  [inspect.custom]() {
    return this.toString()
  }

}




const SDK = MusicbrainzSDK


export {
  stdutil,

  BaseFeature,
  MusicbrainzEntityBase,

  MusicbrainzSDK,
  SDK,
}


