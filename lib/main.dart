import 'package:crm_flutter/app/config/themes/theme.dart';
import 'package:crm_flutter/app/features/presentation/screens/splash/splash_screen.dart';
import 'package:crm_flutter/app_test/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'services/internet_service.dart' show InternetService;

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Get.put(InternetService());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.black12),
  );

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: LightThemeMode,
      home: ListScreen(),
    ),
  );
}
