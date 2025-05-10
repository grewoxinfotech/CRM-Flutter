import 'package:crm_flutter/app/modules/home/views/home_screen.dart';
import 'package:crm_flutter/app/widgets/bar/app_bar/crm_app_bar.dart';
import 'package:crm_flutter/app/widgets/bar/navigation_bar/crm_navigation_Bar.dart';
import 'package:crm_flutter/app/widgets/drawer/crm_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          return Center(child: Text("No Update"));
        } else if (navigationController.currentIndex.value == 2) {
          return Center(child: Text("No Update"));
        } else if (navigationController.currentIndex.value == 3) {
          return Center(child: Text("No Update"));
        } else if (navigationController.currentIndex.value == 4) {
          return Center(child: Text("No Update"));
        } else {
          return SizedBox();
        }
      }),
    );
  }
}
