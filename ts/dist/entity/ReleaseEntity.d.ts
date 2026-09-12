import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Release, ReleaseLoadMatch, ReleaseListMatch } from '../MusicbrainzTypes';
declare class ReleaseEntity extends MusicbrainzEntityBase<Release> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: ReleaseEntity): ReleaseEntity;
    load(this: any, reqmatch?: ReleaseLoadMatch, ctrl?: Control): Promise<ReleaseEntity>;
    list(this: any, reqmatch?: ReleaseListMatch, ctrl?: Control): Promise<ReleaseEntity[]>;
}
export { ReleaseEntity };
