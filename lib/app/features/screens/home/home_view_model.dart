import 'package:crm_flutter/app/features/data/home/home_controller.dart';
import 'package:crm_flutter/app/features/screens/home/widget/attendance/attendance_widget.dart';
import 'package:crm_flutter/app/features/screens/home/widget/date_container_widget.dart';
import 'package:crm_flutter/app/features/screens/home/widget/functions/functions_widgets.dart';
import 'package:crm_flutter/app/features/screens/home/widget/wellcome_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends StatelessWidget {
  const HomeViewModel({super.key});

  @override
  Widget build(BuildContext context) {

    Get.lazyPut(() => HomeController());
    final homeController = Get.find<HomeController>();


    List widgets = [
      WellcomeText(),
      DateContainerWidget(fd: "Nov 16, 2020", ld: "Dec 16, 2020"),
      AttendanceWidget(),
      FunctionsWidgets(),
    ];

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 30),
            itemCount: widgets.length,
            separatorBuilder: (context, i) => const SizedBox(height: 10),
            itemBuilder: (context, i) => widgets[i],
          ),
        ),
      ],
    );
  }
}
