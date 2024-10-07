// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/register_email_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterEmailOTPRequest _$RegisterEmailOTPRequestFromJson(
        Map<String, dynamic> json) =>
    RegisterEmailOTPRequest(
      email: json['email'] as String?,
      actionConfig: (json['action_config'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RegisterEmailOTPRequestToJson(
        RegisterEmailOTPRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'action_config': instance.actionConfig,
    };
