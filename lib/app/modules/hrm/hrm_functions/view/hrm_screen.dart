import 'package:crm_flutter/app/modules/hrm/hrm_functions/controller/hrm_function_controller.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/hrm_function_widget.dart';



class HrmScreen extends StatelessWidget {
  final controller = Get.put(HrmFunctionController());

  HrmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List widgets = [HrmFunctionsWidget()];

    return ViewScreen(
      itemCount: widgets.length,
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
