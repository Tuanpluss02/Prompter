import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/data/entities/history_transaction_entity.g.dart';

@JsonSerializable()
class HistoryTransactionEntity {
  final int? totalRecords;
  final List<HistoryTransactionEntity>? segs;

  HistoryTransactionEntity({
    this.totalRecords,
    this.segs,
  });

  Map<String, dynamic> toJson() => _$HistoryTransactionEntityToJson(this);

  factory HistoryTransactionEntity.fromJson(Map<String, dynamic> json) => _$HistoryTransactionEntityFromJson(json);
}
