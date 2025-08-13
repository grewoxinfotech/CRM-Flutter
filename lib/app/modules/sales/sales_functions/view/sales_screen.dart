import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/sales_function_controller.dart';
import '../widget/sales_functions_widget.dart';

class SalesScreen extends StatelessWidget {
  final controller = Get.put(SalesFunctionController());

  SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List widgets = [SalesFunctionsWidget()];

    return ViewScreen(
      itemCount: widgets.length,
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
