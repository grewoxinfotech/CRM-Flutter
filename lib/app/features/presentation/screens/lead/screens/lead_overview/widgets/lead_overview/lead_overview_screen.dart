import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_add/leads_add_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_file/features/lead_file_model_view.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_members/features/lead_member_model_view.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_notes/features/lead_note_model_view.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview/features/lead_overview_model_view.dart';
import 'package:crm_flutter/app/features/presentation/widgets/Crm_Bottem_navigation_Bar.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_button.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_teb_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadOverviewScreen extends StatelessWidget {
  final String leadId;
  final PageController _pageController = PageController();
  final CrmBottemNavigationBarController navigatorController = Get.put(
    CrmBottemNavigationBarController(),
  );

  LeadOverviewScreen({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    CrmTabBarController navigation_controller = Get.put(CrmTabBarController());
    final widgets = [
      LeadOverviewModelView(leadId: leadId),
      LeadMemberModelView(),
      LeadFileModelView(),
      LeadNoteModelView(),
    ];
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Lead",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        actions: [
          CrmButton(
            title: "To Deal",
            onPressed: () {},
            width: 80,
            height: 20,
            fontSize: 15,
            backgroundColor: Colors.green,
          ),
          SizedBox(width: 10),
        ],
        centerTitle: true,
        backgroundColor: Get.theme.colorScheme.surface,
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: Obx(() {
        return (navigation_controller.selectedIndex.value == 0)
            ? SizedBox()
            : FloatingActionButton(
              onPressed: () => Get.to(LeadsAddScreen()),
              child: CrmIcon(iconPath: ICRes.add, color: Colors.white),
              backgroundColor: Get.theme.colorScheme.primary,
            );
      }),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 40),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widgets.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      navigation_controller.selectedIndex == i;
                      return widgets[i];
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 5),
                CrmTabBar(
                  items: [
                    TabItem(iconPath: ICRes.edit, label: "Overview"),
                    TabItem(iconPath: ICRes.employee, label: "Lead Members"),
                    TabItem(iconPath: ICRes.file, label: "Files"),
                    TabItem(iconPath: ICRes.notifications, label: "Notes"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
