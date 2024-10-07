// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../data/models/response/ekyc_ocr_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EkycOCRResponse _$EkycOCRResponseFromJson(Map<String, dynamic> json) =>
    EkycOCRResponse(
      response: json['response'] as String?,
      frontImage: json['frontImage'] as String?,
      backImage: json['backImage'] as String?,
    );

Map<String, dynamic> _$EkycOCRResponseToJson(EkycOCRResponse instance) =>
    <String, dynamic>{
      'response': instance.response,
      'frontImage': instance.frontImage,
      'backImage': instance.backImage,
    };

CCCDResponse _$CCCDResponseFromJson(Map<String, dynamic> json) => CCCDResponse(
      activityID: json['activityID'] as String?,
      data: json['data'] == null
          ? null
          : CCCDData.fromJson(json['data'] as Map<String, dynamic>),
      exitCode: (json['exitCode'] as num?)?.toInt(),
      exitCodeMessage: json['exitCodeMessage'] as String?,
      message: json['message'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CCCDResponseToJson(CCCDResponse instance) =>
    <String, dynamic>{
      'activityID': instance.activityID,
      'data': instance.data,
      'exitCode': instance.exitCode,
      'exitCodeMessage': instance.exitCodeMessage,
      'message': instance.message,
      'status': instance.status,
    };

CCCDData _$CCCDDataFromJson(Map<String, dynamic> json) => CCCDData(
      address: json['address'] as String?,
      addressDetails: json['addressDetails'] == null
          ? null
          : AddressDetails.fromJson(
              json['addressDetails'] as Map<String, dynamic>),
      addressScore: json['addressScore'] as String?,
      backSideOfId: json['backSideOfId'] as String?,
      checkBackSide: json['checkBackSide'] == null
          ? null
          : CheckBackSide.fromJson(
              json['checkBackSide'] as Map<String, dynamic>),
      checkFrontSide: json['checkFrontSide'] == null
          ? null
          : CheckFrontSide.fromJson(
              json['checkFrontSide'] as Map<String, dynamic>),
      codeCityAddress: json['codeCityAddress'] as String?,
      codeCityHomeTown: json['codeCityHomeTown'] as String?,
      codeCityIssuedPlace: json['codeCityIssuedPlace'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      dateOfBirthScore: json['dateOfBirthScore'] as String?,
      expiredDate: json['expiredDate'] as String?,
      expiredDateScore: json['expiredDateScore'] as String?,
      frontSideOfId: json['frontSideOfId'] as String?,
      fullName: json['fullName'] as String?,
      fullNameScore: json['fullNameScore'] as String?,
      gender: json['gender'] as String?,
      genderScore: json['genderScore'] as String?,
      homeTown: json['homeTown'] as String?,
      homeTownScore: json['homeTownScore'] as String?,
      idCardScore: json['idCardScore'] as String?,
      idNumber: json['idNumber'] as String?,
      issuedDate: json['issuedDate'] as String?,
      issuedDateScore: json['issuedDateScore'] as String?,
      issuedPlace: json['issuedPlace'] as String?,
      issuedPlaceScore: json['issuedPlaceScore'] as String?,
      mrz: json['mrz'] == null
          ? null
          : Mrz.fromJson(json['mrz'] as Map<String, dynamic>),
      nationality: json['nationality'] as String?,
      nationalityScore: json['nationalityScore'] as String?,
      recognitionFeature: json['recognitionFeature'] as String?,
    );

Map<String, dynamic> _$CCCDDataToJson(CCCDData instance) => <String, dynamic>{
      'address': instance.address,
      'addressDetails': instance.addressDetails,
      'addressScore': instance.addressScore,
      'backSideOfId': instance.backSideOfId,
      'checkBackSide': instance.checkBackSide,
      'checkFrontSide': instance.checkFrontSide,
      'codeCityAddress': instance.codeCityAddress,
      'codeCityHomeTown': instance.codeCityHomeTown,
      'codeCityIssuedPlace': instance.codeCityIssuedPlace,
      'dateOfBirth': instance.dateOfBirth,
      'dateOfBirthScore': instance.dateOfBirthScore,
      'expiredDate': instance.expiredDate,
      'expiredDateScore': instance.expiredDateScore,
      'frontSideOfId': instance.frontSideOfId,
      'fullName': instance.fullName,
      'fullNameScore': instance.fullNameScore,
      'gender': instance.gender,
      'genderScore': instance.genderScore,
      'homeTown': instance.homeTown,
      'homeTownScore': instance.homeTownScore,
      'idCardScore': instance.idCardScore,
      'idNumber': instance.idNumber,
      'issuedDate': instance.issuedDate,
      'issuedDateScore': instance.issuedDateScore,
      'issuedPlace': instance.issuedPlace,
      'issuedPlaceScore': instance.issuedPlaceScore,
      'mrz': instance.mrz,
      'nationality': instance.nationality,
      'nationalityScore': instance.nationalityScore,
      'recognitionFeature': instance.recognitionFeature,
    };

AddressDetails _$AddressDetailsFromJson(Map<String, dynamic> json) =>
    AddressDetails(
      country: json['country'] as String?,
      district: json['district'] as String?,
      province: json['province'] as String?,
      street: json['street'] as String?,
      ward: json['ward'] as String?,
    );

Map<String, dynamic> _$AddressDetailsToJson(AddressDetails instance) =>
    <String, dynamic>{
      'country': instance.country,
      'district': instance.district,
      'province': instance.province,
      'street': instance.street,
      'ward': instance.ward,
    };

CheckBackSide _$CheckBackSideFromJson(Map<String, dynamic> json) =>
    CheckBackSide(
      checkGlareProb: json['checkGlareProb'] as String?,
      checkGlareResult: json['checkGlareResult'] as String?,
      checkLfpProb: json['checkLfpProb'] as String?,
      checkLfpResult: json['checkLfpResult'] as String?,
      checkPhotocopiedProb: json['checkPhotocopiedProb'] as String?,
      checkPhotocopiedResult: json['checkPhotocopiedResult'] as String?,
      checkRedStampProb: json['checkRedStampProb'] as String?,
      checkRedStampResult: json['checkRedStampResult'] as String?,
      checkRfpProb: json['checkRfpProb'] as String?,
      checkRfpResult: json['checkRfpResult'] as String?,
      onFrameProb: json['onFrameProb'] as String?,
      onFrameResult: json['onFrameResult'] as String?,
    );

Map<String, dynamic> _$CheckBackSideToJson(CheckBackSide instance) =>
    <String, dynamic>{
      'checkGlareProb': instance.checkGlareProb,
      'checkGlareResult': instance.checkGlareResult,
      'checkLfpProb': instance.checkLfpProb,
      'checkLfpResult': instance.checkLfpResult,
      'checkPhotocopiedProb': instance.checkPhotocopiedProb,
      'checkPhotocopiedResult': instance.checkPhotocopiedResult,
      'checkRedStampProb': instance.checkRedStampProb,
      'checkRedStampResult': instance.checkRedStampResult,
      'checkRfpProb': instance.checkRfpProb,
      'checkRfpResult': instance.checkRfpResult,
      'onFrameProb': instance.onFrameProb,
      'onFrameResult': instance.onFrameResult,
    };

CheckFrontSide _$CheckFrontSideFromJson(Map<String, dynamic> json) =>
    CheckFrontSide(
      checkAvatarProb: json['checkAvatarProb'] as String?,
      checkAvatarResult: json['checkAvatarResult'] as String?,
      checkEmbossedStampResult: json['checkEmbossedStampResult'] as String?,
      checkGlareProb: json['checkGlareProb'] as String?,
      checkGlareResult: json['checkGlareResult'] as String?,
      checkNationalEmblemProb: json['checkNationalEmblemProb'] as String?,
      checkNationalEmblemResult: json['checkNationalEmblemResult'] as String?,
      checkPhotocopiedProb: json['checkPhotocopiedProb'] as String?,
      checkPhotocopiedResult: json['checkPhotocopiedResult'] as String?,
      checkReplacementAvatarProb: json['checkReplacementAvatarProb'] as String?,
      checkReplacementAvatarResult:
          json['checkReplacementAvatarResult'] as String?,
      cornerCutProb: (json['cornerCutProb'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      cornerCutResult: json['cornerCutResult'] as String?,
      editedResult: json['editedResult'] as String?,
      lawOfNumbers: json['lawOfNumbers'] as String?,
      onFrameProb: json['onFrameProb'] as String?,
      onFrameResult: json['onFrameResult'] as String?,
      recapturedResult: json['recapturedResult'] as String?,
    );

Map<String, dynamic> _$CheckFrontSideToJson(CheckFrontSide instance) =>
    <String, dynamic>{
      'checkAvatarProb': instance.checkAvatarProb,
      'checkAvatarResult': instance.checkAvatarResult,
      'checkEmbossedStampResult': instance.checkEmbossedStampResult,
      'checkGlareProb': instance.checkGlareProb,
      'checkGlareResult': instance.checkGlareResult,
      'checkNationalEmblemProb': instance.checkNationalEmblemProb,
      'checkNationalEmblemResult': instance.checkNationalEmblemResult,
      'checkPhotocopiedProb': instance.checkPhotocopiedProb,
      'checkPhotocopiedResult': instance.checkPhotocopiedResult,
      'checkReplacementAvatarProb': instance.checkReplacementAvatarProb,
      'checkReplacementAvatarResult': instance.checkReplacementAvatarResult,
      'cornerCutProb': instance.cornerCutProb,
      'cornerCutResult': instance.cornerCutResult,
      'editedResult': instance.editedResult,
      'lawOfNumbers': instance.lawOfNumbers,
      'onFrameProb': instance.onFrameProb,
      'onFrameResult': instance.onFrameResult,
      'recapturedResult': instance.recapturedResult,
    };

Mrz _$MrzFromJson(Map<String, dynamic> json) => Mrz(
      dateOfBirth: json['dateOfBirth'] as String?,
      expiredDate: json['expiredDate'] as String?,
      fullName: json['fullName'] as String?,
      gender: json['gender'] as String?,
      idCard: json['idCard'] as String?,
      raw: json['raw'] as String?,
    );

Map<String, dynamic> _$MrzToJson(Mrz instance) => <String, dynamic>{
      'dateOfBirth': instance.dateOfBirth,
      'expiredDate': instance.expiredDate,
      'fullName': instance.fullName,
      'gender': instance.gender,
      'idCard': instance.idCard,
      'raw': instance.raw,
    };

ORCErrorContent _$ORCErrorContentFromJson(Map<String, dynamic> json) =>
    ORCErrorContent(
      activityID: json['activityID'] as String?,
      exitCode: (json['exitCode'] as num?)?.toInt(),
      exitCodeMessage: json['exitCodeMessage'] as String?,
      message: json['message'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ORCErrorContentToJson(ORCErrorContent instance) =>
    <String, dynamic>{
      'activityID': instance.activityID,
      'exitCode': instance.exitCode,
      'exitCodeMessage': instance.exitCodeMessage,
      'message': instance.message,
      'status': instance.status,
    };
