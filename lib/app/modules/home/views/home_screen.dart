import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/functions/widget/functions_widget.dart';
import 'package:crm_flutter/app/modules/hrm/attendance/widgets/attendance_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List widgets = [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.medium * 2,
          vertical: AppPadding.small,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi Evan, Welcome back!",
              style: TextStyle(
                fontSize: 14,
                color: Get.theme.colorScheme.onSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            AppSpacing.verticalSmall,
            Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: textPrimary,
              ),
            ),
          ],
        ),
      ),
      AttendanceCard(percentage: 10, onPunchIn: () {}, onPunchOut: () {}),
      FunctionsWidget(),
    ];

    return ViewScreen(
      itemCount: widgets.length,
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
