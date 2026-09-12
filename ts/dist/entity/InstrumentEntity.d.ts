import { MusicbrainzEntityBase } from '../MusicbrainzEntityBase';
import type { MusicbrainzSDK } from '../MusicbrainzSDK';
import type { Control } from '../types';
import type { Instrument, InstrumentLoadMatch, InstrumentListMatch } from '../MusicbrainzTypes';
declare class InstrumentEntity extends MusicbrainzEntityBase<Instrument> {
    constructor(client: MusicbrainzSDK, entopts: any);
    make(this: InstrumentEntity): InstrumentEntity;
    load(this: any, reqmatch?: InstrumentLoadMatch, ctrl?: Control): Promise<InstrumentEntity>;
    list(this: any, reqmatch?: InstrumentListMatch, ctrl?: Control): Promise<InstrumentEntity[]>;
}
export { InstrumentEntity };
