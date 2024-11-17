// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/domain/data/entities/post_entity.freezed.dart';
part '../../../generated/domain/data/entities/post_entity.g.dart';

@Freezed(fromJson: true, toJson: true)
class PostEntity with _$PostEntity {
  @JsonSerializable()
  const factory PostEntity({
    @Default('') String? id,
    @Default('') String? authorId,
    @Default(<String>[]) List<String>? images,
    @Default(<String>[]) List<String>? comments,
    @Default(<String>[]) List<String>? likes,
    @Default('') String? content,
    @Default(null) DateTime? createdAt,
  }) = _PostEntity;

  factory PostEntity.fromJson(Map<String, dynamic> json) => _$PostEntityFromJson(json);
}
