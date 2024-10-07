// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/response/get_config_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetConfigInfoResponse _$GetConfigInfoResponseFromJson(
        Map<String, dynamic> json) =>
    GetConfigInfoResponse(
      news: (json['news'] as List<dynamic>)
          .map((e) => ConfigInfoEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetConfigInfoResponseToJson(
        GetConfigInfoResponse instance) =>
    <String, dynamic>{
      'news': instance.news,
    };
