<?php
declare(strict_types=1);

// Musicbrainz SDK base feature

class MusicbrainzBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    // Positions this feature when added via the client `extend` option:
    // "__before__" / "__after__" / "__replace__" name an already-added
    // feature (mirrors the ts feature `_options`). Declared so setting it
    // on an extension instance avoids the dynamic-property deprecation.
    public ?array $_options = null;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(MusicbrainzContext $ctx, array $options): void {}
    public function PostConstruct(MusicbrainzContext $ctx): void {}
    public function PostConstructEntity(MusicbrainzContext $ctx): void {}
    public function SetData(MusicbrainzContext $ctx): void {}
    public function GetData(MusicbrainzContext $ctx): void {}
    public function GetMatch(MusicbrainzContext $ctx): void {}
    public function SetMatch(MusicbrainzContext $ctx): void {}
    public function PrePoint(MusicbrainzContext $ctx): void {}
    public function PreSpec(MusicbrainzContext $ctx): void {}
    public function PreRequest(MusicbrainzContext $ctx): void {}
    public function PreResponse(MusicbrainzContext $ctx): void {}
    public function PreResult(MusicbrainzContext $ctx): void {}
    public function PreDone(MusicbrainzContext $ctx): void {}
    public function PreUnexpected(MusicbrainzContext $ctx): void {}
}
