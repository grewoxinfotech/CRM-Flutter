import 'package:crm_flutter/features/presentation/screens/lead/lead_screen/features/lead_view_model.dart';
import 'package:flutter/material.dart';

class LeadWidgets extends StatelessWidget {
  const LeadWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    List<LeadViewModel> widgets = [];
    widgets = LeadViewModel.getWidgets();
    return Container(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widgets.length * 2 - 1,
        itemBuilder: (context, i) {
          if (i % 2 == 0) {
            int widgetIndex = i ~/ 2;
            return widgets[widgetIndex].widget;
          } else if (i % 2 != 0) {
            return const SizedBox(height: 20,);
          }
        },
      ),
    );
  }
}
