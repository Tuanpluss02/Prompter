import 'package:json_annotation/json_annotation.dart';

part '../../../generated/domain/data/local/api_error.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ApiError {
  int code;
  String message;
  int statusCode;
  String statusMessage;
  bool success;

  ApiError(this.code, this.message, this.statusCode, this.statusMessage, this.success);

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return _$ApiErrorFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}
