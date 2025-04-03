import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_overview/screens/lead_file/features/lead_file_model_widget.dart';
import 'package:flutter/material.dart';

class LeadFileModelView extends StatelessWidget {
  const LeadFileModelView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LeadFileModelWidget> widgets = LeadFileModelWidget.getwidgets();
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (context, i) => const SizedBox(height: 20),
      itemBuilder: (context, i) {
        return widgets[i].widget;
      },
    );
  }
}
