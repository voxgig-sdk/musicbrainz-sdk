<?php
declare(strict_types=1);

// Musicbrainz SDK utility: result_body

class MusicbrainzResultBody
{
    public static function call(MusicbrainzContext $ctx): ?MusicbrainzResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
