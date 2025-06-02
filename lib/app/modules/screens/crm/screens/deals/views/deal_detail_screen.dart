import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/widget/deal_overview.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/crm_tab_bar.dart';
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
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => Text(i.toString())),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => Text(i.toString())),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => Text(i.toString())),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => Text(i.toString())),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => Text(i.toString())),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => Text(i.toString())),
      ViewScreen(itemCount: 5, itemBuilder: (context, i) => Text(i.toString())),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Deal"),
        bottom: CrmTabBar(
          items: [
            TabBarModel(
              icon: LucideIcons.layoutDashboard,
              label: "Overview",
            ),
            TabBarModel(icon: LucideIcons.users2, label: "Members"),
            TabBarModel(icon: LucideIcons.creditCard, label: "Invoice"),
            TabBarModel(icon: LucideIcons.fileText, label: "Payment"),
            TabBarModel(icon: LucideIcons.stickyNote, label: "Notes"),
            TabBarModel(icon: LucideIcons.fileStack, label: "Files"),
            TabBarModel(icon: LucideIcons.history, label: "Activity"),
            TabBarModel(icon: LucideIcons.bellRing, label: "Follow-up"),
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
