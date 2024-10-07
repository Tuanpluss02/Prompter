import 'package:base/presentation/modules/authentication/forgot/forgot_binding.dart';
import 'package:base/presentation/modules/authentication/forgot/forgot_screen.dart';
import 'package:base/presentation/modules/authentication/login/login_binding.dart';
import 'package:base/presentation/modules/authentication/login/login_screen.dart';
import 'package:base/presentation/modules/authentication/register/register_binding.dart';
import 'package:base/presentation/modules/authentication/register/register_page.dart';
import 'package:base/presentation/modules/authentication/verify_account/verify_account_binding.dart';
import 'package:base/presentation/modules/authentication/verify_account/verify_account_screen.dart';
import 'package:base/presentation/modules/change_username/change_username_binding.dart';
import 'package:base/presentation/modules/change_username/change_username_screen.dart';
import 'package:base/presentation/modules/explore/news_detail/app_webview_binding.dart';
import 'package:base/presentation/modules/explore/news_detail/app_webview_screen.dart';
import 'package:base/presentation/modules/explore/search_news/search_news_bindings.dart';
import 'package:base/presentation/modules/explore/search_news/search_news_screen.dart';
import 'package:base/presentation/modules/history_transaction/history_transaction_binding.dart';
import 'package:base/presentation/modules/history_transaction/history_transaction_screen.dart';
import 'package:base/presentation/modules/home/home_binding.dart';
import 'package:base/presentation/modules/home/home_screen.dart';
import 'package:base/presentation/modules/investment_portfolio/investment_portfolio_binding.dart';
import 'package:base/presentation/modules/investment_portfolio/investment_portfolio_screen.dart';
import 'package:base/presentation/modules/money_manager/money_manager_binding.dart';
import 'package:base/presentation/modules/money_manager/money_manager_screen.dart';
import 'package:base/presentation/modules/onboarding/splash/splash_binding.dart';
import 'package:base/presentation/modules/onboarding/splash/splash_screen.dart';
import 'package:base/presentation/modules/onboarding/welcome/welcome_binding.dart';
import 'package:base/presentation/modules/onboarding/welcome/welcome_screen.dart';
import 'package:base/presentation/modules/profile/profile_binding.dart';
import 'package:base/presentation/modules/profile/profile_screen.dart';
import 'package:base/presentation/modules/root/root_binding.dart';
import 'package:base/presentation/modules/root/root_screen.dart';
import 'package:base/presentation/modules/search_page/search_page_binding.dart';
import 'package:base/presentation/modules/search_page/search_page_screen.dart';
import 'package:base/presentation/modules/settings/add_bank_account/add_bank_account_binding.dart';
import 'package:base/presentation/modules/settings/add_bank_account/add_bank_account_screen.dart';
import 'package:base/presentation/modules/settings/confirm_account_bank/confirm_bank_account_screen.dart';
import 'package:base/presentation/modules/settings/confirm_information_ekyc/confirm_information_ekyc_binding.dart';
import 'package:base/presentation/modules/settings/confirm_information_ekyc/confirm_information_ekyc_screen.dart';
import 'package:base/presentation/modules/settings/constitute_email/constitute_email_binding.dart';
import 'package:base/presentation/modules/settings/constitute_email/constitute_email_screen.dart';
import 'package:base/presentation/modules/settings/settings_binding.dart';
import 'package:base/presentation/modules/settings/settings_screen.dart';
import 'package:base/presentation/modules/settings/webview_e_contact/web_view_e_contact_screen.dart';
import 'package:base/presentation/modules/tracking_code/tracking_code_binding.dart';
import 'package:base/presentation/modules/tracking_code/tracking_code_screen.dart';
import 'package:base/presentation/modules/trade/trade_binding.dart';
import 'package:base/presentation/modules/trade/trade_screen.dart';
import 'package:base/presentation/routes/app_middleware.dart';
import 'package:get/get.dart';

