<?php
declare(strict_types=1);

// Musicbrainz SDK utility: feature_add

class MusicbrainzFeatureAdd
{
    public static function call(MusicbrainzContext $ctx, mixed $f): void
    {
        $ctx->client->features[] = $f;
    }
}
