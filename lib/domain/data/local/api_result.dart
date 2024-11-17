import 'package:base/domain/data/responses/base_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'network_exceptions.dart';

part '../../../generated/domain/data/local/api_result.freezed.dart';

@freezed
abstract class ApiResult with _$ApiResult {
  const factory ApiResult.success(BaseResponse data) = Success;
  const factory ApiResult.successWWithCustomResponse(dynamic data) = SuccessResponse;

  const factory ApiResult.failure(NetworkExceptions error) = Failure;
}
