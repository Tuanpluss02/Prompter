// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/response/ekyc_liveness_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EkycLIVENESSResponse _$EkycLIVENESSResponseFromJson(
        Map<String, dynamic> json) =>
    EkycLIVENESSResponse(
      response: json['response'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$EkycLIVENESSResponseToJson(
        EkycLIVENESSResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'image': instance.image,
    };

ScanFaceResponse _$ScanFaceResponseFromJson(Map<String, dynamic> json) =>
    ScanFaceResponse(
      activityID: json['activityID'] as String?,
      data: json['data'] == null
          ? null
          : ScanFaceData.fromJson(json['data'] as Map<String, dynamic>),
      exitCode: (json['exitCode'] as num?)?.toInt(),
      exitCodeMessage: json['exitCodeMessage'] as String?,
      message: json['message'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ScanFaceResponseToJson(ScanFaceResponse instance) =>
    <String, dynamic>{
      'activityID': instance.activityID,
      'data': instance.data,
      'exitCode': instance.exitCode,
      'exitCodeMessage': instance.exitCodeMessage,
      'message': instance.message,
      'status': instance.status,
    };

ScanFaceData _$ScanFaceDataFromJson(Map<String, dynamic> json) => ScanFaceData(
      matchingScore: (json['matchingScore'] as num?)?.toInt(),
      isMatch: json['isMatch'] as String?,
    );

Map<String, dynamic> _$ScanFaceDataToJson(ScanFaceData instance) =>
    <String, dynamic>{
      'matchingScore': instance.matchingScore,
      'isMatch': instance.isMatch,
    };

LIVENESSErrorContent _$LIVENESSErrorContentFromJson(
        Map<String, dynamic> json) =>
    LIVENESSErrorContent(
      activityID: json['activityID'] as String?,
      data: json['data'] == null
          ? null
          : ScanFaceData.fromJson(json['data'] as Map<String, dynamic>),
      exitCode: (json['exitCode'] as num?)?.toInt(),
      exitCodeMessage: json['exitCodeMessage'] as String?,
      message: json['message'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LIVENESSErrorContentToJson(
        LIVENESSErrorContent instance) =>
    <String, dynamic>{
      'activityID': instance.activityID,
      'data': instance.data,
      'exitCode': instance.exitCode,
      'exitCodeMessage': instance.exitCodeMessage,
      'message': instance.message,
      'status': instance.status,
    };
