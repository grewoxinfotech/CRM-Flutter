import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:crm_flutter/app/features/screens/splash/splash_screen.dart';
import 'package:crm_flutter/app/services/network_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => NetworkStatusService().init());
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
          primary: COLORRes.PRIMARY,
          outline: COLORRes.OUTLINE,
          surface: COLORRes.SURFACE,
          error: COLORRes.ERROR,
          shadow: COLORRes.SHEDOW,
          background: COLORRes.BACKGROUND,
        ),
      ),
      home: SplashScreen(),
    ),
  );
}
