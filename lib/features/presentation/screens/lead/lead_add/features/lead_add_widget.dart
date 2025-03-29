import 'package:crm_flutter/features/presentation/screens/lead/lead_add/features/lead_add_view_model.dart';
import 'package:crm_flutter/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';

class LeadAddWidget extends StatelessWidget {
  const LeadAddWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<LeadAddViewModel> widgets = [];
    widgets = LeadAddViewModel.getWidgets();
    return CrmContainer(
      padding: const EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widgets.length * 2 - 1,
        itemBuilder: (context, i) {
          if (i % 2 == 0) {
            int widgetIndex = i ~/ 2;
            return widgets[widgetIndex].widget;
          } else if (i % 2 != 0) {
            return const SizedBox(height: 20);
          }
        },
      ),
    );
  }
}
