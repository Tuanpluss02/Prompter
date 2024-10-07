// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/change_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordRequest _$ChangePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordRequest(
      step: (json['step'] as num).toInt(),
      oldPassword: json['old_password'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$ChangePasswordRequestToJson(
        ChangePasswordRequest instance) =>
    <String, dynamic>{
      'step': instance.step,
      'old_password': instance.oldPassword,
      'password': instance.password,
    };
