<?php
declare(strict_types=1);

// Musicbrainz SDK exists test

require_once __DIR__ . '/../musicbrainz_sdk.php';

use PHPUnit\Framework\TestCase;

class ExistsTest extends TestCase
{
    public function test_create_test_sdk(): void
    {
        $testsdk = MusicbrainzSDK::test(null, null);
        $this->assertNotNull($testsdk);
    }
}
