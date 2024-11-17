import 'package:json_annotation/json_annotation.dart';

part '../../../generated/domain/data/responses/base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "msg")
  final String? msg;
  @JsonKey(name: "data")
  final dynamic data;

  BaseResponse({
    this.code,
    this.msg,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
