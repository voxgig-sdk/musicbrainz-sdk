import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { RecordingList, RecordingListLoadMatch } from '../MusicbrainzTypes';
declare class RecordingListEntity extends MusicbrainzEntityBase<RecordingList> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: RecordingListEntity): RecordingListEntity;
    load(this: any, reqmatch?: RecordingListLoadMatch, ctrl?: Control): Promise<RecordingListEntity>;
}
export { RecordingListEntity };
