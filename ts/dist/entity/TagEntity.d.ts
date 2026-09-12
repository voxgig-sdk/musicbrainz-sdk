import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Tag, TagLoadMatch, TagCreateData } from '../MusicbrainzTypes';
declare class TagEntity extends MusicbrainzEntityBase<Tag> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: TagEntity): TagEntity;
    load(this: any, reqmatch?: TagLoadMatch, ctrl?: Control): Promise<TagEntity>;
    create(this: any, reqdata?: TagCreateData, ctrl?: Control): Promise<TagEntity>;
}
export { TagEntity };
