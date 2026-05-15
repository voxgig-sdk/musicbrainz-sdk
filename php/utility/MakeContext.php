<?php
declare(strict_types=1);

// Musicbrainz SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class MusicbrainzMakeContext
{
    public static function call(array $ctxmap, ?MusicbrainzContext $basectx): MusicbrainzContext
    {
        return new MusicbrainzContext($ctxmap, $basectx);
    }
}
