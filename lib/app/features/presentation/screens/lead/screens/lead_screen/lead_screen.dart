import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_add/leads_add_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_screen/features/lead_model_view.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadScreen extends StatelessWidget {
  const LeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: PreferredSize(preferredSize: const Size.fromHeight(70), child: CrmAppBar()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(LeadsAddScreen()),
        label: Text(
          "Add Leads",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        icon: Icon(color: Colors.black, Icons.add),
        backgroundColor: Get.theme.colorScheme.surface,
      ),
      body: const LeadModelView(),
    );
  }
}
