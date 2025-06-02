import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/dashboard/screens/home/widgets/reminder_text.dart';
import 'package:crm_flutter/app/modules/functions/widget/functions_card.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/widgets/punch_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/revenue_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List widgets = [
      ReminderText(),
      RevenueCard(revenue: 100000),
      FunctionsCard(),
      PunchCard(),
    ];



    return ViewScreen(
      itemCount: widgets.length,
      padding: EdgeInsets.only(top: AppMargin.small, bottom: 300),
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
