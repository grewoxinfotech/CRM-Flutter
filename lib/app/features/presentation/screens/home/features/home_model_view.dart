import 'package:crm_flutter/app/features/presentation/screens/home/features/home_model_widget.dart';
import 'package:flutter/material.dart';

class HomeModelView extends StatelessWidget {
  const HomeModelView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget space() => const SizedBox(height: 10);
    List<HomeModelWidget> widgets = [];
    widgets = HomeModelWidget.getWidgets();
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

            return space();

          }
        },
      ),
    );
  }
}
