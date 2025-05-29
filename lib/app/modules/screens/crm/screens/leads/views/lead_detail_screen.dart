import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/widgets/lead_overview.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/model/tab_bar_model.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/view/crm_tab_bar.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/member_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LeadDetailScreen extends StatelessWidget {
  const LeadDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabBarController = Get.put(TabBarController());
    final LeadModel lead = Get.arguments;

    List<Widget> widgets = [
      LeadOverviewCard(lead: lead),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => Text(i.toString())),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => Text(i.toString())),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => Text(i.toString())),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => Text(i.toString())),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => Text(i.toString())),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Lead"),
        leading: CrmBackButton(),
        bottom: CrmTabBar(
          items: [
            TabBarModel(
              iconPath: LucideIcons.layoutDashboard,
              label: "Overview",
            ),
            TabBarModel(iconPath: LucideIcons.users2, label: "Members"),
            TabBarModel(iconPath: LucideIcons.activity, label: "Activity"),
            TabBarModel(iconPath: LucideIcons.fileText, label: "Notes"),
            TabBarModel(iconPath: LucideIcons.paperclip, label: "Files"),
            TabBarModel(iconPath: LucideIcons.phoneCall, label: "Follow-up"),
          ],
        ),
      ),
      body: PageView(
        controller: tabBarController.pageController,
        onPageChanged: tabBarController.onPageChanged,
        children: widgets,
      ),
    );
  }
}
