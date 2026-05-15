# Musicbrainz SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

MusicbrainzUtility.registrar = ->(u) {
  u.clean = MusicbrainzUtilities::Clean
  u.done = MusicbrainzUtilities::Done
  u.make_error = MusicbrainzUtilities::MakeError
  u.feature_add = MusicbrainzUtilities::FeatureAdd
  u.feature_hook = MusicbrainzUtilities::FeatureHook
  u.feature_init = MusicbrainzUtilities::FeatureInit
  u.fetcher = MusicbrainzUtilities::Fetcher
  u.make_fetch_def = MusicbrainzUtilities::MakeFetchDef
  u.make_context = MusicbrainzUtilities::MakeContext
  u.make_options = MusicbrainzUtilities::MakeOptions
  u.make_request = MusicbrainzUtilities::MakeRequest
  u.make_response = MusicbrainzUtilities::MakeResponse
  u.make_result = MusicbrainzUtilities::MakeResult
  u.make_point = MusicbrainzUtilities::MakePoint
  u.make_spec = MusicbrainzUtilities::MakeSpec
  u.make_url = MusicbrainzUtilities::MakeUrl
  u.param = MusicbrainzUtilities::Param
  u.prepare_auth = MusicbrainzUtilities::PrepareAuth
  u.prepare_body = MusicbrainzUtilities::PrepareBody
  u.prepare_headers = MusicbrainzUtilities::PrepareHeaders
  u.prepare_method = MusicbrainzUtilities::PrepareMethod
  u.prepare_params = MusicbrainzUtilities::PrepareParams
  u.prepare_path = MusicbrainzUtilities::PreparePath
  u.prepare_query = MusicbrainzUtilities::PrepareQuery
  u.result_basic = MusicbrainzUtilities::ResultBasic
  u.result_body = MusicbrainzUtilities::ResultBody
  u.result_headers = MusicbrainzUtilities::ResultHeaders
  u.transform_request = MusicbrainzUtilities::TransformRequest
  u.transform_response = MusicbrainzUtilities::TransformResponse
}
