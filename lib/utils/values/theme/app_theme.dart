import 'package:ambee/utils/values/app_colors.dart';
import 'package:ambee/utils/values/theme/text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final theme = ThemeData(
    fontFamily: 'poppins',
    primaryColor:  AppColors.mainColorPrimary,
    // unselectedWidgetColor: Colors.blueGrey[400],
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColorPrimary),
    scaffoldBackgroundColor: AppColors.bgColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.transparent,
      titleTextStyle: Styles.tsAppBar,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.white),
    ),
  );
}