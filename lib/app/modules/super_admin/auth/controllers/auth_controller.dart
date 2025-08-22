import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/database/helper/sqlite_db_helper.dart';
import 'package:crm_flutter/app/data/network/super_admin/auth/service/auth_service.dart';
import 'package:crm_flutter/app/modules/hrm/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/database/storage/secure_storage_service.dart';

class AuthController extends GetxController {
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final username = ''.obs;
  final token = ''.obs;
  final obscurePassword = true.obs;
  final rememberMe = false.obs;
  final authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final RolesController roleController = Get.put(RolesController());
  final DBHelper _dbHelper = DBHelper();

  void togglePasswordVisibility() => obscurePassword.toggle();

  void fillTestCredentials() {
    emailController.text = "g@yopmail.com";
    passwordController.text = "SuperAdmin@123";
  }

  Future<void> login(String userName, String password) async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    if (!rememberMe.value) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Remember Me",
        message: "Please enable 'Remember Me' to continue.",
        contentType: ContentType.help,
      );
      return;
    }

    isLoading.value = true;
    try {
      await authService.login(userName, password);
      final user = await SecureStorage.getUserData();
      await roleController.loadInitial();

      if (roleController.items.isNotEmpty) {
        await _dbHelper.syncRolesFromAPI(roleController.items);
        final roles = await _dbHelper.getAllRoles();
        print("[DEBUG]=> created Roles: ${roles.map((e) => e.toJson())}");
        print("[DEBUG]=> created Roles: ${roles.length}");
        print("[DEBUG]=> User Get By Id: ${user!.toJson()}");
        final role = await _dbHelper.getRoleById(user.roleId!);
        print("[DEBUG]=> Role Get By Id: ${role!.toJson()}");
      }
    } finally {
      isLoading.value = false;
    }
  }

  void logout() => authService.logout();

  @override
  void onClose() {
    emailController.clear();
    passwordController.clear();
    super.onClose();
  }
}
