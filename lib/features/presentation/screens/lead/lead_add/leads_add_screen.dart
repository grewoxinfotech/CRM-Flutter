import 'package:crm_flutter/features/presentation/screens/lead/lead_add/features/lead_add_view_model.dart';
import 'package:crm_flutter/features/presentation/screens/lead/lead_add/features/lead_add_widget.dart';
import 'package:crm_flutter/features/presentation/widgets/crm_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadsAddScreen extends StatelessWidget {
  const LeadsAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<LeadAddViewModel> widgets = [];
    widgets = LeadAddViewModel.getWidgets();
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      body: CustomScrollView(
        slivers: [
          CrmAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const LeadAddWidget(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
