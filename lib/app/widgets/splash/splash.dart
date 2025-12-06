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
import '../../data/network/subscription/plan_service.dart';
import '../../data/network/subscription/subscription_service.dart';
import '../../modules/subscription/views/plans_screen.dart';

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
    Get.put(RolesController());
    splash();
  }

  Future<void> splash() async {
    await Future.delayed(const Duration(seconds: 1));

    bool isLogin = await SecureStorage.getLoggedIn();
    bool rememberMe = await SecureStorage.getRememberMe();
    String? token = await SecureStorage.getToken();

    if (isLogin && rememberMe && token != null && token.isNotEmpty) {
      final roleController = Get.put(RolesController());
      final DBHelper _dbHelper = DBHelper();
      final user = await SecureStorage.getUserData();

      // 🔄 Try to load roles with retries (max 3 attempts)
      int retry = 0;
      bool rolesLoaded = false;

      while (!rolesLoaded && retry < 3) {
        print("[WARN] Roles empty, retrying... attempt ${retry + 1}");
        await roleController.loadInitial();

        print(
          " roleController.items after load: ${roleController.items.length}",
        );

        if (roleController.items.isNotEmpty) {
          rolesLoaded = true;
          break;
        }

        await Future.delayed(const Duration(seconds: 1));
        retry++;
      }

      if (roleController.items.isNotEmpty) {
        // Add client role
        roleController.items.add(RoleData.fromJson(ClientPermissions.client));

        // ✅ Sync roles into DB (inside transaction)
        await _dbHelper.syncRolesFromAPI(roleController.items);

        // Fetch all roles for debug
        final roles = await _dbHelper.getAllRoles();
        print(
          "=> created Roles: ${roles.map((e) => e.toJson()).toList()}",
        );
        print("=> created Roles Count: ${roles.length}");


        // ✅ Try fetching role for this user
        RoleData? role;
        if (user?.roleId != null) {
          role = await _dbHelper.getRoleById(user!.roleId!);
          if (role == null) {
            print("[ERROR] Role not found for roleId: ${user.roleId}");
          } else {

          }
        }

        // ✅ Check subscription before navigating to dashboard
        final subscriptionService = SubscriptionService();
        final hasActiveSubscription =
            await subscriptionService.hasActiveSubscription();

        if (hasActiveSubscription) {
          print(
            "[SUBSCRIPTION] Active subscription found, navigating to Dashboard",
          );
          Get.offAll(() => DashboardScreen());
        } else {
          print("[SUBSCRIPTION] No active subscription, navigating to Plans");
          Get.offAll(() => PlansScreen());
        }
      } else {
        print("[ERROR] No roles found after retries, redirecting to login.");
        Get.offAll(() => LoginScreen());
      }
    } else {
      Get.offAll(() => LoginScreen());
    }
  }
}
