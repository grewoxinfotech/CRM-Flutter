import 'package:crm_flutter/features/presentation/widgets/crm_app_logo.dart';
import 'package:crm_flutter/features/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController controller = Get.put(
      SplashController(),
    ); // Inject Controller
    controller.splash();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CrmAppLogo(width: 100)),
    );
  }
}
