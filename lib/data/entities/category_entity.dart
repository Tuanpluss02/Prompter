import 'package:json_annotation/json_annotation.dart';

part '../../generated/data/entities/category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {
  String? val;
  String? name;
  String? description;
  String? image;

  CategoryEntity({this.val, this.name, this.description, this.image});

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);

  factory CategoryEntity.fromJson(Map<String, dynamic> json) => _$CategoryEntityFromJson(json);
}
