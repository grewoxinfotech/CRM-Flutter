import 'package:crm_flutter/app/modules/access/controller/access_controller.dart';
import 'package:crm_flutter/app/modules/home/views/home_screen.dart';
import 'package:crm_flutter/app/modules/hrm/hrm_functions/view/hrm_screen.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functions/view/purchase_screen.dart';
import 'package:crm_flutter/app/widgets/bar/app_bar/crm_app_bar.dart';
import 'package:crm_flutter/app/widgets/bar/navigation_bar/crm_navigation_Bar.dart';
import 'package:crm_flutter/app/widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/drawer/crm_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../crm/crm_functions/view/crm_screen.dart';
import '../../purchase/purchase_functions/view/purchase_screen.dart';
import '../../sales/sales_functions/view/sales_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<AccessController>(() => AccessController());
    final navigationController = Get.put(NavigationController());
    return Scaffold(
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
        } else if (navigationController.currentIndex.value == 5) {
          return Center(child: Text("No Update"));
        } else {
          return SizedBox();
        }
      }),
    );
  }
}
