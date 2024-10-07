// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/register_pin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterPinRequest _$RegisterPinRequestFromJson(Map<String, dynamic> json) =>
    RegisterPinRequest(
      pin: json['pin'] as String?,
      action: (json['action'] as num?)?.toInt(),
      pinConfirm: json['pin_confirm'] as String?,
    );

Map<String, dynamic> _$RegisterPinRequestToJson(RegisterPinRequest instance) =>
    <String, dynamic>{
      'pin': instance.pin,
      'action': instance.action,
      'pin_confirm': instance.pinConfirm,
    };
