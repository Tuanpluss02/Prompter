import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/data/entities/smart_otp_entity.g.dart';

@JsonSerializable()
class SmartOtpEntity {
  @JsonKey(name: 'secret_key')
  String? secretKey;
  @JsonKey(name: 'smart_otp_status')
  bool? smartOtpStatus;

  SmartOtpEntity({this.secretKey, this.smartOtpStatus});
  Map<String, dynamic> toJson() => _$SmartOtpEntityToJson(this);

  factory SmartOtpEntity.fromJson(Map<String, dynamic> json) => _$SmartOtpEntityFromJson(json);
}
