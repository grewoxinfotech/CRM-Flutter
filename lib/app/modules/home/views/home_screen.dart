import 'package:crm_flutter/app/modules/functions/controller/function_controller.dart';
import 'package:crm_flutter/app/modules/functions/widget/functions_widget.dart';
import 'package:crm_flutter/app/modules/home/widgets/attendance/views/attendance_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(FunctionController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List widgets = [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "Hi Evan, Welcome back!",
              style: TextStyle(
                fontSize: 16,
                color: Get.theme.colorScheme.onSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: Get.theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
      // DateContainerWidget(fd: "Nov 16, 2020", ld: "Dec 16, 2020"),
      AttendanceWidget(),
      FunctionsWidget(),
    ];

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10),
      shrinkWrap: true,
      itemCount: widgets.length,
      separatorBuilder: (context, i) => const SizedBox(height: 10),
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
