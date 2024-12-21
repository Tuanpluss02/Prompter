import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_color.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:base/presentation/shared/global/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'preferences_controller.dart';

class PreferencesScreen extends BaseScreen<PreferencesController> {
  const PreferencesScreen({super.key});

  @override
  bool get wrapWithSafeArea => true;

  @override
  Widget buildScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAppbar(),
        SizedBox(height: 20),
        ..._buildActionList(),
        _buildLogoutButton(),
      ],
    );
  }

  _buildActionList() {
    return controller.preferenceItems.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            onTap: item.onTap,
            leading: SvgPicture.asset(
              item.svgPath,
              width: 30,
              colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTextStyles.s20w700,
                ),
                Text(
                  item.subtitle,
                  style: AppTextStyles.s12w500.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Row _buildAppbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppBackButton(size: 40),
        Text(
          'Preferences',
          style: AppTextStyles.s28w700,
        ),
        SizedBox(width: 40),
      ],
    );
  }

  _buildLogoutButton() {
    return ScaleButton(
      onTap: controller.onTapSignOut,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                SvgPath.icLogout,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
              ),
              SizedBox(width: 8),
              Text('Sign Out',
                  style: AppTextStyles.s16w800.copyWith(
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
