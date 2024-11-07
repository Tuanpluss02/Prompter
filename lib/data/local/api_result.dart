import 'package:base/data/responses/base_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'network_exceptions.dart';

part '../../generated/data/local/api_result.freezed.dart';

@freezed
abstract class ApiResult with _$ApiResult {
  const factory ApiResult.apiSuccess(BaseResponse data) = Success;

  const factory ApiResult.apiFailure(NetworkExceptions error) = Failure;
}
