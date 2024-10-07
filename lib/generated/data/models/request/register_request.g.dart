// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      step: (json['step'] as num).toInt(),
      username: json['username'] as String,
      password: json['password'] as String?,
      type: (json['type'] as num).toInt(),
      fullName: json['full_name'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'step': instance.step,
      'username': instance.username,
      'password': instance.password,
      'type': instance.type,
      'full_name': instance.fullName,
    };
