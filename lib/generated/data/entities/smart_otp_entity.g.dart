// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/entities/smart_otp_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartOtpEntity _$SmartOtpEntityFromJson(Map<String, dynamic> json) =>
    SmartOtpEntity(
      secretKey: json['secret_key'] as String?,
      smartOtpStatus: json['smart_otp_status'] as bool?,
    );

Map<String, dynamic> _$SmartOtpEntityToJson(SmartOtpEntity instance) =>
    <String, dynamic>{
      'secret_key': instance.secretKey,
      'smart_otp_status': instance.smartOtpStatus,
    };
