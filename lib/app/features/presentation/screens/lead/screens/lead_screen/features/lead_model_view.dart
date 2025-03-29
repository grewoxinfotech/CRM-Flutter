import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_screen/features/lead_model_view.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead/screens/lead_screen/features/lead_model_widget.dart';
import 'package:flutter/material.dart';

class LeadModelView extends StatelessWidget {
  const LeadModelView({super.key});

  @override
  Widget build(BuildContext context) {
    List<LeadModelWidget> widgets = [];
    widgets = LeadModelWidget.getWidgets();
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
