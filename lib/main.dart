import 'package:crm_flutter/app/config/themes/theme.dart';
import 'package:crm_flutter/app/features/presentation/screens/splash/splash_screen.dart';
import 'package:crm_flutter/app_test/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/care/network/network_service.dart' show NetworkService;

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  Get.put(NetworkService());
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
