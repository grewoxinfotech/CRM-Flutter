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

  void splash() async {
    await Future.delayed(const Duration(seconds: 1));
    bool isLogin = await SecureStorage.getLoggedIn();
    bool rememberMe = await SecureStorage.getRememberMe();
    String? token = await SecureStorage.getToken();

    if (isLogin == true && rememberMe && token != null && token.isNotEmpty) {
      final roleController = Get.put(RolesController());
      final DBHelper _dbHelper = DBHelper();
      final user = await SecureStorage.getUserData();
      await roleController.loadInitial();
      if (roleController.items.isNotEmpty) {
        roleController.items.add(RoleData.fromJson(ClientPermissions.client));
        await _dbHelper.syncRolesFromAPI(roleController.items);
        final roles = await _dbHelper.getAllRoles();
        // print("[DEBUG]=> created Roles: ${roles.map((e) => e.toJson())}");
        // print("[DEBUG]=> created Roles: ${roles.length}");
        // print("[DEBUG]=> User Get By Id: ${user!.toJson()}");
        final role = await _dbHelper.getRoleById(user!.roleId!);
        // print("[DEBUG]=> Role Get By Id: ${role?.toJson()}");
      }
      Get.offAll(() => DashboardScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}
