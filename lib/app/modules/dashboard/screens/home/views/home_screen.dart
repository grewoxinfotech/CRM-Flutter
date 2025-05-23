import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/dashboard/controllers/home_controller.dart';
import 'package:crm_flutter/app/modules/dashboard/screens/home/widgets/goodmorningtext.dart';
import 'package:crm_flutter/app/modules/functions/functions_widget.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/widgets/lead_list.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/widgets/punch_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:crm_flutter/app/widgets/common/display/revenue_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    List widgets = [
      Goodmorningtext(username: "Jeck"),
      RevenueCard(),
      FunctionsWidget(),
      Obx(
        () => PunchCard(
          punchTime: controller.attendanceController.punchTime.toString(),
          isPunchIn: controller.attendanceController.isPunchedIn.value,
          onPunch: () => controller.attendanceController.togglePunch(),
        ),
      ),
      CrmHeadline(
        title: "Leads",
        padding: EdgeInsets.symmetric(
          horizontal: AppMargin.medium + AppPadding.medium,
        ),
      ),
      LeadList(itemCount: 4),
    ];

    return ViewScreen(
      itemCount: widgets.length,
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
