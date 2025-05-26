import 'package:crm_flutter/app/modules/dashboard/screens/chats/widgets/chat_list.dart';
import 'package:crm_flutter/app/modules/dashboard/screens/home/views/home_screen.dart';
import 'package:crm_flutter/app/modules/dashboard/screens/profile/views/profile_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/widgets/lead_list.dart';
import 'package:crm_flutter/app/widgets/bar/app_bar/crm_app_bar.dart';
import 'package:crm_flutter/app/widgets/bar/navigation_bar/crm_navigation_Bar.dart';
import 'package:crm_flutter/app/widgets/bar/navigation_bar/navidation_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:crm_flutter/app/widgets/drawer/views/crm_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());
    final List<Widget> screens = [
      HomeScreen(),
      Center(child: Text("No Update")),
      Center(child: Text("No Update")),
      ChatList(),
      UserProfileScreen()
    ];
    return Scaffold(
      appBar: CrmAppBar(),
      drawer: CrmDrawer(),
      drawerEdgeDragWidth: 40,
      extendBody: true,
      bottomNavigationBar: Obx(
        () => CrmNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (e) => controller.changeIndex(e),
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
