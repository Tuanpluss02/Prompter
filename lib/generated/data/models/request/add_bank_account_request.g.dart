// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/add_bank_account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddBankAccountRequest _$AddBankAccountRequestFromJson(
        Map<String, dynamic> json) =>
    AddBankAccountRequest(
      accNo: json['acc_no'] as String?,
      bankId: json['bank_id'] as String?,
    );

Map<String, dynamic> _$AddBankAccountRequestToJson(
        AddBankAccountRequest instance) =>
    <String, dynamic>{
      'acc_no': instance.accNo,
      'bank_id': instance.bankId,
    };
