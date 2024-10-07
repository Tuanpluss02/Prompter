// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/response/ekyc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EkycResponse _$EkycResponseFromJson(Map<String, dynamic> json) => EkycResponse(
      response: json['response'] as String?,
      frontImage: json['front_image'] as String?,
      backImage: json['back_image'] as String?,
      error: json['error'] == null
          ? null
          : EkycError.fromJson(json['error'] as Map<String, dynamic>),
    )..images =
        (json['images'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$EkycResponseToJson(EkycResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'front_image': instance.frontImage,
      'back_image': instance.backImage,
      'error': instance.error,
      'images': instance.images,
    };

EkycError _$EkycErrorFromJson(Map<String, dynamic> json) => EkycError(
      type: json['type'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$EkycErrorToJson(EkycError instance) => <String, dynamic>{
      'type': instance.type,
      'content': instance.content,
    };
