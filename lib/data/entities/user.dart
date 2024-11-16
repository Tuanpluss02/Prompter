// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/data/entities/user.freezed.dart';
part '../../generated/data/entities/user.g.dart';

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

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'displayName': displayName,
        'username': username,
        'email': email,
        'profileImage': profileImage,
        'bio': bio,
        'followers': followers,
        'following': following,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'postCount': postCount,
        'likeCount': likeCount,
      };
}
