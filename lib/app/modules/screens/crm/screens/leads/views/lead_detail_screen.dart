import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/widgets/lead_overview.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/crm_tab_bar.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
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
            TabBarModel(icon: LucideIcons.layoutDashboard, label: "Overview"),
            TabBarModel(icon: LucideIcons.users2, label: "Members"),
            TabBarModel(icon: LucideIcons.activity, label: "Activity"),
            TabBarModel(icon: LucideIcons.fileText, label: "Notes"),
            TabBarModel(icon: LucideIcons.paperclip, label: "Files"),
            TabBarModel(icon: LucideIcons.phoneCall, label: "Follow-up"),
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
