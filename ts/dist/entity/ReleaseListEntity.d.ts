import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { ReleaseList, ReleaseListLoadMatch } from '../MusicbrainzTypes';
declare class ReleaseListEntity extends MusicbrainzEntityBase<ReleaseList> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: ReleaseListEntity): ReleaseListEntity;
    load(this: any, reqmatch?: ReleaseListLoadMatch, ctrl?: Control): Promise<ReleaseListEntity>;
}
export { ReleaseListEntity };
