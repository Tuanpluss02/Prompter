// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/entities/config_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfigInfoEntity _$ConfigInfoEntityFromJson(Map<String, dynamic> json) =>
    ConfigInfoEntity(
      methodSecure: json['method_secure'] as String?,
      smartOtpStatus: json['smart_otp_status'] as bool?,
      emailOtpStatus: json['email_otp_status'] as bool?,
      email: json['email'] as String?,
      pinStatus: json['pin_status'] as bool?,
    )..faceIdStatus = json['face_id_status'] as bool?;

Map<String, dynamic> _$ConfigInfoEntityToJson(ConfigInfoEntity instance) =>
    <String, dynamic>{
      'method_secure': instance.methodSecure,
      'smart_otp_status': instance.smartOtpStatus,
      'email_otp_status': instance.emailOtpStatus,
      'email': instance.email,
      'pin_status': instance.pinStatus,
      'face_id_status': instance.faceIdStatus,
    };