import '../modules/accessibility/payment/enter_money_payment/enter_money_payment_binding.dart';
import '../modules/accessibility/payment/enter_money_payment/enter_money_payment_screen.dart';
import '../modules/accessibility/payment/payment_binding.dart';
import '../modules/accessibility/payment/payment_screen.dart';
import '../modules/accessibility/payment/qr_payment/qr_payment_binding.dart';
import '../modules/accessibility/payment/qr_payment/qr_payment_screen.dart';
import '../modules/accessibility/withdraw_money/confirm_withdraw_money/confirm_withdraw_money_binding.dart';
import '../modules/accessibility/withdraw_money/confirm_withdraw_money/confirm_withdraw_money_screen.dart';
import '../modules/accessibility/withdraw_money/withdraw_money_binding.dart';
import '../modules/accessibility/withdraw_money/withdraw_money_screen.dart';
import '../modules/accessibility/withdraw_money/withdraw_money_success/withdraw_money_success_binding.dart';
import '../modules/accessibility/withdraw_money/withdraw_money_success/withdraw_money_success_screen.dart';
import '../modules/authentication/change_password/change_passord_bindings.dart';
import '../modules/authentication/change_password/change_password_screen.dart';
import '../modules/settings/confirm_account_bank/confirm_bank_account_binding.dart';
import '../modules/settings/webview_e_contact/web_view_e_contact_binding.dart';

part 'app_routes.dart';

class AppPages {
  static String initial = AppRoutes.splash;

  static final appRoutes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.forgot,
      page: () => const ForgotScreen(),
      binding: ForgotBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.root,
      page: () => const RootScreen(),
      binding: RootBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeScreen(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchPageScreen(),
      binding: SearchPageBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.webview,
      page: () => const AppWebviewScreen(),
      binding: AppWebViewBinding(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.searchNews,
      page: () => const SearchNewsScreen(),
      binding: SearchNewsBindings(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.trackingCode,
      page: () => const TrackingCodeScreen(),
      binding: TrackingCodeBinding(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.historyTransaction,
      page: () => const HistoryTransactionScreen(),
      binding: HistoryTransactionBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.changeUserName,
      page: () => const ChangeUsernameScreen(),
      binding: ChangeUsernameBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.payment,
      page: () => const PaymentScreen(),
      binding: PaymentBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.withdrawMoney,
      page: () => const TransferMoneyScreen(),
      binding: TransferMoneyBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.addBankAccount,
      page: () => const AddBankAccountScreen(),
      binding: AddBankAccountBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.confirmBankAccount,
      page: () => const ConfirmBankAccountScreen(),
      binding: ConfirmBankAccountBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: AppRoutes.confirmWithDrawMoney,
      page: () => const ConfirmWithDrawMoneyScreen(),
      binding: ConfirmWithDrawMoneyBinding(),
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: AppRoutes.enterMoneyPayment,
      page: () => const EnterMoneyPaymentScreen(),
      binding: EnterMoneyPaymentBinding(),
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: AppRoutes.qrPayment,
      page: () => const QRPaymentScreen(),
      binding: QRPaymentBinding(),
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: AppRoutes.constituteEmail,
      page: () => const ConstituteEmailScreen(),
      binding: ConstituteEmailBinding(),
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
        name: AppRoutes.withdrawMoneySuccess,
        page: () => const WithdrawMoneySuccessScreen(),
        binding: WithdrawMoneySuccessBinding(),
        transition: Transition.noTransition,
        transitionDuration: const Duration(milliseconds: 0),
        fullscreenDialog: true),
    GetPage(
      name: AppRoutes.inverstment,
      page: () => const InvestmentPortfolioScreen(),
      binding: InvestmentPortfolioBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.moneyManager,
      page: () => const MoneyManagerScreen(),
      binding: MoneyManagerBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.confirmInformationEkyc,
      page: () => const ConfirmInformationEkycScreen(),
      binding: ConfirmInformationEkycBinding(),
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordBindings(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.verifyAccount,
      page: () => const VerifyAccountScreen(),
      binding: VerifyAccountBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.webViewEContact,
      page: () => const WebViewEContactScreen(),
      binding: WebViewEContactBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.trade,
      page: () => const TradeScreen(),
      binding: TradeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 150),
    ),
  ];
}
