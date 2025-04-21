import 'dart:ui';

import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/models/system/function_model.dart';
import 'package:crm_flutter/app/modules/crm/deal/controllers/deal_controller.dart';
import 'package:crm_flutter/app/modules/crm/deal/views/deal_screen.dart';
import 'package:crm_flutter/app/modules/crm/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/crm/lead/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/task/task/controller/task_controller.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_screen.dart';
import 'package:crm_flutter/test_screen.dart';
import 'package:get/get.dart';

class FunctionController extends GetxController{
  final RxList<FunctionModel> functions = <FunctionModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    updateFunctions();
  }
  void updateFunctions (){
    functions.value = [ FunctionModel(
      title: 'Leads',
      iconPath: ICRes.leads,
      color: const Color(0xffFFBD21),
      count: Get.put(LeadController()).lead.length,
      screenBuilder: LeadScreen(),
    ),
      FunctionModel(
        title: 'Deals',
        iconPath: ICRes.leads,
        color: const Color(0xff28B999),
        count: Get.put(DealController()).deal.length,
        screenBuilder: DealsScreen(),
      ),
      FunctionModel(
        title: 'Tasks',
        iconPath: ICRes.task,
        color: const Color(0xff0AC947),
        count: Get.put(TaskController()).task.length,
        screenBuilder: TaskScreen(),
      ),
      FunctionModel(
        title: 'Customer',
        iconPath: ICRes.customer,
        color: const Color(0xff6D5DD3),
        count: 10,
      ),
      FunctionModel(
        title: 'Employee',
        iconPath: ICRes.employees,
        color: const Color(0xff2B648F),
        count: 4,
      ),
      FunctionModel(
        title: 'Clients',
        iconPath: ICRes.clients,
        color: const Color(0xffFFCC01),
        count: 45,
      ),
      FunctionModel(
        title: 'Contract',
        iconPath: ICRes.contract,
        color: const Color(0xff3400AD),
        count: 66,
      ),
      FunctionModel(
        title: 'Test',
        iconPath: ICRes.taskBox,
        color: const Color(0xff0AC947),
        count: 2,
        screenBuilder: TestScreen(),
      ),
    ];
  }
}