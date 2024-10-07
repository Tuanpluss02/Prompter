// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/data/entities/search_entity.g.dart';

@JsonSerializable()
class SearchEntity {
  final String? code;
  final String? name;
  final int? price;
  final int? price_usd;
  final int? price_difference;
  final List<int>? prices;

  SearchEntity({
    this.code,
    this.name,
    this.price,
    this.price_usd,
    this.price_difference,
    this.prices,
  });

  Map<String, dynamic> toJson() => _$SearchEntityToJson(this);

  factory SearchEntity.fromJson(Map<String, dynamic> json) => _$SearchEntityFromJson(json);
}
