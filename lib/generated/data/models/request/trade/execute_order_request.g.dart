// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../data/models/request/trade/execute_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExecuteOrderRequest _$ExecuteOrderRequestFromJson(Map<String, dynamic> json) =>
    ExecuteOrderRequest(
      productId: (json['productId'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      intervalFlg: json['intervalFlg'] as String,
      intervalValue: json['intervalValue'] as String,
    );

Map<String, dynamic> _$ExecuteOrderRequestToJson(
        ExecuteOrderRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'amount': instance.amount,
      'intervalFlg': instance.intervalFlg,
      'intervalValue': instance.intervalValue,
    };
