import 'package:base/presentation/modules/ai_chat/ai_chat_binding.dart';
import 'package:base/presentation/modules/ai_chat/ai_chat_screen.dart';
import 'package:base/presentation/modules/authentication/forgot_password/forgot_password_binding.dart';
import 'package:base/presentation/modules/authentication/forgot_password/forgot_password_screen.dart';
import 'package:base/presentation/modules/authentication/login/login_binding.dart';
import 'package:base/presentation/modules/authentication/login/login_screen.dart';
import 'package:base/presentation/modules/authentication/register/register_binding.dart';
import 'package:base/presentation/modules/authentication/register/register_screen.dart';
import 'package:base/presentation/modules/authentication/reset_password/reset_password_binding.dart';
import 'package:base/presentation/modules/authentication/reset_password/reset_password_screen.dart';
import 'package:base/presentation/modules/home/comment/comment_binding.dart';
import 'package:base/presentation/modules/home/comment/comment_screen.dart';
import 'package:base/presentation/modules/home/post/new_post/new_post_binding.dart';
import 'package:base/presentation/modules/home/post/new_post/new_post_screen.dart';
import 'package:base/presentation/modules/photo_gallery/photo_gallery_binding.dart';
import 'package:base/presentation/modules/photo_gallery/photo_gallery_screen.dart';
import 'package:base/presentation/modules/preferences/change_password/change_password_binding.dart';
import 'package:base/presentation/modules/preferences/change_password/change_password_screen.dart';
import 'package:base/presentation/modules/preferences/change_user_info/change_user_info_binding.dart';
import 'package:base/presentation/modules/preferences/change_user_info/change_user_info_screen.dart';
import 'package:base/presentation/modules/preferences/preferences_binding.dart';
import 'package:base/presentation/modules/preferences/preferences_screen.dart';
import 'package:base/presentation/modules/profile/profile_binding.dart';
import 'package:base/presentation/modules/profile/profile_screen.dart';
import 'package:base/presentation/modules/root/root_binding.dart';
import 'package:base/presentation/modules/root/root_screen.dart';
import 'package:base/presentation/modules/splash/splash_binding.dart';
import 'package:base/presentation/modules/splash/splash_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static String initial = AppRoutes.splash;

  static final appRoutes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.root,
      page: () => RootScreen(),
      binding: RootBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.aiChat,
      page: () => AiChatScreen(),
      binding: AiChatBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppRoutes.photoGallery,
      page: () => PhotoGalleryScreen(),
      binding: PhotoGalleryBinding(),
    ),
    GetPage(
      name: AppRoutes.newPost,
      page: () => NewPostScreen(),
      binding: NewPostBinding(),
    ),
    GetPage(
      name: AppRoutes.comment,
      page: () => CommentScreen(),
      binding: CommentBinding(),
    ),
    GetPage(
      name: AppRoutes.preferences,
      page: () => PreferencesScreen(),
      binding: PreferencesBinding(),
    ),
    GetPage(
      name: AppRoutes.changeUserInfo,
      page: () => ChangeUserInfoScreen(),
      binding: ChangeUserInfoBinding(),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];
}
