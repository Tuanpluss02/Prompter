import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/data/entities/banner_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BannerEntity {
  final int? type;
  final String? title;
  final int? postRef;
  final int? refType;
  final String? image;
  final int? position;
  final String? publishDate;
  final String? urlRef;

  BannerEntity({
    this.type,
    this.title,
    this.postRef,
    this.refType,
    this.image,
    this.position,
    this.publishDate,
    this.urlRef,
  });
  Map<String, dynamic> toJson() => _$BannerEntityToJson(this);

  factory BannerEntity.fromJson(Map<String, dynamic> json) => _$BannerEntityFromJson(json);
}
