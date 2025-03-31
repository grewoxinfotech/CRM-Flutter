import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/features/lead_overview_model_widget.dart';
import 'package:flutter/material.dart';

class LeadOverviewModelView extends StatelessWidget {
  const LeadOverviewModelView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LeadOverviewModelWidget> widgets =
        LeadOverviewModelWidget.getWidgets();

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10), // Ensure no extra padding
      itemCount: widgets.length,
      separatorBuilder: (context, i) => const SizedBox(height: 10),
      itemBuilder: (context, i) => widgets[i].widget!,
    );
  }
}
