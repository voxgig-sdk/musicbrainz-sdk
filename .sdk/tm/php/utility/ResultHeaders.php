<?php
declare(strict_types=1);

// Musicbrainz SDK utility: result_headers

class MusicbrainzResultHeaders
{
    public static function call(MusicbrainzContext $ctx): ?MusicbrainzResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
