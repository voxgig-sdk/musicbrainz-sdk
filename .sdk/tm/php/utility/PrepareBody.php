<?php
declare(strict_types=1);

// Musicbrainz SDK utility: prepare_body

class MusicbrainzPrepareBody
{
    public static function call(MusicbrainzContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
