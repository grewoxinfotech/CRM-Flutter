import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/json/client_access_res.dart';
import 'package:crm_flutter/app/data/database/helper/sqlite_db_helper.dart';
import 'package:crm_flutter/app/data/network/subscription/plan_service.dart';
import 'package:crm_flutter/app/data/network/super_admin/auth/service/auth_service.dart';
import 'package:crm_flutter/app/modules/hrm/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/database/storage/secure_storage_service.dart';
import '../../../../data/network/hrm/hrm_system/role/role_model.dart';
import '../../../../data/network/subscription/subscription_service.dart';
import '../../../subscription/views/plans_screen.dart';
import '../../../dashboard/views/dashboard_screen.dart';

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

    isLoading.value = true;
    try {
      final success = await authService.login(userName, password);
      if (success) {
        final user = await SecureStorage.getUserData();
        await roleController.loadInitial();
        if (roleController.items.isNotEmpty) {
          roleController.items.add(RoleData.fromJson(ClientPermissions.client));
          await _dbHelper.syncRolesFromAPI(roleController.items);
          final roles = await _dbHelper.getAllRoles();
          final role = await _dbHelper.getRoleById(user!.roleId!);
        }
        final subscriptionService = SubscriptionService();
        final hasActiveSubscription =
            await subscriptionService.hasActiveSubscription();

        if (hasActiveSubscription) {
          print(
            "[LOGIN] ✅ Active subscription found. Navigating to Dashboard...",
          );
          Get.offAll(() => DashboardScreen());
        } else {
          print(
            "[LOGIN] ⚠️ No active subscription found. Navigating to Plans screen...",
          );
          Get.offAll(() => PlansScreen());
        }
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
