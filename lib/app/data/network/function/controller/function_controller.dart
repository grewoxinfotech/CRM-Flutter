import 'dart:ui';

import 'package:crm_flutter/app/data/network/function/model/function_model.dart';
import 'package:crm_flutter/app/modules/screens/crm/views/crm_screen.dart';
import 'package:crm_flutter/app/modules/screens/hrm/views/hrm_screen.dart';
import 'package:crm_flutter/app/modules/screens/job/views/job_screen.dart';
import 'package:crm_flutter/app/modules/screens/purchase/views/purchase_screen.dart';
import 'package:crm_flutter/app/modules/screens/sales/views/sales_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FunctionController extends GetxController {
  final RxList<FunctionModel> functions = <FunctionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    updateFunctions();
  }

  void updateFunctions() {
    functions.value = [
      FunctionModel(
        title: 'CRM',
        icon: FontAwesomeIcons.at,
        color: const Color(0xff957489),
        screenBuilder: CrmScreen(),
      ),
      FunctionModel(
        title: 'HRM',
        icon: FontAwesomeIcons.at,
        color: const Color(0xff684008),
        screenBuilder: HrmScreen(),
      ),
      FunctionModel(
        title: 'Job',
        icon: FontAwesomeIcons.at,
        color: const Color(0xff234567),
        screenBuilder: JobScreen(),
      ),
      FunctionModel(
        title: 'Sales',
        icon: FontAwesomeIcons.at,
        color: const Color(0xff098765),
        screenBuilder: SalesScreen(),
      ),
      FunctionModel(
        title: 'Purchase',
        icon: FontAwesomeIcons.at,
        color: const Color(0xff284398),
        screenBuilder: PurchaseScreen(),
      ),FunctionModel(
        title: 'Purchase',
        icon: FontAwesomeIcons.at,
        color: const Color(0xff284398),
        screenBuilder: PurchaseScreen(),
      ),
    ];
  }
}
