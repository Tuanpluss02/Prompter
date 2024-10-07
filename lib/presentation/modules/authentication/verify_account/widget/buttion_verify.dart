import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/presentation/modules/authentication/verify_account/verify_account_controller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ButtonVerify extends StatelessWidget {
  const ButtonVerify({super.key, required this.controller});

  final VerifyAccountController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        String titleKey = '';
        bool isShowArrowIcon = true;

        switch (controller.step.value) {
          case VerifyStep.upLoadCCCD:
            titleKey = LocaleKeys.uploadIDCardOrCitizenIdentification;
            break;
          case VerifyStep.faceAuthentication:
            titleKey = LocaleKeys.faceAuthentication;
            break;
          case VerifyStep.next:
            titleKey = LocaleKeys.continueText;
            break;
          case VerifyStep.conffirm:
            titleKey = LocaleKeys.confirm;
            isShowArrowIcon = false;
            break;
          case VerifyStep.finish:
            // no need to show button so no need to return anything
            break;
        }

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 32),
          alignment: controller.step.value == VerifyStep.conffirm
              ? Alignment.center
              : Alignment.centerLeft,
          child: TextButton(
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              backgroundColor:
                  WidgetStateProperty.all<Color>(AppColors.yellowFFE500),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              fixedSize: WidgetStateProperty.all<Size>(
                const Size(250, 56),
              ),
            ),
            onPressed: () {
              controller.onButtonClick();
            },
            child: Row(
              mainAxisAlignment: controller.step.value == VerifyStep.conffirm
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titleKey,
                  style: const TextStyle(
                    color: AppColors.black0D1017,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ).tr(),
                if (isShowArrowIcon)
                  SvgPicture.asset(
                    SvgPath.icArrowRight,
                    height: 24,
                    width: 24,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
