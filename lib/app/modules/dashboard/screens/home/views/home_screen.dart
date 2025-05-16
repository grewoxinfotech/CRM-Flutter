import 'package:crm_flutter/app/modules/functions/functions_widget.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List widgets = [
      // AttendanceCard(percentage: 10, onPunchIn: () {}, onPunchOut: () {}),
      FunctionsWidget(),
    ];

    return ViewScreen(
      itemCount: widgets.length,
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
