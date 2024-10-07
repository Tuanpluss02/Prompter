// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      username: json['username'] as String?,
      password: json['password'] as String?,
      type: (json['type'] as num?)?.toInt(),
      action: (json['action'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'type': instance.type,
      'action': instance.action,
    };
