import 'package:crm_flutter/app/modules/home/views/home_screen.dart';
import 'package:crm_flutter/app/widgets/app_bar/crm_app_bar.dart';
import 'package:crm_flutter/app/widgets/navigation_bar/crm_navigation_Bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  // final NavigationBarController navigationBarController = Get.put(
  //   NavigationBarController(),
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Obx(
                () =>
                    navigationBarController.selectedIndex.value == 0
                        ? const HomeScreen()
                        : SizedBox(),
              ),
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
