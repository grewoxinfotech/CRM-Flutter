import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/service/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:crm_flutter/app/modules/super_admin/auth/views/login/login_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController()); // Inject Controller
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Center(child: CrmAppLogo(width: 120)),
    );
  }
}

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    splash();
  }

  void splash() async {
    await Future.delayed(const Duration(seconds:  1));
    bool isLogin = await SecureStorage.getLoggedIn();
    bool rememberMe = await SecureStorage.getRememberMe();
    String? token = await SecureStorage.getToken();

    if (isLogin == true && rememberMe && token != null && token.isNotEmpty) {
      Get.offAll(() => DashboardScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}
