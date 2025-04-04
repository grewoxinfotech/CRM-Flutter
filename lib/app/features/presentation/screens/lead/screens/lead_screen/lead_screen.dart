import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_add/leads_add_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_screen/features/lead_model_view.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_bar.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadScreen extends StatelessWidget {
  const LeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(LeadsAddScreen()),
        child: CrmIcon(iconPath: ICRes.add, color: Colors.white),
        backgroundColor: Get.theme.colorScheme.primary,
      ),
      body: SafeArea(
        child: Stack(children: [
          Column(
            children: [
              const SizedBox(height: 60,),
              const LeadModelView(),
            ],
          ),
          Column(
            children: [
              CrmAppBar(),
            ],
          ),
        ]),
      ),
    );
  }
}
