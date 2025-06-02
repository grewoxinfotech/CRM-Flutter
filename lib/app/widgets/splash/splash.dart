import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/routes/app_routes.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController()); // Inject Controller
    return Scaffold(
      backgroundColor: AppColors.surface,
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
    await Future.delayed(const Duration(seconds: 1));
    bool isLogin = await SecureStorage.getLoggedIn();
    String? token = await SecureStorage.getToken();
    (isLogin == false && token != "")
        ? Get.offAllNamed(AppRoutes.dashboard)
        : Get.offAllNamed(AppRoutes.login);
  }
}
