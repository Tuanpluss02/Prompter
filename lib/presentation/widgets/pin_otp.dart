import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/data/models/request/verify_pin_request.dart';
import 'package:base/data/repositories/setting_repository.dart';
import 'package:base/presentation/widgets/call_api_widget.dart';
import 'package:base/presentation/widgets/dot_input.dart';
import 'package:base/services/api_result.dart';
import 'package:base/services/network_exceptions.dart';
import 'package:get/get.dart';

class PinOtp extends StatefulWidget {
  const PinOtp({
    super.key,
    this.onSuccess,
    this.onForgotOtp,
    required this.title,
    required this.description,
    required this.detail,
  });

  final VoidCallback? onSuccess;
  final VoidCallback? onForgotOtp;
  final String title;
  final String description;
  final String detail;

  @override
  State<PinOtp> createState() => _PinOtpState();
}

class _PinOtpState extends State<PinOtp> {
  final FocusNode _pinFocusNode = FocusNode();
  final TextEditingController _pinController = TextEditingController();
  final SettingRepository _settingRepository = SettingRepository();
  RxString errorText = ''.obs;

  @override
  void initState() {
    super.initState();
    _pinFocusNode.requestFocus();
  }

  void _handlePinSubmit(String pin) async {
    ApiResult apiResult = await CallApiWidget.checkTimeCallApi(
      api: _settingRepository.verifyPin(
        VerifyPinRequest(pin: pin),
      ),
      context: Get.context!,
    );

    apiResult.when(
      apiSuccess: (res) {
        if (res.code == 0) {
          _pinController.clear();
          errorText.value = '';
          widget.onSuccess?.call();
        } else {
          _pinController.clear();
          errorText.value = res.message ?? tr(LocaleKeys.something_went_wrong);
        }
      },
      apiFailure: (e) {
        _pinController.clear();
        errorText.value = NetworkExceptions.getErrorMessage(e);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(_pinFocusNode);
      },
      child: Stack(
        children: [
          Positioned(
            child: Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 72),
                    Text(
                      widget.title,
                      style: AppTextStyles.s16w700.copyWith(
                        color: AppColors.purple6B15A2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: AppTextStyles.s20w700
                          .copyWith(color: AppColors.black14081C),
                    ),
                    const SizedBox(height: 50),
                    DotInput(
                      controller: _pinController,
                      focusNode: _pinFocusNode,
                      stepValue: _pinController.text,
                      onCompleted: _handlePinSubmit,
                      onChanged: (String value) {
                        setState(() {
                          _pinController.text = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          alignment: Alignment.center,
                          child: Text(
                            errorText.value,
                            style: AppTextStyles.s12w500
                                .copyWith(color: AppColors.redF33030),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        alignment: Alignment.center,
                        child: Text(
                          widget.detail,
                          style: AppTextStyles.s12w500
                              .copyWith(color: AppColors.black14081C),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: InkWell(
                onTap: widget.onForgotOtp?.call,
                child: Text(
                  '${tr(LocaleKeys.forgotCode)} PIN?',
                  style: AppTextStyles.s12w600.copyWith(
                    color: AppColors.purple6B15A2,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pinFocusNode.dispose();
    _pinController.dispose();
    super.dispose();
  }
}
