import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Recording, RecordingLoadMatch, RecordingListMatch } from '../MusicbrainzTypes';
declare class RecordingEntity extends MusicbrainzEntityBase<Recording> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: RecordingEntity): RecordingEntity;
    load(this: any, reqmatch?: RecordingLoadMatch, ctrl?: Control): Promise<RecordingEntity>;
    list(this: any, reqmatch?: RecordingListMatch, ctrl?: Control): Promise<RecordingEntity[]>;
}
export { RecordingEntity };
