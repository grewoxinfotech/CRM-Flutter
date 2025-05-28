import 'package:crm_flutter/app/modules/dashboard/controllers/exit_controller.dart';
import 'package:crm_flutter/app/modules/dashboard/screens/chats/widgets/chat_list.dart';
import 'package:crm_flutter/app/modules/dashboard/screens/home/views/home_screen.dart';
import 'package:crm_flutter/app/modules/dashboard/screens/profile/views/profile_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/company/widgets/company_list.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/custom_form/widgets/custom_form_list.dart';
import 'package:crm_flutter/app/widgets/bar/app_bar/crm_app_bar.dart';
import 'package:crm_flutter/app/widgets/bar/navigation_bar/crm_navigation_Bar.dart';
import 'package:crm_flutter/app/widgets/bar/navigation_bar/navidation_controller.dart';
import 'package:crm_flutter/app/widgets/drawer/views/crm_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController controller = Get.put(NavigationController());
    final ExitController exitController = Get.put(ExitController());

    final List<Widget> screens = [
      HomeScreen(),
      CompanyList(),
      CustomFormList(),
      ChatList(),
      UserProfileScreen(),
    ];
    return WillPopScope(
      onWillPop: () async {

        final shouldExit = await exitController.handleBackPress();
        if (shouldExit) {
          SystemNavigator.pop(); // Close the app
        }
        return false;
      },
      child: Scaffold(
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
      ),
    );
  }
}
