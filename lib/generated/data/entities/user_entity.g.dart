// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../data/entities/user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      gender: (json['gender'] as num?)?.toInt() ?? 0,
      nationality: json['nationality'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      status: (json['status'] as num?)?.toInt() ?? 0,
      avatar: json['avatar'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      fullName: json['full_name'] as String? ?? '',
      dob: json['dob'] as String? ?? '',
      citizenId: json['citizen_id'] as String? ?? '',
      dateOfIssue: json['date_of_issue'] as String? ?? '',
      dateOfExpire: json['date_of_expire'] as String? ?? '',
      issueAt: json['issue_at'] as String? ?? '',
      addressResident: json['address_resident'] as String? ?? '',
      brokerCode: json['broker_code'] as String? ?? '',
      referralCode: json['referral_code'] as String? ?? '',
      homeTown: json['home_town'] as String? ?? '',
      balance: (json['balance'] as num?)?.toInt() ?? 0,
      hasEcontract: json['has_econtract'] as bool? ?? false,
      mxvAccount: json['mxv_account'] as String? ?? '',
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'nationality': instance.nationality,
      'phone': instance.phone,
      'email': instance.email,
      'status': instance.status,
      'avatar': instance.avatar,
      'nickname': instance.nickname,
      'full_name': instance.fullName,
      'dob': instance.dob,
      'citizen_id': instance.citizenId,
      'date_of_issue': instance.dateOfIssue,
      'date_of_expire': instance.dateOfExpire,
      'issue_at': instance.issueAt,
      'address_resident': instance.addressResident,
      'broker_code': instance.brokerCode,
      'referral_code': instance.referralCode,
      'home_town': instance.homeTown,
      'balance': instance.balance,
      'has_econtract': instance.hasEcontract,
      'mxv_account': instance.mxvAccount,
    };
