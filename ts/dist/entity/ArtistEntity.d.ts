import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Artist, ArtistLoadMatch, ArtistListMatch } from '../MusicbrainzTypes';
declare class ArtistEntity extends MusicbrainzEntityBase<Artist> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: ArtistEntity): ArtistEntity;
    load(this: any, reqmatch?: ArtistLoadMatch, ctrl?: Control): Promise<ArtistEntity>;
    list(this: any, reqmatch?: ArtistListMatch, ctrl?: Control): Promise<ArtistEntity[]>;
}
export { ArtistEntity };
