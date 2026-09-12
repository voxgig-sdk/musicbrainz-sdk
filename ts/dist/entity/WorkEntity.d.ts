import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Work, WorkLoadMatch, WorkListMatch } from '../MusicbrainzTypes';
declare class WorkEntity extends MusicbrainzEntityBase<Work> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: WorkEntity): WorkEntity;
    load(this: any, reqmatch?: WorkLoadMatch, ctrl?: Control): Promise<WorkEntity>;
    list(this: any, reqmatch?: WorkListMatch, ctrl?: Control): Promise<WorkEntity[]>;
}
export { WorkEntity };
