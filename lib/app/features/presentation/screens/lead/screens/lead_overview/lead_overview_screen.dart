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
<<<<<<< Updated upstream
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CrmAppBar(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        padding: const EdgeInsets.all(0),
        child: CrmBottomNavigationBar(),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LeadOverviewModelView(leadId: leadId),
=======
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 110),
                Expanded(child: const LeadOverviewModelView()), /// view all list in this said
              ],
            ),
            Column(
              children: [
                CrmAppBar(),
                const SizedBox(height: 5),
                CrmTabBar(
                  items: [
                    // all tabs items
                    TabItem(imagePath: IconResources.NOTIFICATION, label: "left"),
                  ],
                ),
                Expanded(child: SizedBox()), // size for content screen
                CrmBottomNavigationBar(), // bottem navigation bar
              ],
            ),
          ],
        ),
>>>>>>> Stashed changes
      ),
    );
  }
}