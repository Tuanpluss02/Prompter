import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/presentation/modules/authentication/verify_account/verify_account_controller.dart';
import 'package:get/get.dart';

class ViewDetailInfoWidget extends StatelessWidget {
  const ViewDetailInfoWidget({super.key, required this.controller});

  final VerifyAccountController controller;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      heightFactor: 1.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 18, left: 32, right: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                LocaleKeys.confirmInfo,
                style: AppTextStyles.s20w700.copyWith(color: Colors.black),
              ).tr(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.grayF7F7F8,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInforDetail(
                            title: tr(LocaleKeys.idNumber),
                            content: controller.cccdData.value.idNumber),
                        const SizedBox(height: 16),
                        _buildInforDetail(
                            title: tr(LocaleKeys.name),
                            content: controller.cccdData.value.fullName),
                        const SizedBox(height: 16),
                        _buildInforDetail(
                            title: tr(LocaleKeys.dateOfBirth),
                            content: controller.cccdData.value.dateOfBirth),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: _buildInforDetail(
                                  title: tr(LocaleKeys.gender_value),
                                  content: controller.cccdData.value.gender),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildInforDetail(
                                  title: tr(LocaleKeys.nationality),
                                  content:
                                      controller.cccdData.value.nationality),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInforDetail(
                            title: tr(LocaleKeys.homeTown),
                            content: controller.cccdData.value.homeTown),
                        const SizedBox(height: 16),
                        _buildInforDetail(
                            title: tr(LocaleKeys.addressResidence),
                            content: controller.cccdData.value.address),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: _buildInforDetail(
                                  title:
                                      '${tr(LocaleKeys.dateOfIssue)} ${tr(LocaleKeys.citizenIdentification)}',
                                  content:
                                      controller.cccdData.value.issuedDate),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildInforDetail(
                                  title:
                                      '${tr(LocaleKeys.dateOfExpiry)} ${tr(LocaleKeys.citizenIdentification)}',
                                  content:
                                      controller.cccdData.value.expiredDate),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInforDetail(
                            title: tr(LocaleKeys.placeOfIssue),
                            content: controller.cccdData.value.issuedPlace),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildInforDetail({required String title, String? content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTextStyles.s12w600.copyWith(color: AppColors.grey45484F),
        ),
        const SizedBox(height: 7),
        Text(
          content ?? '---',
          style: AppTextStyles.s16w600.copyWith(color: AppColors.black0D1017),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
