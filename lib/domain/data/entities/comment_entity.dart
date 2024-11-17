// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/domain/data/entities/comment_entity.freezed.dart';
part '../../../generated/domain/data/entities/comment_entity.g.dart';

@Freezed(fromJson: true, toJson: true)
class CommentEntity with _$CommentEntity {
  @JsonSerializable()
  const factory CommentEntity({
    @Default('') String? id,
    @Default('') String? userId,
    @Default(<String>[]) List<String>? images,
    @Default(0) int? likeCount,
    @Default('') String? content,
    @Default('') String? createdAt,
  }) = _CommentEntity;

  factory CommentEntity.fromJson(Map<String, dynamic> json) => _$CommentEntityFromJson(json);
}
