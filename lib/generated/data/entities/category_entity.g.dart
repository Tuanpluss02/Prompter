// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/entities/category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEntity _$CategoryEntityFromJson(Map<String, dynamic> json) =>
    CategoryEntity(
      val: json['val'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$CategoryEntityToJson(CategoryEntity instance) =>
    <String, dynamic>{
      'val': instance.val,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
    };
