import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/dashboard/screens/home/widgets/goodmorningtext.dart';
import 'package:crm_flutter/app/modules/functions/functions_widget.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/revenue_card.dart';
import 'package:crm_flutter/app/widgets/punch_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // HomeController controller = Get.put(HomeController());
    AttendanceController attendanceController = Get.put(AttendanceController());
    List widgets = [
      Goodmorningtext(username: "Jeck"),
      CrmCard(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
        padding: EdgeInsets.all(AppPadding.medium),
        color: white,
        border: Border.all(color: divider),
        boxShadow: [],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Punch :",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: primary,
              ),
            ),
            Obx(
              () => Row(
                children: [
                  Text(
                    "Last ${attendanceController.punchTime}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color:
                          (attendanceController.isPunchedIn.value == true)
                              ? Colors.green.shade900
                              : Colors.red.shade900,
                    ),
                  ),
                  AppSpacing.horizontalSmall,
                  CrmButton(
                    width: 60,
                    title:
                        (attendanceController.isPunchedIn.value == true)
                            ? "Out"
                            : "In",
                    onTap: () => attendanceController.togglePunch(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      RevenueCard(),
      FunctionsWidget(),
      // AttendanceCard(percentage: 20, onPunchIn: (){}, onPunchOut: (){})
    ];

    return ViewScreen(
      itemCount: widgets.length,
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
