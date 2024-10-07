// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../data/models/response/trade/get_investment_information_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInvestmentInformationResponse _$GetInvestmentInformationResponseFromJson(
        Map<String, dynamic> json) =>
    GetInvestmentInformationResponse(
      pool: (json['pool'] as num?)?.toInt(),
      accumulated: (json['accumulated'] as num?)?.toInt(),
      numOfTrans: (json['numOfTrans'] as num?)?.toInt(),
      term: (json['term'] as num?)?.toInt(),
      minAmount: (json['minAmount'] as num?)?.toInt(),
      minProfit: json['minProfit'],
      startDay: json['startDay'] as String?,
      endDay: json['endDay'] as String?,
      nextPayDay: json['nextPayDay'],
      numOfInvestors: (json['numOfInvestors'] as num?)?.toInt(),
      paidProfit: json['paidProfit'] as String?,
      categoryProfit: json['categoryProfit'] as String?,
      invBasket: (json['invBasket'] as List<dynamic>?)
          ?.map((e) => InvBasket.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowBeforeTerm: (json['allowBeforeTerm'] as num?)?.toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$GetInvestmentInformationResponseToJson(
        GetInvestmentInformationResponse instance) =>
    <String, dynamic>{
      'pool': instance.pool,
      'accumulated': instance.accumulated,
      'numOfTrans': instance.numOfTrans,
      'term': instance.term,
      'minAmount': instance.minAmount,
      'minProfit': instance.minProfit,
      'startDay': instance.startDay,
      'endDay': instance.endDay,
      'nextPayDay': instance.nextPayDay,
      'numOfInvestors': instance.numOfInvestors,
      'paidProfit': instance.paidProfit,
      'categoryProfit': instance.categoryProfit,
      'notes': instance.notes,
      'allowBeforeTerm': instance.allowBeforeTerm,
      'invBasket': instance.invBasket?.map((e) => e.toJson()).toList(),
    };

InvBasket _$InvBasketFromJson(Map<String, dynamic> json) => InvBasket(
      val: json['val'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$InvBasketToJson(InvBasket instance) => <String, dynamic>{
      'val': instance.val,
      'description': instance.description,
    };
