// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/news_by_category_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsByCategoryRequest _$NewsByCategoryRequestFromJson(
        Map<String, dynamic> json) =>
    NewsByCategoryRequest(
      val: json['val'] as String,
      pageIndex: (json['pageIndex'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
    );

Map<String, dynamic> _$NewsByCategoryRequestToJson(
        NewsByCategoryRequest instance) =>
    <String, dynamic>{
      'val': instance.val,
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
    };
