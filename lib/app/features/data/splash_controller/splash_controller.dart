import 'package:crm_flutter/app/care/secure_storage.dart';
import 'package:crm_flutter/app/features/presentation/screens/auth/screens/login/login_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/dashboard/dashboard.dart';
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
      Get.offAll(() => Dashboard());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}
