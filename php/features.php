<?php
declare(strict_types=1);

// Musicbrainz SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class MusicbrainzFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new MusicbrainzBaseFeature();
            case "test":
                return new MusicbrainzTestFeature();
            default:
                return new MusicbrainzBaseFeature();
        }
    }
}
