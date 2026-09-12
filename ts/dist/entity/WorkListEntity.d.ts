import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { WorkList, WorkListLoadMatch } from '../MusicbrainzTypes';
declare class WorkListEntity extends MusicbrainzEntityBase<WorkList> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: WorkListEntity): WorkListEntity;
    load(this: any, reqmatch?: WorkListLoadMatch, ctrl?: Control): Promise<WorkListEntity>;
}
export { WorkListEntity };
