import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Area, AreaLoadMatch, AreaListMatch } from '../MusicbrainzTypes';
declare class AreaEntity extends MusicbrainzEntityBase<Area> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: AreaEntity): AreaEntity;
    load(this: any, reqmatch?: AreaLoadMatch, ctrl?: Control): Promise<AreaEntity>;
    list(this: any, reqmatch?: AreaListMatch, ctrl?: Control): Promise<AreaEntity[]>;
}
export { AreaEntity };
