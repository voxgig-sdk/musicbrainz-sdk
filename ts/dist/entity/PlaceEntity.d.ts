import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Place, PlaceLoadMatch, PlaceListMatch } from '../MusicbrainzTypes';
declare class PlaceEntity extends MusicbrainzEntityBase<Place> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: PlaceEntity): PlaceEntity;
    load(this: any, reqmatch?: PlaceLoadMatch, ctrl?: Control): Promise<PlaceEntity>;
    list(this: any, reqmatch?: PlaceListMatch, ctrl?: Control): Promise<PlaceEntity[]>;
}
export { PlaceEntity };
