import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../sales/sales_functions/controller/sales_function_controller.dart';
import '../../../sales/sales_functions/widget/sales_functions_widget.dart';
import '../controller/crm_function_controller.dart';
import '../widget/crm_functions_widget.dart';

class CrmScreen extends StatelessWidget {
  final controller = Get.put(CrmFunctionController());

  CrmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List widgets = [CrmFunctionsWidget()];

    return ViewScreen(
      itemCount: widgets.length,
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
