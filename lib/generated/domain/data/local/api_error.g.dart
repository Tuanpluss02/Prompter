// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../domain/data/local/api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) => ApiError(
      (json['code'] as num).toInt(),
      json['message'] as String,
      (json['status_code'] as num).toInt(),
      json['status_message'] as String,
      json['success'] as bool,
    );

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status_code': instance.statusCode,
      'status_message': instance.statusMessage,
      'success': instance.success,
    };
