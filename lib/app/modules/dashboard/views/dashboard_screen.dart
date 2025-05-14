import 'package:crm_flutter/app/modules/crm/deal/views/deal_screen.dart';
import 'package:crm_flutter/app/modules/crm/lead/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/home/views/home_screen.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_screen.dart';
import 'package:crm_flutter/app/widgets/bar/app_bar/crm_app_bar.dart';
import 'package:crm_flutter/app/widgets/bar/navigation_bar/crm_navigation_Bar.dart';
import 'package:crm_flutter/app/widgets/bar/navigation_bar/navidation_controller.dart';
import 'package:crm_flutter/app/widgets/drawer/crm_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    List<Widget> screens = [
      HomeScreen(),
      LeadScreen(),
      DealScreen(),
      TaskScreen(),
    ];
    return Scaffold(
      extendBody: true,
      drawer: CrmDrawer(),
      appBar: CrmAppBar(),
      bottomNavigationBar: Obx(
        () => CrmNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (i) => controller.changeIndex(i),
        ),
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: controller.currentIndex,
        children: screens,
      ),
    );
  }
}
