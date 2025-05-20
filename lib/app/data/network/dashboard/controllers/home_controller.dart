import 'package:crm_flutter/app/data/network/all/user_managemant/user_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final UserService userService = UserService();

  String getUserName() {
    return userService.user.value!.id.toString();
  }
}
