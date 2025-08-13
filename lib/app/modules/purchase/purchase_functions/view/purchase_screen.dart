import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/purchase_function_controller.dart';
import '../widget/purchase_functions_widget.dart';

class PurchaseScreen extends StatelessWidget {
  final controller = Get.put(PurchaseFunctionController());

  PurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List widgets = [PurchaseFunctionsWidget()];

    return ViewScreen(
      itemCount: widgets.length,
      itemBuilder: (context, i) => widgets[i],
    );
  }
}
