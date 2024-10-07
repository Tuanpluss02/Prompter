import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/data/entities/config_info_entity.g.dart';

@JsonSerializable()
class ConfigInfoEntity {
  @JsonKey(name: 'method_secure')
  String? methodSecure;
  @JsonKey(name: 'smart_otp_status')
  bool? smartOtpStatus;
  @JsonKey(name: 'email_otp_status')
  bool? emailOtpStatus;
  String? email;
  @JsonKey(name: 'pin_status')
  bool? pinStatus;
  @JsonKey(name: 'face_id_status')
  bool? faceIdStatus;

  ConfigInfoEntity({
    this.methodSecure,
    this.smartOtpStatus,
    this.emailOtpStatus,
    this.email,
    this.pinStatus,
  });
  Map<String, dynamic> toJson() => _$ConfigInfoEntityToJson(this);

  factory ConfigInfoEntity.fromJson(Map<String, dynamic> json) => _$ConfigInfoEntityFromJson(json);
}
