// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/data/entities/user.freezed.dart';
part '../../generated/data/entities/user.g.dart';

@Freezed(fromJson: true, toJson: true)
@JsonSerializable()
class User with _$User {
  const factory User({
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
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  // Map<String, dynamic> toJson() => _$UserToJson(this);
}
