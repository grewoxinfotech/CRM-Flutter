
import 'package:crm_flutter/app/features/presentation/screens/auth/screens/login/login_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/home/home_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  void splash() async {
    // if  {
    //   await Future.delayed(const Duration(seconds: 1));
      Get.offAll(HomeScreen());
    // } else {
    //   await Future.delayed(const Duration(seconds: 1));
    //   Get.offAll(LoginScreen());
    // }
  }
}
