// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/response/get_home_banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetHomeBannerResponse _$GetHomeBannerResponseFromJson(
        Map<String, dynamic> json) =>
    GetHomeBannerResponse(
      banners: (json['banners'] as List<dynamic>)
          .map((e) => BannerResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetHomeBannerResponseToJson(
        GetHomeBannerResponse instance) =>
    <String, dynamic>{
      'banners': instance.banners,
    };

BannerResponse _$BannerResponseFromJson(Map<String, dynamic> json) =>
    BannerResponse(
      type: (json['type'] as num).toInt(),
      banners: (json['banners'] as List<dynamic>)
          .map((e) => BannerEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      typeName: json['type_name'] as String,
    );

Map<String, dynamic> _$BannerResponseToJson(BannerResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'banners': instance.banners,
      'type_name': instance.typeName,
    };
