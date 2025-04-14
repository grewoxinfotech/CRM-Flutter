import 'package:crm_flutter/app/modules/home/views/home_screen.dart';
import 'package:crm_flutter/app/widgets/app_bar/crm_app_bar.dart';
import 'package:crm_flutter/app/widgets/drawer/crm_drawer.dart';
import 'package:crm_flutter/app/widgets/navigation_bar/crm_navigation_Bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CrmDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Obx(() {
                if (navigationBarController.selectedIndex.value == 0) {
                  return HomeScreen();
                } else if (navigationBarController.selectedIndex.value == 1) {
                  return Center(child: Text("No Update"));
                } else if (navigationBarController.selectedIndex.value == 2) {
                  return Center(child: Text("No Update"));
                } else if (navigationBarController.selectedIndex.value == 3) {
                  return Center(child: Text("No Update"));
                } else if (navigationBarController.selectedIndex.value == 4) {
                  return Center(child: Text("No Update"));
                } else {
                  return SizedBox();
                }
              }),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [CrmAppBar(), CrmNavigationBar()],
            ),
          ],
        ),
      ),
    );
  }
}
