import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/app/utils/log.dart';
import 'package:base/data/models/page_data/forgot_page_data.dart';
import 'package:base/presentation/modules/authentication/change_password/change_password_controller.dart';
import 'package:base/presentation/modules/authentication/components/auth_textfield.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:get/get.dart';

class ViewConfirmOldPassword extends StatelessWidget {
  const ViewConfirmOldPassword({super.key, required this.controller});

  final ChangePasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.changePassword,
            style:
                AppTextStyles.s16w700.copyWith(color: AppColors.purple6D15A2),
          ).tr(),
          const SizedBox(height: 10),
          Text(
            '${tr(LocaleKeys.confirm)}\n${tr(LocaleKeys.accountOwner).toLowerCase()}',
            style: AppTextStyles.s30w600.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 10),
          Obx(
            () => AuthTextField(
              keyboardType: TextInputType.visiblePassword,
              focusNode: controller.oldPasswordFocusNode,
              controller: controller.oldPasswordInputController,
              isPassword: true,
              obscureText: !controller.isShowOldPassword.value,
              togglePassword: () =>
                  controller.toggleShowOldPassword(TypeInput.oldPassword),
              hintText: tr(LocaleKeys.currentPassword),
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => controller.errorOldPasswordText.value.isEmpty
                ? const SizedBox.shrink()
                : Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      controller.errorOldPasswordText.value,
                      style: AppTextStyles.s12w600
                          .copyWith(color: AppColors.appColorError),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
          ),
          InkWell(
            onTap: () {
              Log.console('Forgot password click');
              Get.offNamed(
                AppRoutes.forgot,
                arguments: ForgotPageData(
                  type: ForgotPageType.phone,
                  phoneNumber: controller.appProvider.user.value.phone,
                  email: null,
                  avatarLink: controller.appProvider.user.value.avatar,
                ),
              );
            },
            child: Text(
              LocaleKeys.forgotPassword,
              style: AppTextStyles.s14w600.copyWith(
                color: AppColors.purple5232D4,
              ),
            ).tr(),
          ),
        ],
      ),
    );
  }
}
