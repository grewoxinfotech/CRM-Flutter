import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ThemeData LightThemeMode = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: Get.theme.colorScheme.surface,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.black,
      fontFamily: "NuNUnit_Sans",
    ),
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
