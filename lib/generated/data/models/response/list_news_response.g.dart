// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/response/list_news_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListNewsResponse _$ListNewsResponseFromJson(Map<String, dynamic> json) =>
    ListNewsResponse(
      contents: (json['contents'] as List<dynamic>)
          .map((e) => NewsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListNewsResponseToJson(ListNewsResponse instance) =>
    <String, dynamic>{
      'contents': instance.contents,
    };
