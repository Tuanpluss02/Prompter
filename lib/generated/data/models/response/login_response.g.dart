// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/response/login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginVerifyUsernameResponse _$LoginVerifyUsernameResponseFromJson(
        Map<String, dynamic> json) =>
    LoginVerifyUsernameResponse(
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      fullname: json['full_name'] as String?,
    );

Map<String, dynamic> _$LoginVerifyUsernameResponseToJson(
        LoginVerifyUsernameResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
      'avatar': instance.avatar,
      'full_name': instance.fullname,
    };

LoginResponseSuccess _$LoginResponseSuccessFromJson(
        Map<String, dynamic> json) =>
    LoginResponseSuccess(
      refreshToken: json['refreshToken'] as String?,
      type: json['type'] as String?,
      id: json['id'] as String?,
      username: json['username'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      expireddate: json['expireddate'] as String?,
      mxvAccount: json['mxvAccount'] as String?,
      accessToken: json['accessToken'] as String?,
    );

Map<String, dynamic> _$LoginResponseSuccessToJson(
        LoginResponseSuccess instance) =>
    <String, dynamic>{
      'refreshToken': instance.refreshToken,
      'type': instance.type,
      'id': instance.id,
      'username': instance.username,
      'roles': instance.roles,
      'expireddate': instance.expireddate,
      'mxvAccount': instance.mxvAccount,
      'accessToken': instance.accessToken,
    };

LoginResponseError _$LoginResponseErrorFromJson(Map<String, dynamic> json) =>
    LoginResponseError(
      expiredTime: (json['expired_time'] as num?)?.toInt(),
      countError: (json['count_error'] as num?)?.toInt(),
      alert: json['alert'] as String?,
    );

Map<String, dynamic> _$LoginResponseErrorToJson(LoginResponseError instance) =>
    <String, dynamic>{
      'expired_time': instance.expiredTime,
      'count_error': instance.countError,
      'alert': instance.alert,
    };
