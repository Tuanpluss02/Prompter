import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/presentation/widgets/custom_checkbox.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InvestmentItem extends StatelessWidget {
  final String code;
  final String product;
  final String price;
  final String percentage;
  final String icon;
  final bool isCheckbox;
  final bool isUp;
  final bool isDismissible;
  final Function? onDismissed;

  const InvestmentItem({
    super.key,
    required this.code,
    required this.product,
    required this.price,
    required this.percentage,
    this.icon = SvgPath.icSoy,
    this.isCheckbox = false,
    required this.isUp,
    this.isDismissible = false,
    this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return isDismissible
        ? Dismissible(
            key: Key(code), // Unique key for each Dismissible item
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              onDismissed?.call(code);
            },
            background: Container(
              color: AppColors.redE9315D,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    SvgPath.icTrash,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    tr(LocaleKeys.delete),
                    style: AppTextStyles.s14w600.copyWith(
                      color: AppColors.appColorWhite,
                    ),
                  ),
                ],
              ),
            ),
            child: _buildInvestmentContent(),
          )
        : _buildInvestmentContent();
  }

  Widget _buildInvestmentContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8, left: 24),
          child: Row(
            children: [
              if (isCheckbox)
                Row(
                  children: [
                    CustomCheckbox(
                      onChanged: (bool value) {
                        log('value: $value');
                      },
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.yellowFFDC00,
                child: SvgPicture.asset(
                  icon,
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      code,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.black0D1017,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product,
                      style: const TextStyle(
                        color: AppColors.grayA1A1A1,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color:
                            isUp ? AppColors.green14B211 : AppColors.redF33030,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          isUp ? Icons.arrow_upward : Icons.arrow_downward,
                          color: isUp
                              ? AppColors.green14B211
                              : AppColors.redF33030,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          percentage,
                          style: TextStyle(
                            color: isUp
                                ? AppColors.green14B211
                                : AppColors.redF33030,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: const Divider(
            height: 1,
            thickness: 1,
            color: AppColors.grayEEEEEE,
          ),
        ),
      ],
    );
  }
}
