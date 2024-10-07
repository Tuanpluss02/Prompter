// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/verify_pin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyPinRequest _$VerifyPinRequestFromJson(Map<String, dynamic> json) =>
    VerifyPinRequest(
      pin: json['pin'] as String?,
      pinConfirm: json['pin_confirm'] as String?,
    );

Map<String, dynamic> _$VerifyPinRequestToJson(VerifyPinRequest instance) =>
    <String, dynamic>{
      'pin': instance.pin,
      'pin_confirm': instance.pinConfirm,
    };
