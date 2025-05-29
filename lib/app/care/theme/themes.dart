import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/font_res.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,

  // Enable Material 3
  fontFamily: FontRes.nuNunitoSans,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  dividerColor: AppColors.divider,
  disabledColor: AppColors.disabled,
  shadowColor:AppColors. shadow,
  dialogBackgroundColor: AppColors.overlay,

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.transparent,
    surfaceTintColor:AppColors. transparent,
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      color: AppColors.textPrimary,
    ),
  ),

  colorScheme: ColorScheme(
    brightness: Brightness.light,
    // theme colors
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    background:AppColors. background,
    surface:AppColors. surface,
    shadow: AppColors.shadow,
    error: AppColors.error,

    // text colors
    onPrimary: AppColors.textPrimary,
    onSecondary:AppColors. textSecondary,
    onBackground: AppColors.textDisabled,
    onSurface:AppColors. textSecondary,
    onError: AppColors.error,
  ),
);
