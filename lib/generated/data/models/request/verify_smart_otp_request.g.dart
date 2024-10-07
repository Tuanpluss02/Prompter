// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/verify_smart_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifySmartOtpRequest _$VerifySmartOtpRequestFromJson(
        Map<String, dynamic> json) =>
    VerifySmartOtpRequest(
      otp: json['otp'] as String?,
      timeGeneration: (json['time_generation'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VerifySmartOtpRequestToJson(
        VerifySmartOtpRequest instance) =>
    <String, dynamic>{
      'otp': instance.otp,
      'time_generation': instance.timeGeneration,
    };
