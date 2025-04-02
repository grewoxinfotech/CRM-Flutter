import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/features/lead_overview_model_view.dart';
import 'package:crm_flutter/app/features/presentation/widgets/Crm_Bottem_navigation_Bar.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_bar.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_teb_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadOverviewScreen extends StatelessWidget {
  final String leadId;

  LeadOverviewScreen({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
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

      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        padding: const EdgeInsets.all(0),
        child: CrmBottomNavigationBar(),
      ),

      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 40),
                Expanded(child: LeadOverviewModelView(leadId: leadId)),
              ],
            ),
            Column(
              children: [
                const SizedBox(height: 5),
                CrmTabBar(
                  items: [
                    TabItem(imagePath: "assets/icons/white.svg", label: "Overview"),
                    TabItem(imagePath: "assets/icons/white.svg", label: "Lead Members"),
                    TabItem(imagePath: "assets/icons/white.svg", label: "Files"),
                    TabItem(imagePath: "assets/icons/white.svg", label: "Estimates"),
                    TabItem(imagePath: "assets/icons/white.svg", label: "Reminder"),
                    TabItem(imagePath: "assets/icons/white.svg", label: "Notes"),
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
