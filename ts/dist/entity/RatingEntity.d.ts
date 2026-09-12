import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Rating, RatingLoadMatch, RatingCreateData } from '../MusicbrainzTypes';
declare class RatingEntity extends MusicbrainzEntityBase<Rating> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: RatingEntity): RatingEntity;
    load(this: any, reqmatch?: RatingLoadMatch, ctrl?: Control): Promise<RatingEntity>;
    create(this: any, reqdata?: RatingCreateData, ctrl?: Control): Promise<RatingEntity>;
}
export { RatingEntity };
