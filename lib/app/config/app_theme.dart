import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/constants/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData themeCustom({
    required Brightness brightness,
    required Color colorError,
    required Color accentColor,
    required AppBarTheme appBarTheme,
  }) {
    return ThemeData(
      fontFamily: GoogleFonts.manrope().fontFamily,
      brightness: brightness,
      useMaterial3: true,
      textTheme: AppTextTheme.lightTextTheme,
      appBarTheme: appBarTheme,
      // primarySwatch: Colors.green,
      // colorSchemeSeed: Colors.redAccent,
    );
  }

  static ThemeData get lightTheme => themeCustom(
        brightness: Brightness.light,
        colorError: AppColors.appColorError,
        accentColor: Colors.grey,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.appColorWhite,
          titleTextStyle: AppTextStyles.s16w700.copyWith(
            color: AppColors.black14081C,
          ),
          iconTheme: const IconThemeData(
            color: AppColors.black0D0C0E,
          ),
          actionsIconTheme: const IconThemeData(
            color: AppColors.black0D0C0E,
          ),
        ),
        // schemeSeedColor: AppColors.schemeSeedColor,
        // accentColor: AppColors.grey737373,
        // useMaterial3: true,
        // borderRadius: AppNums.borderRadiusButton,
        // buttonBackground: AppColors.orangeFFAE58,
        // divider: AppColors.grey737373,
      );

  static ThemeData get darkTheme => themeCustom(
        brightness: Brightness.dark,
        colorError: Colors.green,
        accentColor: Colors.red,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.black0D0C0E,
          titleTextStyle: AppTextStyles.s16w700.copyWith(
            color: AppColors.appColorWhite,
          ),
          iconTheme: const IconThemeData(
            color: AppColors.appColorWhite,
          ),
          actionsIconTheme: const IconThemeData(
            color: AppColors.appColorWhite,
          ),
        ),
      );
}
