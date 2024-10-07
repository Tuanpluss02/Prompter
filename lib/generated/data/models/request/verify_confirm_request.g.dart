// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/verify_confirm_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyConfirmRequest _$VerifyConfirmRequestFromJson(
        Map<String, dynamic> json) =>
    VerifyConfirmRequest(
      otp: json['otp'] as String?,
      username: json['username'] as String?,
      configAction:
          $enumDecodeNullable(_$ConfigActionEnumMap, json['config_action']),
      timeGenerator: (json['time_generator'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VerifyConfirmRequestToJson(
        VerifyConfirmRequest instance) =>
    <String, dynamic>{
      'otp': instance.otp,
      'username': instance.username,
      'config_action': _$ConfigActionEnumMap[instance.configAction],
      'time_generator': instance.timeGenerator,
    };

const _$ConfigActionEnumMap = {
  ConfigAction.verifyPin: 1,
  ConfigAction.verifyEmail: 2,
  ConfigAction.verifySmartOtp: 3,
  ConfigAction.cancelOTP: 4,
  ConfigAction.forgotOTP: 5,
  ConfigAction.verifyOTPTrade: 6,
  ConfigAction.verifyOTPFaceId: 7,
};
