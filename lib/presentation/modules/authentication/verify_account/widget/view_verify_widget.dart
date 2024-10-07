import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/presentation/modules/authentication/verify_account/verify_account_controller.dart';
import 'package:base/presentation/modules/authentication/verify_account/widget/step_item_widget.dart';
import 'package:base/presentation/widgets/highlighted_text.dart';
import 'package:get/get.dart';

class ViewVerifyWidget extends StatelessWidget {
  final VerifyAccountController controller;

  const ViewVerifyWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1.0,
      widthFactor: 1.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.verifyAccount,
                    style: AppTextStyles.s30w600.copyWith(color: Colors.black))
                .tr(),
            const SizedBox(height: 16),
            HighlightedText(
              text:
                  '${tr(LocaleKeys.verifyYourAccountWithCitizenIdentificationToStartInvestingAt, namedArgs: {
                    'field': tr(LocaleKeys.citizenIdentification)
                  })} F1 Trading',
              highlights: [
                tr(LocaleKeys.citizenIdentification),
                'F1 Trading',
              ],
              normalTextStyle:
                  AppTextStyles.s14w500.copyWith(color: AppColors.gray99909B),
              highlightStyle:
                  AppTextStyles.s14w700.copyWith(color: AppColors.grey4F4950),
            ),
            const SizedBox(height: 16),
            Obx(
              () => StepItemWidget(
                step: 1,
                title: tr(LocaleKeys.uploadIDCardOrCitizenIdentification),
                icon: Image.asset(
                  ImagePath.icEkycOcr,
                  width: 56,
                  height: 56,
                ),
                isCompleted:
                    controller.step.value.value > VerifyStep.upLoadCCCD.value,
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () => StepItemWidget(
                step: 2,
                title: tr(LocaleKeys.faceAuthentication),
                icon: Image.asset(
                  ImagePath.icEkycLiveness,
                  width: 56,
                  height: 56,
                ),
                isCompleted: controller.step.value.value >
                    VerifyStep.faceAuthentication.value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
