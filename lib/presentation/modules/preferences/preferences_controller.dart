import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/domain/services/auth_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:base/presentation/modules/preferences/about_app.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/shared/global/app_dialog.dart';
import 'package:get/get.dart';

typedef PreferenceItem = ({
  String title,
  String subtitle,
  String svgPath,
  Function() onTap
});

class PreferencesController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();

  final List<PreferenceItem> preferenceItems = [
    (
      title: 'Account Information',
      subtitle: 'Change your account information',
      svgPath: SvgPath.icPersonFilled,
      onTap: () => Get.toNamed(AppRoutes.changeUserInfo)
    ),
    (
      title: 'Password',
      subtitle: 'Change your password',
      svgPath: SvgPath.icEye,
      onTap: () => Get.toNamed(AppRoutes.changePassword)
    ),
    (
      title: 'About',
      subtitle: 'About Prompter',
      svgPath: SvgPath.icBubble,
      onTap: () => Get.to(() => AboutTheApp())
    ),
  ];

  onTapSignOut() async {
    final isConfirm = await Get.dialog<bool?>(AppDialog(
      title: 'Sign Out',
      content: 'Are you sure you want to sign out?',
      primaryButtonText: 'Sign Out',
      secondaryButtonText: 'Cancel',
      onPrimaryButtonTap: () => Get.back(result: true),
      onSecondaryButtonTap: () => Get.back(result: false),
    ));
    if (isConfirm != true) {
      return;
    }
    await _authService.signOut();
    appProvider.clearUserData();
  }
}
