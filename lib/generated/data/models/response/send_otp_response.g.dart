// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/response/send_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendOtpResponse _$SendOtpResponseFromJson(Map<String, dynamic> json) =>
    SendOtpResponse(
      countOtp: (json['count_otp'] as num?)?.toInt(),
      timeCurrentSendOtp: (json['time_current_send_otp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SendOtpResponseToJson(SendOtpResponse instance) =>
    <String, dynamic>{
      'count_otp': instance.countOtp,
      'time_current_send_otp': instance.timeCurrentSendOtp,
    };
