import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/widget/deal_overview.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/model/tab_bar_model.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/view/crm_tab_bar.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/member_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DealDetailScreen extends StatelessWidget {
  const DealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TabBarController tabBarController = Get.put(TabBarController());
    final DealModel deal = Get.arguments;

    List<Widget> widgets = [
      DealOverviewCard(deal: deal),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => MemberCard()),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => MemberCard()),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => MemberCard()),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => MemberCard()),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => MemberCard()),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => MemberCard()),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => MemberCard()),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Deal"),
        bottom: CrmTabBar(
          items: [
            TabBarModel(
              iconPath: LucideIcons.layoutDashboard,
              label: "Overview",
            ),
            TabBarModel(iconPath: LucideIcons.users2, label: "Members"),
            TabBarModel(iconPath: LucideIcons.creditCard, label: "Invoice"),
            TabBarModel(iconPath: LucideIcons.fileText, label: "Payment"),
            TabBarModel(iconPath: LucideIcons.stickyNote, label: "Notes"),
            TabBarModel(iconPath: LucideIcons.fileStack, label: "Files"),
            TabBarModel(iconPath: LucideIcons.history, label: "Activity"),
            TabBarModel(iconPath: LucideIcons.bellRing, label: "Follow-up"),
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
