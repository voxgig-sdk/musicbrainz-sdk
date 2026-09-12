import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Series, SeriesLoadMatch, SeriesListMatch } from '../MusicbrainzTypes';
declare class SeriesEntity extends MusicbrainzEntityBase<Series> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: SeriesEntity): SeriesEntity;
    load(this: any, reqmatch?: SeriesLoadMatch, ctrl?: Control): Promise<SeriesEntity>;
    list(this: any, reqmatch?: SeriesListMatch, ctrl?: Control): Promise<SeriesEntity[]>;
}
export { SeriesEntity };
