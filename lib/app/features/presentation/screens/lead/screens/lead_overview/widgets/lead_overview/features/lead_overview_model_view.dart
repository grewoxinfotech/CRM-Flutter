import 'package:crm_flutter/app/features/data/lead/lead_home/lead_controller.dart';
import 'package:crm_flutter/app/features/data/lead/lead_home/lead_model.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/widgets/lead_overview/features/lead_overview_model_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadOverviewModelView extends StatelessWidget {

  final String leadId;
  LeadOverviewModelView({super.key, required this.leadId});

  final LeadController leadController = Get.put(LeadController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (leadController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (leadController.leadsList.isEmpty) {
        return const Center(child: Text("No Lead Data Available."));
      }

      final lead = leadController.leadsList.firstWhere(
              (lead) => lead.id == leadId,
          orElse: () => LeadModel());

      if (lead.id == null) {
        return const Center(child: Text("Lead not found"));
      }

      final List<LeadOverviewModelWidget> widgets = LeadOverviewModelWidget.getWidgets(context, lead);



      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 15),
        itemCount: widgets.length,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, i) => const SizedBox(height: 5),
        itemBuilder: (context, i) => widgets[i].widget!,
      );
    });
  }
}
