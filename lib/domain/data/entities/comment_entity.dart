// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/domain/data/entities/comment_entity.freezed.dart';
part '../../../generated/domain/data/entities/comment_entity.g.dart';

@Freezed(fromJson: true, toJson: true, makeCollectionsUnmodifiable: false)
class CommentEntity with _$CommentEntity {
  @JsonSerializable()
  const factory CommentEntity({
    @Default('') String? id,
    @Default('') String? authorId,
    @Default(<String>[]) List<String>? images,
    @Default(<String>[]) List<String>? likes,
    @Default('') String? content,
    @Default(null) DateTime? createdAt,
  }) = _CommentEntity;

  factory CommentEntity.fromJson(Map<String, dynamic> json) => _$CommentEntityFromJson(json);
}
