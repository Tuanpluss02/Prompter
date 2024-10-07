import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:ekyc_plugin_flutter/ekyc_plugin_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_strings.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/app/utils/ekyc_error_toast.dart';
import 'package:base/app/utils/log.dart';
import 'package:base/app/utils/toast_utils.dart';
import 'package:base/base/base_controller.dart';
import 'package:base/data/models/page_data/verify_account_page_data.dart';
import 'package:base/data/models/request/update_ekyc_request.dart';
import 'package:base/data/models/response/base_response.dart';
import 'package:base/data/models/response/ekyc_liveness_response.dart';
import 'package:base/data/models/response/ekyc_ocr_response.dart';
import 'package:base/data/models/response/ekyc_response.dart';
import 'package:base/data/repositories/ekyc_repository.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/widgets/api_widget.dart';
import 'package:base/presentation/widgets/overlay_success_mission.dart';
import 'package:base/services/network_exceptions.dart';
import 'package:get/get.dart';

enum VerifyStep {
  upLoadCCCD(1),
  faceAuthentication(2),
  next(3),
  conffirm(4),
  finish(5);

  final int value;

  const VerifyStep(this.value);
}

class VerifyAccountController extends BaseController {
  VerifyAccountController({required this.pageData});

  final VerifyAccountPageData pageData;

  final EkycRepository _ekycRepository = Get.find<EkycRepository>();

  String tokenEKYC = '';
  String imageFront = '';
  String imageBack = '';
  Rx<CCCDData> cccdData = Rx(CCCDData());
  Rx<ScanFaceData> scanFaceData = Rx(ScanFaceData());

  final PageController pageController = PageController(initialPage: 0);

  Rx<VerifyStep> step = VerifyStep.upLoadCCCD.obs;

  @override
  onReady() {
    super.onReady();
    if (pageData.cccdData != null) {
      cccdData.value = pageData.cccdData!;
      step.value = VerifyStep.finish;
      pageController.jumpToPage(1);
    }
  }

