<?php
declare(strict_types=1);

// Musicbrainz SDK utility registration

require_once __DIR__ . '/../core/UtilityType.php';
require_once __DIR__ . '/Clean.php';
require_once __DIR__ . '/Done.php';
require_once __DIR__ . '/MakeError.php';
require_once __DIR__ . '/FeatureAdd.php';
require_once __DIR__ . '/FeatureHook.php';
require_once __DIR__ . '/FeatureInit.php';
require_once __DIR__ . '/Fetcher.php';
require_once __DIR__ . '/MakeFetchDef.php';
require_once __DIR__ . '/MakeContext.php';
require_once __DIR__ . '/MakeOptions.php';
require_once __DIR__ . '/MakeRequest.php';
require_once __DIR__ . '/MakeResponse.php';
require_once __DIR__ . '/MakeResult.php';
require_once __DIR__ . '/MakePoint.php';
require_once __DIR__ . '/MakeSpec.php';
require_once __DIR__ . '/MakeUrl.php';
require_once __DIR__ . '/Param.php';
require_once __DIR__ . '/PrepareAuth.php';
require_once __DIR__ . '/PrepareBody.php';
require_once __DIR__ . '/PrepareHeaders.php';
require_once __DIR__ . '/PrepareMethod.php';
require_once __DIR__ . '/PrepareParams.php';
require_once __DIR__ . '/PreparePath.php';
require_once __DIR__ . '/PrepareQuery.php';
require_once __DIR__ . '/ResultBasic.php';
require_once __DIR__ . '/ResultBody.php';
require_once __DIR__ . '/ResultHeaders.php';
require_once __DIR__ . '/TransformRequest.php';
require_once __DIR__ . '/TransformResponse.php';

MusicbrainzUtility::setRegistrar(function (MusicbrainzUtility $u): void {
    $u->clean = [MusicbrainzClean::class, 'call'];
    $u->done = [MusicbrainzDone::class, 'call'];
    $u->make_error = [MusicbrainzMakeError::class, 'call'];
    $u->feature_add = [MusicbrainzFeatureAdd::class, 'call'];
    $u->feature_hook = [MusicbrainzFeatureHook::class, 'call'];
    $u->feature_init = [MusicbrainzFeatureInit::class, 'call'];
    $u->fetcher = [MusicbrainzFetcher::class, 'call'];
    $u->make_fetch_def = [MusicbrainzMakeFetchDef::class, 'call'];
    $u->make_context = [MusicbrainzMakeContext::class, 'call'];
    $u->make_options = [MusicbrainzMakeOptions::class, 'call'];
    $u->make_request = [MusicbrainzMakeRequest::class, 'call'];
    $u->make_response = [MusicbrainzMakeResponse::class, 'call'];
    $u->make_result = [MusicbrainzMakeResult::class, 'call'];
    $u->make_point = [MusicbrainzMakePoint::class, 'call'];
    $u->make_spec = [MusicbrainzMakeSpec::class, 'call'];
    $u->make_url = [MusicbrainzMakeUrl::class, 'call'];
    $u->param = [MusicbrainzParam::class, 'call'];
    $u->prepare_auth = [MusicbrainzPrepareAuth::class, 'call'];
    $u->prepare_body = [MusicbrainzPrepareBody::class, 'call'];
    $u->prepare_headers = [MusicbrainzPrepareHeaders::class, 'call'];
    $u->prepare_method = [MusicbrainzPrepareMethod::class, 'call'];
    $u->prepare_params = [MusicbrainzPrepareParams::class, 'call'];
    $u->prepare_path = [MusicbrainzPreparePath::class, 'call'];
    $u->prepare_query = [MusicbrainzPrepareQuery::class, 'call'];
    $u->result_basic = [MusicbrainzResultBasic::class, 'call'];
    $u->result_body = [MusicbrainzResultBody::class, 'call'];
    $u->result_headers = [MusicbrainzResultHeaders::class, 'call'];
    $u->transform_request = [MusicbrainzTransformRequest::class, 'call'];
    $u->transform_response = [MusicbrainzTransformResponse::class, 'call'];
});
