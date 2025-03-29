import 'package:crm_flutter/features/presentation/screens/lead/lead_add/leads_add_screen.dart';
import 'package:crm_flutter/features/presentation/screens/lead/lead_screen/lead_widgets.dart';
import 'package:crm_flutter/features/presentation/widgets/crm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadScreen extends StatelessWidget {
  const LeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
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
      body: CustomScrollView(
        slivers: [
          CrmAppBar(),
          SliverToBoxAdapter(
            child: const Column(
              children: [
                const SizedBox(height: 0),
                const LeadWidgets(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
