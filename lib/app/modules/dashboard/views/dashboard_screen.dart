import 'package:crm_flutter/app/modules/dashboard/controllers/exit_controller.dart';
import 'package:crm_flutter/app/widgets/bar/app_bar/crm_app_bar.dart';
import 'package:crm_flutter/app/widgets/bar/navigation_bar/crm_navigation_Bar.dart';
import 'package:crm_flutter/app/widgets/drawer/crm_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Center(),
      Center(),
      Center(),
      Center(),
      Center(),
      Center(),
    ];
    return WillPopScope(
      onWillPop: () async {
        final shouldExit = await Get.put(ExitController()).handleBackPress();
        if (shouldExit) {
          SystemNavigator.pop(); // Close the app
        }
        return false;
      },
      child: Scaffold(
        appBar: CrmAppBar(),
        drawer: CrmDrawer(),
        drawerEdgeDragWidth: 250,
        extendBody: true,
        bottomNavigationBar: CrmNavigationBar(),
        body: PageView(children: screens),
      ),
    );
  }
}
