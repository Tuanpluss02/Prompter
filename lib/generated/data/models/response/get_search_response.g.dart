// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/response/get_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSearchResponse _$GetSearchResponseFromJson(Map<String, dynamic> json) =>
    GetSearchResponse(
      recentSearchs: (json['recentSearchs'] as List<dynamic>)
          .map((e) => SearchEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSearchResponseToJson(GetSearchResponse instance) =>
    <String, dynamic>{
      'recentSearchs': instance.recentSearchs,
    };
