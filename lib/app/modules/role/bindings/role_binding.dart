import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:crm_flutter/app/modules/role/controllers/role_controller.dart';
import 'package:get/get.dart';

class RoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RolesService>(() => RolesService(), fenix: true);
    Get.lazyPut<RoleController>(() => RoleController(), fenix: true);
  }
} 