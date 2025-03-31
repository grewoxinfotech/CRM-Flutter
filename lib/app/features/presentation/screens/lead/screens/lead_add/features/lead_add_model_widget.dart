import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_add/features/lead_add_model_view.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';

class LeadAddModelWidget extends StatelessWidget {
  const LeadAddModelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LeadAddModelView> widgets = LeadAddModelView.getWidgets();
    return CrmContainer(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      child: ListView.separated(
        itemCount: widgets.length,
        separatorBuilder: (context, i) => const SizedBox(height: 10),
        itemBuilder: (context, i) => widgets[i].widget,
      ),
    );
  }
}
