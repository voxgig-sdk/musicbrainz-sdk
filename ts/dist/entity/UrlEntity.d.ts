import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Url, UrlLoadMatch, UrlListMatch } from '../MusicbrainzTypes';
declare class UrlEntity extends MusicbrainzEntityBase<Url> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: UrlEntity): UrlEntity;
    load(this: any, reqmatch?: UrlLoadMatch, ctrl?: Control): Promise<UrlEntity>;
    list(this: any, reqmatch?: UrlListMatch, ctrl?: Control): Promise<UrlEntity[]>;
}
export { UrlEntity };
