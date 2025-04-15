import 'package:crm_flutter/app/modules/home/widgets/date_container_widget.dart';
import 'package:crm_flutter/app/modules/home/widgets/functions_widget.dart';
import 'package:crm_flutter/app/modules/home/widgets/wellcome_text.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List widgets = [
      WellcomeText(),
      DateContainerWidget(fd: "Nov 16, 2020", ld: "Dec 16, 2020"),
      // AttendanceWidget(),
      FunctionsWidget(),
    ];

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 30),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widgets.length,
      separatorBuilder: (context, i) => const SizedBox(height: 10),
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
