// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/search_news_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchNewsRequest _$SearchNewsRequestFromJson(Map<String, dynamic> json) =>
    SearchNewsRequest(
      keyword: json['keyword'] as String,
      pageIndex: (json['pageIndex'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
    );

Map<String, dynamic> _$SearchNewsRequestToJson(SearchNewsRequest instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
    };
