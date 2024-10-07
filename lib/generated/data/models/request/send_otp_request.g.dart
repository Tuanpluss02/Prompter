// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/send_otp_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpRequest _$SendOtpRequestFromJson(Map<String, dynamic> json) =>
    SendOtpRequest(
      username: json['username'] as String,
      type: (json['type_login'] as num).toInt(),
    );

Map<String, dynamic> _$SendOtpRequestToJson(SendOtpRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'type_login': instance.type,
    };
