import 'package:crm_flutter/app/care/network/network_service.dart';
import 'package:crm_flutter/app/config/themes/theme.dart';
import 'package:crm_flutter/app/features/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => NetworkStatusService().init());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: LightThemeMode,
      home: SplashScreen(),
    ),
  );
}
