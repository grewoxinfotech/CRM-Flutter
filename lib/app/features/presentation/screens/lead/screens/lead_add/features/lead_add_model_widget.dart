import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_add/features/lead_add_model_view.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:flutter/material.dart';

class LeadAddModelWidget extends StatelessWidget {
  const LeadAddModelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<LeadAddModelView> widgets = [];
    widgets = LeadAddModelView.getWidgets();
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
