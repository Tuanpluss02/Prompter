// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../data/models/response/trade/get_investment_pack_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInvestmentPackResponse _$GetInvestmentPackResponseFromJson(
        Map<String, dynamic> json) =>
    GetInvestmentPackResponse(
      cd: json['cd'] as String,
      listCate: (json['list_cate'] as List<dynamic>)
          .map((e) => ListCate.fromJson(e as Map<String, dynamic>))
          .toList(),
      productId: (json['product_id'] as num).toInt(),
    );

Map<String, dynamic> _$GetInvestmentPackResponseToJson(
        GetInvestmentPackResponse instance) =>
    <String, dynamic>{
      'cd': instance.cd,
      'list_cate': instance.listCate.map((e) => e.toJson()).toList(),
      'product_id': instance.productId,
    };

ListCate _$ListCateFromJson(Map<String, dynamic> json) => ListCate(
      name: json['name'] as String,
      val: json['val'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$ListCateToJson(ListCate instance) => <String, dynamic>{
      'name': instance.name,
      'val': instance.val,
      'description': instance.description,
    };
