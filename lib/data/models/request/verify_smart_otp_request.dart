import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/data/models/request/verify_smart_otp_request.g.dart';

@JsonSerializable()
class VerifySmartOtpRequest {
  final String? otp;
  @JsonKey(name: 'time_generation')
  final int? timeGeneration;

  VerifySmartOtpRequest({
    this.otp,
    this.timeGeneration,
  });

  Map<String, dynamic> toJson() => _$VerifySmartOtpRequestToJson(this);
}
