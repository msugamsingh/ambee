import 'package:ambee/utils/values/app_colors.dart';
import 'package:ambee/data/theme/text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    fontFamily: 'poppins',
    primaryColor:  AppColors.mainColorPrimary,
    brightness: Brightness.dark,
    // unselectedWidgetColor: Colors.blueGrey[400],
    useMaterial3: true,
    // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColorPrimary),
    scaffoldBackgroundColor: AppColors.bgColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.transparent,
      titleTextStyle: Styles.tsAppBar,
      elevation: 0,
      centerTitle: true,
      actionsIconTheme: IconThemeData(color: AppColors.white),
      iconTheme: IconThemeData(color: AppColors.white),
    ),
  );

  static const _lightColorText = TextStyle(color: AppColors.textColorSecondary);

  static final lightTheme = ThemeData(
    fontFamily: 'poppins',
    primaryColor:  AppColors.mainColorPrimary,
    // unselectedWidgetColor: Colors.blueGrey[400],
    brightness: Brightness.light,
    textTheme: const TextTheme(
      displayLarge: _lightColorText,
        displayMedium: _lightColorText,
        displaySmall: _lightColorText,
        headlineLarge: _lightColorText,
        headlineMedium: _lightColorText,
        headlineSmall: _lightColorText,
        labelLarge: _lightColorText,
        labelMedium: _lightColorText,
        labelSmall: _lightColorText,
        bodyLarge: _lightColorText,
        bodyMedium: _lightColorText,
        bodySmall: _lightColorText,
    ),
    useMaterial3: true,
    // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColorPrimary),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.transparent,
      titleTextStyle: Styles.tsAppBar,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
  );
}