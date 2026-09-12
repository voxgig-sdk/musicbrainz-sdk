import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { ReleaseGroup, ReleaseGroupLoadMatch, ReleaseGroupListMatch } from '../MusicbrainzTypes';
declare class ReleaseGroupEntity extends MusicbrainzEntityBase<ReleaseGroup> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: ReleaseGroupEntity): ReleaseGroupEntity;
    load(this: any, reqmatch?: ReleaseGroupLoadMatch, ctrl?: Control): Promise<ReleaseGroupEntity>;
    list(this: any, reqmatch?: ReleaseGroupListMatch, ctrl?: Control): Promise<ReleaseGroupEntity[]>;
}
export { ReleaseGroupEntity };
