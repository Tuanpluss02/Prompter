// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../data/models/response/profile_response/get_balance_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileBalanceResponse _$GetProfileBalanceResponseFromJson(
        Map<String, dynamic> json) =>
    GetProfileBalanceResponse(
      balance: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$GetProfileBalanceResponseToJson(
        GetProfileBalanceResponse instance) =>
    <String, dynamic>{
      'total': instance.balance,
    };
