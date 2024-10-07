// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/response/discover_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscoverResponse _$DiscoverResponseFromJson(Map<String, dynamic> json) =>
    DiscoverResponse(
      hotNews: json['hot_news'] == null
          ? null
          : NewsEntity.fromJson(json['hot_news'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Categories.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DiscoverResponseToJson(DiscoverResponse instance) =>
    <String, dynamic>{
      'hot_news': instance.hotNews,
      'categories': instance.categories,
    };

Categories _$CategoriesFromJson(Map<String, dynamic> json) => Categories(
      news: (json['news'] as List<dynamic>?)
          ?.map((e) => NewsEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      cateVal: json['cate_val'] as String?,
      cateName: json['cate_name'] as String?,
    );

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'news': instance.news,
      'cate_val': instance.cateVal,
      'cate_name': instance.cateName,
    };
