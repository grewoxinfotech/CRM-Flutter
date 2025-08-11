import 'package:crm_flutter/app/data/network/user/all_users/service/all_users_service.dart';
import 'package:crm_flutter/app/modules/users/controllers/users_controller.dart';
import 'package:get/get.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllUsersService>(() => AllUsersService(), fenix: true);
    Get.lazyPut<UsersController>(() => UsersController(), fenix: true);
  }
} 