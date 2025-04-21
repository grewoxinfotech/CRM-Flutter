import 'package:crm_flutter/app/modules/super_admin/auth/controllers/auth_controller.dart';
import 'package:get/get.dart';

// auth_binding.dart
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
