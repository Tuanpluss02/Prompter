// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/data/entities/user_entity.freezed.dart';
part '../../generated/data/entities/user_entity.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory User({
    // 1: Nam, 2: Nữ
    @Default(0) int? gender,
    @Default('') String? nationality,
    @Default('') String? phone,
    @Default('') String? email,
    // 0: khoi tao, 1: f1 dang xu ly, 2: duoc f1 phe duyet, 3: duoc mxv phe duyet
    @Default(0) int? status,
    @Default('') String? avatar,
    @Default('') String? nickname,
    @Default('') String? fullName,
    @Default('') String? dob,
    @Default('') String? citizenId,
    @Default('') String? dateOfIssue,
    @Default('') String? dateOfExpire,
    @Default('') String? issueAt,
    @Default('') String? addressResident,
    @Default('') String? brokerCode,
    @Default('') String? referralCode,
    @Default('') String? homeTown,
    @Default(0) int? balance,
    @Default(false) bool? hasEcontract,
    @Default('') String? mxvAccount,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
