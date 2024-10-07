import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/presentation/modules/authentication/change_password/change_password_controller.dart';
import 'package:base/presentation/modules/authentication/change_password/widget/view_change_password.dart';
import 'package:base/presentation/modules/authentication/change_password/widget/view_confirm_old_password.dart';
import 'package:base/presentation/widgets/animated_scale_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends BaseScreen<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Widget buildScreen(BuildContext context) {
    return PopScope(
      canPop: false,
      child: FractionallySizedBox(
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: Column(
          children: [
            Expanded(
              child: _buildContent(context),
            ),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  _buildContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.reFocusRequest();
      },
      child: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ViewConfirmOldPassword(controller: controller),
          ViewChangePassword(controller: controller),
        ],
      ),
    );
  }

  _buildButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ScaleButton(
        duration: const Duration(milliseconds: 100),
        onTap: controller.onButtonClick,
        child: Container(
          height: 56,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.yellowFFE500,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Obx(
            () => Container(
              child: controller.loading.value
                  ? const CircularProgressIndicator(
                      color: AppColors.black0D0C0E,
                      strokeWidth: 2,
                    )
                  : const Text(
                      LocaleKeys.continueText,
                      style: AppTextStyles.s16w700,
                    ).tr(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: AppColors.appColorWhite,
      elevation: 0,
      centerTitle: true,
      leadingWidth: 88,
      leading: GestureDetector(
        onTap: controller.onBackClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SvgPicture.asset(
            SvgPath.icArrowLeft,
            width: 24,
            colorFilter:
                const ColorFilter.mode(AppColors.black0D0C0E, BlendMode.srcIn),
          ),
        ),
      ),
      title: Obx(
        () => Text(
          controller.step.value == ChangePasswordStep.confirmOldPassword
              ? ''
              : LocaleKeys.createNewPassword,
          style: AppTextStyles.s16w700.copyWith(
            color: AppColors.black14081C,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ).tr(),
      ),
    );
  }
}
