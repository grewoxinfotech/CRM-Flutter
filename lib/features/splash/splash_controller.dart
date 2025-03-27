import 'package:crm/auth/login/login_screen.dart';
import 'package:crm/features/presentation/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  void splash() async {
    SharedPreferences id = await SharedPreferences.getInstance();
    if (id.get("islogin") == true) {
      await Future.delayed(const Duration(seconds: 1));
      Get.offAll(HomeScreen());
    } else {
      await Future.delayed(const Duration(seconds: 1));
      Get.offAll(LoginScreen());
    }
  }
}
