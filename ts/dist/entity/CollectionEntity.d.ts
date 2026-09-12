import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Collection, CollectionListMatch } from '../MusicbrainzTypes';
declare class CollectionEntity extends MusicbrainzEntityBase<Collection> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: CollectionEntity): CollectionEntity;
    list(this: any, reqmatch?: CollectionListMatch, ctrl?: Control): Promise<CollectionEntity[]>;
}
export { CollectionEntity };
