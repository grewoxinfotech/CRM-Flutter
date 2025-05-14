import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/font_res.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,

  // Enable Material 3
  fontFamily: FontRes.nuNunitoSans,
  primaryColor: primary,
  scaffoldBackgroundColor: background,
  dividerColor: divider,
  disabledColor: disabled,
  shadowColor: shadow,
  dialogBackgroundColor: overlay,

  appBarTheme: AppBarTheme(
    backgroundColor: transparent,
    surfaceTintColor: transparent,
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      color: textPrimary,
    ),
  ),

  colorScheme: ColorScheme(
    brightness: Brightness.light,
    // theme colors
    primary: primary,
    secondary: secondary,
    background: background,
    surface: surface,
    shadow: shadow,
    error: error,

    // text colors
    onPrimary: textPrimary,
    onSecondary: textSecondary,
    onBackground: textDisabled,
    onSurface: textSecondary,
    onError: error,
  ),
);
