import 'package:crm_flutter/app/modules/splash/controller/splash_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController()); // Inject Controller
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CrmAppLogo(width: 120)),
    );
  }
}