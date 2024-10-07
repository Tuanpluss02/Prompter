// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/request/update_ekyc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateEkycRequest _$UpdateEkycRequestFromJson(Map<String, dynamic> json) =>
    UpdateEkycRequest(
      gender: json['gender'] as String?,
      fullName: json['full_name'] as String?,
      citizenId: json['citizen_id'] as String?,
      issueAt: json['issue_at'] as String?,
      dateOfIssue: json['date_of_issue'] as String?,
      dob: json['dob'] as String?,
      nationality: json['nationality'] as String?,
      addressResident: json['address_resident'] as String?,
      homeTown: json['home_town'] as String?,
      expiredDate: json['expired_date'] as String?,
      cccdFPath: json['cccd_f_path'] as String?,
      cccdBPath: json['cccd_b_path'] as String?,
    );

Map<String, dynamic> _$UpdateEkycRequestToJson(UpdateEkycRequest instance) =>
    <String, dynamic>{
      'gender': instance.gender,
      'full_name': instance.fullName,
      'citizen_id': instance.citizenId,
      'issue_at': instance.issueAt,
      'date_of_issue': instance.dateOfIssue,
      'dob': instance.dob,
      'nationality': instance.nationality,
      'address_resident': instance.addressResident,
      'home_town': instance.homeTown,
      'expired_date': instance.expiredDate,
      'cccd_f_path': instance.cccdFPath,
      'cccd_b_path': instance.cccdBPath,
    };
