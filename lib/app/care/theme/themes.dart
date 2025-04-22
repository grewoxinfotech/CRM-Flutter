import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/font_res.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    scrolledUnderElevation: 0.0,
    backgroundColor: Colors.transparent,
    titleSpacing: 0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: ColorRes.textPrimary,
      fontFamily: FontRes.nuNunitoSans,
    ),
  ),
  fontFamily: FontRes.nuNunitoSans,
  primaryColor: ColorRes.primary,
  scaffoldBackgroundColor: ColorRes.background,

  colorScheme: ColorScheme.light(
    primary: ColorRes.primary,
    background: ColorRes.background,
    surface: ColorRes.surface,
    shadow: ColorRes.shadow,
    error: ColorRes.error,
    onPrimary: ColorRes.textPrimary,
    onSecondary: ColorRes.textSecondary,
    onBackground: ColorRes.textDisabled,
    onSurface: ColorRes.textSecondary,
    onError: ColorRes.error,
  ),

  dividerColor: ColorRes.divider,
  disabledColor: ColorRes.disabled,
  shadowColor: ColorRes.shadow,
  dialogBackgroundColor: ColorRes.overlay,

  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorRes.border),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorRes.primary),
    ),
  ),
);
