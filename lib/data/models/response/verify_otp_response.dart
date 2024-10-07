import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/data/models/response/verify_otp_response.g.dart';

@JsonSerializable()
class VerifyOtpResponse {
  String? token;

  VerifyOtpResponse({
    this.token,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);
}
