import 'package:crm_flutter/features/presentation/screens/home/home_view_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget space() => const SizedBox(height: 20);
    List<HomeViewModel> widgets = [];
    widgets = HomeViewModel.getWidgets();
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
