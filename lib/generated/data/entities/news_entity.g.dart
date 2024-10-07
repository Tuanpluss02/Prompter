// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/entities/news_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsEntity _$NewsEntityFromJson(Map<String, dynamic> json) => NewsEntity(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      shortDesc: json['shortDesc'] as String?,
      content: json['content'] as String?,
      author: json['author'] as String?,
      thumbnail: json['thumbnail'] as String?,
      publishDate: json['publishDate'] as String?,
      isPublic: (json['isPublic'] as num?)?.toInt(),
      order: (json['order'] as num?)?.toInt(),
      cateId: (json['cateId'] as num?)?.toInt(),
      readCount: (json['readCount'] as num?)?.toInt(),
      reactCount: (json['reactCount'] as num?)?.toInt(),
      shareCount: (json['shareCount'] as num?)?.toInt(),
      slug: json['slug'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$NewsEntityToJson(NewsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'shortDesc': instance.shortDesc,
      'content': instance.content,
      'author': instance.author,
      'thumbnail': instance.thumbnail,
      'publishDate': instance.publishDate,
      'isPublic': instance.isPublic,
      'order': instance.order,
      'cateId': instance.cateId,
      'readCount': instance.readCount,
      'reactCount': instance.reactCount,
      'shareCount': instance.shareCount,
      'slug': instance.slug,
      'tags': instance.tags,
    };
