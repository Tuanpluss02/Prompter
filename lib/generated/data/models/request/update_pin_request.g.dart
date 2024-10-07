// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/update_pin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePinRequest _$UpdatePinRequestFromJson(Map<String, dynamic> json) =>
    UpdatePinRequest(
      action: $enumDecodeNullable(_$ConfigActionEnumMap, json['action']),
      currentPin: json['current_pin'] as String?,
      newPin: json['new_pin'] as String?,
      confirmPin: json['confirm_pin'] as String?,
    );

Map<String, dynamic> _$UpdatePinRequestToJson(UpdatePinRequest instance) =>
    <String, dynamic>{
      'action': _$ConfigActionEnumMap[instance.action],
      'current_pin': instance.currentPin,
      'new_pin': instance.newPin,
      'confirm_pin': instance.confirmPin,
    };

const _$ConfigActionEnumMap = {
  ConfigAction.updatePin: 0,
  ConfigAction.verifyPin: 1,
};
