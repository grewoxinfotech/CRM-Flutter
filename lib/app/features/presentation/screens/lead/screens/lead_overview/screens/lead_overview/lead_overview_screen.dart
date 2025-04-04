import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_add/leads_add_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/screens/lead_file/features/lead_file_model_view.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/screens/lead_overview/features/lead_overview_model_view.dart';
import 'package:crm_flutter/app/features/presentation/widgets/Crm_Bottem_navigation_Bar.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_bar.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_teb_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadOverviewScreen extends StatelessWidget {
  final String leadId;

  LeadOverviewScreen({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    CrmTabBarController navigation_controller = Get.put(CrmTabBarController());
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Lead",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: Get.theme.colorScheme.surface,
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: Obx(()=> (navigation_controller.selectedIndex.value == 0)? SizedBox() : FloatingActionButton(
        onPressed: () => Get.to(LeadsAddScreen()),
        child: CrmIcon(iconPath: ICRes.add, color: Colors.white),
        backgroundColor: Get.theme.colorScheme.primary,
      ),),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 40),
                // Expanded(child: LeadOverviewModelView(leadId: leadId)),
                Expanded(child: Obx(()=> (navigation_controller.selectedIndex.value == 0)?LeadOverviewModelView(leadId: leadId):LeadFileModelView())),
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
