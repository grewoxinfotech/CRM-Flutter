
import 'package:crm/features/data/resources/color_resources.dart';
import 'package:flutter/material.dart';

ThemeData LightThemeMode = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
  ),

  fontFamily: "NuNUnit_Sans",
  colorScheme: ColorScheme.light(
    brightness: Brightness.light,
    primary: ColorResources.PRIMARY,
    outline: ColorResources.OUTLINE,
    surface: ColorResources.SURFACE,
    error: ColorResources.ERROR,
    shadow: ColorResources.SHEDOW,
    background: ColorResources.BACKGROUND,
  ),
);
