import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/dashboard/screens/home/widgets/reminder_text.dart';
import 'package:crm_flutter/app/modules/functions/widget/functions_card.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/widgets/lead_list.dart';
import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/widgets/punch_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:crm_flutter/app/widgets/common/display/revenue_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List widgets = [
      ReminderText(),
      RevenueCard(),
      FunctionsCard(),
      PunchCard(),
      CrmHeadline(
        title: "Leads",
        padding: EdgeInsets.symmetric(
          horizontal: AppMargin.medium + AppPadding.medium,
        ),
      ),
      LeadList(itemCount: 3),
    ];

    return ViewScreen(
      itemCount: widgets.length,
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
