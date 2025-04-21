import 'package:crm_flutter/app/data/service/user/user_service.dart';
import 'package:crm_flutter/app/modules/functions/controller/function_controller.dart';
import 'package:crm_flutter/app/modules/home/widgets/attendance/attendance_widget.dart';
import 'package:crm_flutter/app/modules/home/widgets/date_container_widget.dart';
import 'package:crm_flutter/app/modules/functions/widget/functions_widget.dart';
import 'package:crm_flutter/app/modules/home/widgets/wellcome_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(FunctionController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List widgets = [
      WellcomeText(),
      DateContainerWidget(fd: "Nov 16, 2020", ld: "Dec 16, 2020"),
      AttendanceWidget(),
     FunctionsWidget(),
    ];

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 30),
      shrinkWrap: true,
      itemCount: widgets.length,
      separatorBuilder: (context, i) => const SizedBox(height: 10),
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
