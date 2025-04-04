import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_screen/features/lead_model_widget.dart';
import 'package:flutter/material.dart';

class LeadModelView extends StatelessWidget {
  const LeadModelView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LeadModelWidget> widgets = LeadModelWidget.getWidgets();
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widgets.length,
      padding: const EdgeInsets.symmetric(vertical: 20),
      separatorBuilder: (context, i) => const SizedBox(height: 15),
      itemBuilder: (context, i) => widgets[i].widget,
    );
  }
}
