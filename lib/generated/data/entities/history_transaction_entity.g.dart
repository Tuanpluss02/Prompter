// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/entities/history_transaction_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryTransactionEntity _$HistoryTransactionEntityFromJson(
        Map<String, dynamic> json) =>
    HistoryTransactionEntity(
      totalRecords: (json['totalRecords'] as num?)?.toInt(),
      segs: (json['segs'] as List<dynamic>?)
          ?.map((e) =>
              HistoryTransactionEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoryTransactionEntityToJson(
        HistoryTransactionEntity instance) =>
    <String, dynamic>{
      'totalRecords': instance.totalRecords,
      'segs': instance.segs,
    };