  onButtonClick() {
    switch (step.value) {
      case VerifyStep.upLoadCCCD:
        startEKYC();
        break;
      case VerifyStep.faceAuthentication:
        callLiveNess(tokenEKYC, imageFront);
        break;
      case VerifyStep.next:
        pageController.animateToPage(1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
        step.value = VerifyStep.conffirm;
        Future.delayed(const Duration(milliseconds: 300), () {
          showBadgeNotification(
            context: Get.context!,
            title: tr(LocaleKeys.scanSuccess),
            content: '',
            prefixWidget: Image.asset(
              ImagePath.imgSuccess,
              fit: BoxFit.contain,
              width: 38,
              height: 38,
            ),
          );
        });
        break;
      case VerifyStep.conffirm:
        _updateEkyc();
        break;
      case VerifyStep.finish:
        // no need to do anything
        break;
    }
  }

  _updateEkyc() async {
    final UpdateEkycRequest param = UpdateEkycRequest(
      addressResident: cccdData.value.address,
      dob: cccdData.value.dateOfBirth,
      dateOfIssue: cccdData.value.issuedDate,
      expiredDate: cccdData.value.expiredDate,
      fullName: cccdData.value.fullName,
      gender: cccdData.value.gender,
      homeTown: cccdData.value.homeTown,
      issueAt: cccdData.value.issuedPlace,
      nationality: cccdData.value.nationality,
      citizenId: cccdData.value.idNumber,
      cccdFPath: imageFront,
      cccdBPath: imageBack,
    );
    final apiResult =
        await ApiWidget.checkTimeCallApi(_ekycRepository.updateEkyc(param));
    apiResult.when(
      apiSuccess: (BaseResponse res) async {
        if (res.code == 0) {
          step.value = VerifyStep.finish;
          await Get.find<HomeController>().getUserData();
          onBackpress();
          Future.delayed(const Duration(milliseconds: 300), () {
            showBadgeNotification(
              context: Get.context!,
              title: tr(LocaleKeys.personalDocuments),
              content: tr(LocaleKeys.updateSuccess),
              prefixWidget: Image.asset(
                ImagePath.imgSuccess,
                fit: BoxFit.contain,
                width: 38,
                height: 38,
              ),
            );
          });
        } else {
          //cần confirm lại BA, design thông báo lỗi
          ToastUtils.showError(res.message ?? 'Lỗi truy cập');
        }
      },
      apiFailure: (NetworkExceptions error) {
        Log.console(NetworkExceptions.getErrorMessage(error));
        ToastUtils.showError(NetworkExceptions.getErrorMessage(error));
      },
    );
  }

  startEKYC() async {
    final apiResult =
        await ApiWidget.checkTimeCallApi(_ekycRepository.getTokenEkyc());
    apiResult.when(
      apiSuccess: (BaseResponse res) async {
        if (res.code == 0) {
          tokenEKYC = res.data.toString();
          callOCR(tokenEKYC);
        } else {
          //cần confirm lại BA, design thông báo lỗi
          ToastUtils.showError(res.message ?? 'Lỗi truy cập');
        }
      },
      apiFailure: (NetworkExceptions error) {
        Log.console(NetworkExceptions.getErrorMessage(error));
        ToastUtils.showError(NetworkExceptions.getErrorMessage(error));
      },
    );
  }

  callOCR(String token) async {
    Map<Object?, Object?> res = await SampleCallNativeFlutter.showOCR(
      token,
      '',
      AppStrings.fptUrlEKYC,
      tr(LocaleKeys.region),
    );

    EkycResponse ekycResponse =
        EkycResponse.fromJson(_convertEkycResponse(res));

    try {
      if (ekycResponse.error == null) {
        CCCDData? cccdDataOcr;

        if (Platform.isIOS) {
          cccdDataOcr = CCCDData.fromJson(jsonDecode(ekycResponse.response!));
          log('cccdDataOcr: ${cccdDataOcr.toJson()}');
        } else {
          EkycOCRResponse ekycOCRResponse = EkycOCRResponse.fromJson(jsonDecode(
              ekycResponse
                  .response!)); // ekycResponse.response có thể null do sdk trả về
          CCCDResponse cccdResponse = CCCDResponse.fromJson(jsonDecode(
              ekycOCRResponse
                  .response!)); // ekycOCRResponse.response có thể null do sdk trả về
          cccdDataOcr = cccdResponse.data!;
        }

        cccdData.value = cccdDataOcr;
        imageFront = ekycResponse.frontImage!;
        imageBack = ekycResponse.backImage!;
        step.value = VerifyStep.faceAuthentication;
      } else {
        EkycError ekycError = ekycResponse.error!;
        ORCErrorContent ekycErrorContent =
            ORCErrorContent.fromJson(jsonDecode(ekycError.content!));
        log('error content: ${ekycError.content}');
        EkycErrorToast ekycErrorToast =
            EkycErrorToast(exitCode: ekycErrorContent.exitCode ?? 0);
        ekycErrorToast.showEKYCError();
      }
    } catch (e) {
      Log.console('Lỗi khi parse dữ liệu ORC từ sdk: $e',
          where: 'VerifyAccountController', level: LogLevel.error);
    }
  }

  callLiveNess(String token, String frontImage) async {
    Map<Object?, Object?> res = await SampleCallNativeFlutter.showLiveness(
      token,
      '',
      AppStrings.fptUrlEKYC,
      tr(LocaleKeys.region),
      frontImage,
    );

    EkycResponse ekycResponse =
        EkycResponse.fromJson(_convertEkycResponse(res));

    try {
      if (ekycResponse.error == null) {
        ScanFaceResponse? scanFaceResponse;

        if (Platform.isIOS) {
          scanFaceResponse =
              ScanFaceResponse.fromJson(jsonDecode(ekycResponse.response!));
        } else {
          EkycLIVENESSResponse ekycLIVENESSResponse =
              EkycLIVENESSResponse.fromJson(jsonDecode(ekycResponse
                  .response!)); // ekycResponse.response có thể null do sdk trả về
          scanFaceResponse = ScanFaceResponse.fromJson(jsonDecode(
              ekycLIVENESSResponse
                  .response!)); // ekycLIVENESSResponse.response có thể null do sdk trả về
        }

        scanFaceData.value = scanFaceResponse.data!;
        step.value = VerifyStep.next;
      } else {
        EkycError ekycError = ekycResponse.error!;
        LIVENESSErrorContent ekycErrorContent =
            LIVENESSErrorContent.fromJson(jsonDecode(ekycError.content!));
        log('EkycError Content: ${ekycError.content}');
        EkycErrorToast ekycErrorToast =
            EkycErrorToast(exitCode: ekycErrorContent.exitCode ?? 0);
        ekycErrorToast.showEKYCError();
      }
    } catch (e) {
      Log.console('Lỗi khi parse dữ liệu LIVENESS từ sdk: $e',
          where: 'VerifyAccountController', level: LogLevel.error);
    }
  }

  /// Convert response from ekyc sdk from Map<Object?, Object?> to Map<String, dynamic>
  Map<String, dynamic> _convertEkycResponse(Map<Object?, Object?> res) {
    Map<String, dynamic> resMap = {};

    resMap.addEntries(
      res.entries.map((e) {
        if (e.key == 'error' && e.value != null) {
          final Map<String, dynamic> errorMap = {};
          final Map<dynamic, dynamic> error = e.value as Map<Object?, Object?>;
          errorMap.addEntries(
              error.entries.map((e) => MapEntry(e.key.toString(), e.value)));
          return MapEntry(e.key.toString(), errorMap);
        }
        return MapEntry(e.key.toString(), e.value);
      }),
    );

    return resMap;
  }
}
