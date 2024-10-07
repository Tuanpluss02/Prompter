import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/presentation/modules/authentication/verify_account/verify_account_controller.dart';
import 'package:base/presentation/modules/authentication/verify_account/widget/buttion_verify.dart';
import 'package:base/presentation/modules/authentication/verify_account/widget/view_detail_info_widget.dart';
import 'package:base/presentation/modules/authentication/verify_account/widget/view_verify_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class VerifyAccountScreen extends BaseScreen<VerifyAccountController> {
  const VerifyAccountScreen({super.key});

  @override
  Color? get screenBackgroundColor => AppColors.appColorWhite;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: AppColors.appColorWhite,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 54,
      leadingWidth: 48,
      leading: GestureDetector(
        onTap: () {
          controller.onBackpress();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: SvgPicture.asset(
            SvgPath.icArrowLeft,
            width: 24,
            colorFilter:
                const ColorFilter.mode(AppColors.black0D0C0E, BlendMode.srcIn),
          ),
        ),
      ),
      actions: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () {
                if (controller.step.value == VerifyStep.conffirm ||
                    controller.step.value == VerifyStep.finish) {
                  controller.step.value = VerifyStep.upLoadCCCD;
                  controller.pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
              child: controller.step.value == VerifyStep.conffirm ||
                      controller.step.value == VerifyStep.finish
                  ? Text(
                      LocaleKeys.doItAgain,
                      style: AppTextStyles.s14w700.copyWith(
                        color: AppColors.black0D1017,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                        decorationColor: AppColors.black0D1017,
                      ),
                    ).tr()
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ViewVerifyWidget(controller: controller),
              ViewDetailInfoWidget(controller: controller),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Obx(() => controller.step.value == VerifyStep.finish
            ? const SizedBox.shrink()
            : ButtonVerify(controller: controller)),
        const SizedBox(height: 56),
      ],
    );
  }
}
