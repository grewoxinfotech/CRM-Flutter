import 'package:crm_flutter/config/themes/theme.dart';
import 'package:crm_flutter/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.black12),
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: LightThemeMode,
      home: TestScreen(),
    ),
  );
}
