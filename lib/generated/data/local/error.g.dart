// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/local/error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorModel _$ErrorModelFromJson(Map<String, dynamic> json) => ErrorModel(
      (json['code'] as num).toInt(),
      json['message'] as String,
      (json['status_code'] as num).toInt(),
      json['status_message'] as String,
      json['success'] as bool,
    );

Map<String, dynamic> _$ErrorModelToJson(ErrorModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'status_code': instance.statusCode,
      'status_message': instance.statusMessage,
      'success': instance.success,
    };
