// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/entities/banner_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerEntity _$BannerEntityFromJson(Map<String, dynamic> json) => BannerEntity(
      type: (json['type'] as num?)?.toInt(),
      title: json['title'] as String?,
      postRef: (json['post_ref'] as num?)?.toInt(),
      refType: (json['ref_type'] as num?)?.toInt(),
      image: json['image'] as String?,
      position: (json['position'] as num?)?.toInt(),
      publishDate: json['publish_date'] as String?,
      urlRef: json['url_ref'] as String?,
    );

Map<String, dynamic> _$BannerEntityToJson(BannerEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'title': instance.title,
      'post_ref': instance.postRef,
      'ref_type': instance.refType,
      'image': instance.image,
      'position': instance.position,
      'publish_date': instance.publishDate,
      'url_ref': instance.urlRef,
    };
