import 'package:crm_flutter/app/modules/auth/views/login/login_screen.dart';
import 'package:crm_flutter/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:crm_flutter/app/data/service/secure_storage_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    splash();
  }

  void splash() async {
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Optional delay for splash animation

    bool rememberMe = await SecureStorage.getRememberMe();
    String? token = await SecureStorage.getToken();

    if (rememberMe && token != null && token.isNotEmpty) {
      Get.offAll(() => DashboardScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}
