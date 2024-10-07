// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/response/transaction_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionHistoryResponse _$TransactionHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionHistoryResponse(
      totalRecords: (json['totalRecords'] as num?)?.toInt(),
      totalAmount: (json['totalAmount'] as num?)?.toInt(),
      segs: (json['segs'] as List<dynamic>?)
          ?.map((e) => Seg.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionHistoryResponseToJson(
        TransactionHistoryResponse instance) =>
    <String, dynamic>{
      'totalRecords': instance.totalRecords,
      'totalAmount': instance.totalAmount,
      'segs': instance.segs,
    };

Seg _$SegFromJson(Map<String, dynamic> json) => Seg(
      month: json['month'] as String?,
      trans: (json['trans'] as List<dynamic>?)
          ?.map((e) => Tran.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SegToJson(Seg instance) => <String, dynamic>{
      'month': instance.month,
      'trans': instance.trans,
    };

Tran _$TranFromJson(Map<String, dynamic> json) => Tran(
      amount: (json['amount'] as num?)?.toInt(),
      status: json['status'] as String?,
      tranDate: json['tranDate'] as String?,
      cashType: json['cashType'] as String?,
    );

Map<String, dynamic> _$TranToJson(Tran instance) => <String, dynamic>{
      'amount': instance.amount,
      'status': instance.status,
      'tranDate': instance.tranDate,
      'cashType': instance.cashType,
    };
