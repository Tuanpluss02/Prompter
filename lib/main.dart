import 'dart:io';

import 'package:base/app/app_links/app_links_handler.dart';
import 'package:base/app/config/app_binding.dart';
import 'package:base/app/config/app_theme.dart';
import 'package:base/di.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:error_stack/error_stack.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

typedef TextScaler = double Function(double);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ErrorStack.init();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DependencyInjection.init();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Platform.isAndroid ? Brightness.dark : null),
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  configLoading();
  runApp(
    EasyLocalization(
      startLocale: const Locale('vi'),
      supportedLocales: const [Locale('vi'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('vi'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinksHandler _appLinksHandler = Get.find<AppLinksHandler>();

  @override
  void initState() {
    super.initState();
    _appLinksHandler.registerListener();
  }

  @override
  void dispose() {
    _appLinksHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Prompter',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.lightTheme.copyWith(
        textTheme: AppTheme.lightTheme.textTheme.apply(fontFamily: GoogleFonts.manrope().fontFamily),
      ),
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      // navigatorObservers: [
      //   PosthogObserver(),
      // ],
      initialRoute: AppPages.initial,
      getPages: AppPages.appRoutes,
      defaultTransition: Transition.cupertino,
      initialBinding: AppBinding(),
      builder: EasyLoading.init(builder: ((context, widget) {
        return widget!;
      })),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.chasingDots
    ..loadingStyle = EasyLoadingStyle.custom
    ..radius = 10.0
    ..backgroundColor = Colors.transparent
    ..boxShadow = <BoxShadow>[]
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
