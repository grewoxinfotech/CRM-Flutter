import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/data/database/helper/sqlite_db_helper.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:crm_flutter/app/modules/hrm/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/modules/super_admin/auth/views/login/login_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../care/json/client_access_res.dart';
import '../../data/network/hrm/hrm_system/role/role_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController()); // Inject Controller
    return Scaffold(
      backgroundColor: ColorRes.white,
      body: Center(child: CrmAppLogo(width: 120)),
    );
  }
}

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    splash();
  }

  // Future<void> splash() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   bool isLogin = await SecureStorage.getLoggedIn();
  //   bool rememberMe = await SecureStorage.getRememberMe();
  //   String? token = await SecureStorage.getToken();
  //
  //   if (isLogin == true && rememberMe && token != null && token.isNotEmpty) {
  //     final roleController = Get.put(RolesController());
  //     final DBHelper _dbHelper = DBHelper();
  //     final user = await SecureStorage.getUserData();
  //     await roleController.loadInitial();
  //     if (roleController.items.isNotEmpty) {
  //       roleController.items.add(RoleData.fromJson(ClientPermissions.client));
  //       await _dbHelper.syncRolesFromAPI(roleController.items);
  //       final roles = await _dbHelper.getAllRoles();
  //       print("[DEBUG]=> created Roles: ${roles.map((e) => e.toJson())}");
  //       print("[DEBUG]=> created Roles: ${roles.length}");
  //       print("[DEBUG]=> User Get By Id: ${user!.toJson()}");
  //       final role = await _dbHelper.getRoleById(user!.roleId!);
  //       print("[DEBUG]=> Role Get By Id: ${role?.toJson()}");
  //     }
  //     Get.offAll(() => DashboardScreen());
  //   } else {
  //     Get.offAll(() => LoginScreen());
  //   }
  // }

  Future<void> splash() async {
    await Future.delayed(const Duration(seconds: 1));
    bool isLogin = await SecureStorage.getLoggedIn();
    bool rememberMe = await SecureStorage.getRememberMe();
    String? token = await SecureStorage.getToken();

    if (isLogin && rememberMe && token != null && token.isNotEmpty) {
      final roleController = Get.put(RolesController());
      final DBHelper _dbHelper = DBHelper();
      final user = await SecureStorage.getUserData();

      // 🔄 Load roles with retry if needed
      await roleController.loadInitial();
      if (roleController.items.isEmpty) {
        print("[WARN] Roles list is empty, retrying loadInitial...");
        await roleController.loadInitial();
      }

      if (roleController.items.isNotEmpty) {
        // Add client role
        roleController.items.add(RoleData.fromJson(ClientPermissions.client));

        // ✅ Ensure DB sync is awaited
        await _dbHelper.syncRolesFromAPI(roleController.items);

        // Fetch all roles after sync
        final roles = await _dbHelper.getAllRoles();
        print("[DEBUG]=> created Roles: ${roles.map((e) => e.toJson())}");
        print("[DEBUG]=> created Roles Count: ${roles.length}");
        print("[DEBUG]=> User Get By Id: ${user?.toJson()}");

        // ✅ Fetch role for this user
        RoleData? role;
        if (user?.roleId != null) {
          role = await _dbHelper.getRoleById(user!.roleId!);
          if (role == null) {
            print("[ERROR] Role not found for roleId: ${user.roleId}");
          } else {
            print("[DEBUG]=> Role Get By Id: ${role.toJson()}");
          }
        }

        // ✅ Only go to dashboard if user + role are valid
        if (role != null) {
          Get.offAll(() => DashboardScreen());
        } else {
          Get.offAll(() => LoginScreen());
        }
      } else {
        print("[ERROR] No roles found after retry, redirecting to login.");
        Get.offAll(() => LoginScreen());
      }
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

}
