import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/presentation/modules/authentication/change_password/change_password_controller.dart';
import 'package:base/presentation/modules/authentication/components/auth_textfield.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ViewChangePassword extends StatelessWidget {
  const ViewChangePassword({super.key, required this.controller});

  final ChangePasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        children: [
          _buildNote(context),
          const SizedBox(height: 10),
          _buildInputNewPassword(context),
          const SizedBox(height: 10),
          _buildInputConfirmPassword(context),
        ],
      ),
    );
  }

  _buildNote(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.yellowFFF4CF,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Text(
        LocaleKeys.changedPasswordNote,
        style: AppTextStyles.s12w600.copyWith(
          color: AppColors.yellow564306,
        ),
      ).tr(),
    );
  }

  _buildInputNewPassword(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTextField(
            keyboardType: TextInputType.visiblePassword,
            focusNode: controller.newPasswordFocusNode,
            controller: controller.newPasswordInputController,
            isPassword: true,
            obscureText: !controller.isShowNewPassword.value,
            togglePassword: () =>
                controller.toggleShowOldPassword(TypeInput.newPassword),
            hintText: tr(LocaleKeys.newPassword),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  axis: Axis.vertical,
                  sizeFactor: animation,
                  child: child,
                ),
              );
            },
            child: controller.isNewPassswordFocus.value
                ? _buildValidateNewPassword(context)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  _buildValidateNewPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        _buildValidatePasswordRow(
          title: tr(LocaleKeys.hasSpecialCharacter),
          isValid: controller.isHasSpecialCharacter.value,
        ),
        const SizedBox(height: 8),
        _buildValidatePasswordRow(
          title: tr(LocaleKeys.hasUpperCaseAndLowerCaseAndDigit),
          isValid: controller.isHasUpperAndLowerCaseAndDigit.value,
        ),
        const SizedBox(height: 8),
        _buildValidatePasswordRow(
          title:
              tr(LocaleKeys.charactersLongOrMore, namedArgs: {'length': '8'}),
          isValid: controller.isLengthValid.value,
        ),
      ],
    );
  }

  _buildInputConfirmPassword(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTextField(
            keyboardType: TextInputType.visiblePassword,
            focusNode: controller.confirmPasswordFocusNode,
            controller: controller.confirmPasswordInputController,
            isPassword: true,
            obscureText: !controller.isShowConfirmPassword.value,
            togglePassword: () =>
                controller.toggleShowOldPassword(TypeInput.confirmPassword),
            hintText: tr(LocaleKeys.enterPasswordAgain),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  axis: Axis.vertical,
                  sizeFactor: animation,
                  child: child,
                ),
              );
            },
            child: controller.isConfirmPasswordFocus.value
                ? _buildValidateConfirmNewPassword(context)
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  _buildValidateConfirmNewPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        _buildValidatePasswordRow(
          title: tr(LocaleKeys.matchesNewPassword),
          isValid: controller.isMatchPassword.value,
        ),
      ],
    );
  }

  _buildValidatePasswordRow({
    required String title,
    required bool isValid,
  }) {
    return Row(
      children: [
        isValid
            ? SvgPicture.asset(
                SvgPath.icCheck,
                width: 16,
                height: 16,
              )
            : SvgPicture.asset(
                SvgPath.icDot,
                width: 16,
                height: 16,
              ),
        const SizedBox(width: 4),
        Text(
          title,
          style: AppTextStyles.s13w400.copyWith(
            color: isValid ? const Color(0xFF26BF56) : const Color(0xFF272A31),
          ),
        ),
      ],
    );
  }
}
