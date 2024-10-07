// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/verify_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyOtpRequest _$VerifyOtpRequestFromJson(Map<String, dynamic> json) =>
    VerifyOtpRequest(
      username: json['username'] as String,
      otp: json['otp'] as String,
      usernameType: (json['username_type'] as num).toInt(),
      otpType: (json['otp_type'] as num).toInt(),
    );

Map<String, dynamic> _$VerifyOtpRequestToJson(VerifyOtpRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'otp': instance.otp,
      'username_type': instance.usernameType,
      'otp_type': instance.otpType,
    };
