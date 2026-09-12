import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Label, LabelLoadMatch, LabelListMatch } from '../MusicbrainzTypes';
declare class LabelEntity extends MusicbrainzEntityBase<Label> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: LabelEntity): LabelEntity;
    load(this: any, reqmatch?: LabelLoadMatch, ctrl?: Control): Promise<LabelEntity>;
    list(this: any, reqmatch?: LabelListMatch, ctrl?: Control): Promise<LabelEntity[]>;
}
export { LabelEntity };
