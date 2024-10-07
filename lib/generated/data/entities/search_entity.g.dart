// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/entities/search_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchEntity _$SearchEntityFromJson(Map<String, dynamic> json) => SearchEntity(
      code: json['code'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toInt(),
      price_usd: (json['price_usd'] as num?)?.toInt(),
      price_difference: (json['price_difference'] as num?)?.toInt(),
      prices: (json['prices'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$SearchEntityToJson(SearchEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'price': instance.price,
      'price_usd': instance.price_usd,
      'price_difference': instance.price_difference,
      'prices': instance.prices,
    };
