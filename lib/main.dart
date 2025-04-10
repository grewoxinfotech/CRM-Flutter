import 'package:crm_flutter/app/features/presentation/screens/splash/splash_screen.dart';
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
          primary: Color(0xff426DD4),
          outline: Color(0xffD8E0F0),
          surface: Color(0xffFFFFFF),
          error: Colors.redAccent,
          shadow: Color(0x10C4CBD6),
          background: Color(0xffF1F1F1),
        ),
      ),
      home: SplashScreen(),
    ),
  );
}

class TCRes {
  static Color TEXT_PRIMARY = Color(0xff0A1629);
  static Color TEXT_SECONDARY = Color(0xff7D8592);
}
