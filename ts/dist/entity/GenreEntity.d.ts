import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Genre, GenreLoadMatch, GenreListMatch } from '../MusicbrainzTypes';
declare class GenreEntity extends MusicbrainzEntityBase<Genre> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: GenreEntity): GenreEntity;
    load(this: any, reqmatch?: GenreLoadMatch, ctrl?: Control): Promise<GenreEntity>;
    list(this: any, reqmatch?: GenreListMatch, ctrl?: Control): Promise<GenreEntity[]>;
}
export { GenreEntity };
