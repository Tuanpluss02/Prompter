// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/search_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRequest _$SearchRequestFromJson(Map<String, dynamic> json) =>
    SearchRequest(
      keyword: json['keyword'] as String?,
      grp_id: json['grp_id'] as String?,
      page_index: (json['page_index'] as num?)?.toInt(),
      page_size: (json['page_size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchRequestToJson(SearchRequest instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'grp_id': instance.grp_id,
      'page_index': instance.page_index,
      'page_size': instance.page_size,
    };
