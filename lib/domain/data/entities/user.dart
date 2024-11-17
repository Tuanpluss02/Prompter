// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/domain/data/entities/user.freezed.dart';
part '../../../generated/domain/data/entities/user.g.dart';

@Freezed(fromJson: true, toJson: true)
class UserEntity with _$UserEntity {
  @JsonSerializable()
  const factory UserEntity({
    @Default('') String? id,
    @Default('') String? displayName,
    @Default('') String? username,
    @Default('') String? email,
    @Default('') String? profileImage,
    @Default('') String? bio,
    @Default(<String>[]) List<String>? followers,
    @Default(<String>[]) List<String>? following,
    @Default('') String? createdAt,
    @Default('') String? updatedAt,
    @Default(0) int? postCount,
    @Default(0) int? likeCount,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
}
