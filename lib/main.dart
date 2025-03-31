
import 'package:crm_flutter/app/config/themes/theme.dart';
import 'package:crm_flutter/app/features/presentation/screens/auth/screens/login/login_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/splash/splash_screen.dart';
import 'package:crm_flutter/app/list_screen.dart';
import 'package:crm_flutter/app/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
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
