import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/key_res.dart';
import 'package:crm_flutter/app/modules/access/controller/access_controller.dart';
import 'package:crm_flutter/app/modules/communication/communication_functionality/chat/views/chat_user_screen.dart';
import 'package:crm_flutter/app/modules/home/views/home_screen.dart';
import 'package:crm_flutter/app/modules/hrm/hrm_functions/view/hrm_screen.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functions/view/purchase_screen.dart';
import 'package:crm_flutter/app/widgets/bar/app_bar/crm_app_bar.dart';
import 'package:crm_flutter/app/widgets/bar/navigation_bar/crm_navigation_Bar.dart';
import 'package:crm_flutter/app/widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/drawer/crm_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/database/helper/sqlite_db_helper.dart';
import '../../../data/database/storage/secure_storage_service.dart';
import '../../crm/crm_functions/view/crm_screen.dart';
import '../../purchase/purchase_functions/view/purchase_screen.dart';
import '../../sales/sales_functions/view/sales_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // Get.lazyPut<AccessController>(() => AccessController());
    super.initState();
    _initAccessController();
  }

  Future<void> _initAccessController() async {
    // Initialize AccessController if not already
    AccessController accessController;
    if (!Get.isRegistered<AccessController>()) {
      accessController = Get.put(AccessController());
    } else {
      accessController = Get.find<AccessController>();
    }

    // Fetch role data
    final DBHelper dbHelper = DBHelper();
    final user = await SecureStorage.getUserData();
    final roleId = user?.roleId;
    if (roleId == null) return;

    final roleData = await dbHelper.getRoleById(roleId);
    if (roleData == null) return;

    // Initialize AccessController with permissions
    accessController.init(roleData.permissions ?? {});

    // // Now safely update functions
    // updateFunctions(accessController);
  }

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());
    return Scaffold(
      key: KeyRes.scaffoldKey,
      extendBody: true,
      drawer: CrmDrawer(),
      appBar: CrmAppBar(),
      bottomNavigationBar: CrmNavigationBar(),
      body: Obx(() {
        if (navigationController.currentIndex.value == 0) {
          return HomeScreen();
        } else if (navigationController.currentIndex.value == 1) {
          return CrmScreen();
        } else if (navigationController.currentIndex.value == 2) {
          return SalesScreen();
        } else if (navigationController.currentIndex.value == 3) {
          return PurchaseScreen();
        } else if (navigationController.currentIndex.value == 4) {
          return HrmScreen();
        } else {
          return SizedBox();
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ChatUserScreen());
        },
        child: Icon(Icons.chat, color: ColorRes.white),
      ),
    );
  }
}
