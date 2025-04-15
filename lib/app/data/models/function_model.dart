import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/modules/deals/controllers/deal_controller.dart';
import 'package:crm_flutter/app/modules/deals/views/deal_screen.dart';
import 'package:crm_flutter/app/modules/leads/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/leads/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/task/controller/task_controller.dart';
import 'package:crm_flutter/app/modules/task/views/task_screen.dart';
import 'package:crm_flutter/test/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionModel {
  final String? title;
  final String? iconPath;
  final Color? color;
  final int? count;
  final Widget? screenBuilder;

  FunctionModel({
    this.title,
    this.iconPath,
    this.color,
    this.count,
    this.screenBuilder,
  });

  static List<FunctionModel> getFunctions() {
    List<FunctionModel> functions = [];
    final LeadController leadController = Get.put(LeadController());
    final DealController dealController = Get.put(DealController());
    final TaskController taskController = Get.put(TaskController());
    functions.add(
      FunctionModel(
        title: 'Leads',
        iconPath: ICRes.leads,
        color: const Color(0xffFFBD21),
        count: leadController.leadsList.length,
        screenBuilder: LeadsScreen(),
      ),
    );
    functions.add(
      FunctionModel(
        title: 'Deals',
        iconPath: ICRes.leads,
        color: const Color(0xff28B999),
        count: dealController.dealsList.length,
        screenBuilder: DealsScreen(),
      ),
    );

    functions.add(
      FunctionModel(
        title: 'Tast',
        iconPath: ICRes.taskBox,
        color: const Color(0xff0AC947),
        count: 2,
        screenBuilder: TestScreen(),
      ),
    );
    functions.add(
      FunctionModel(
        title: 'Tasks',
        iconPath: ICRes.task,
        color: const Color(0xff0AC947),
        count: taskController.tasksList.length,
        screenBuilder: TaskScreen(),
      ),
    );
    functions.add(
      FunctionModel(
        title: 'Customer',
        iconPath: ICRes.customer,
        color: const Color(0xff6D5DD3),
        count: 10,
      ),
    );
    functions.add(
      FunctionModel(
        title: 'Employee',
        iconPath: ICRes.employees,
        color: const Color(0xff2B648F),
        count: 4,
      ),
    );
    functions.add(
      FunctionModel(
        title: 'Clients',
        iconPath: ICRes.clients,
        color: const Color(0xffFFCC01),
        count: 45,
      ),
    );
    functions.add(
      FunctionModel(
        title: 'Contract',
        iconPath: ICRes.contract,
        color: const Color(0xff3400AD),
        count: 66,
      ),
    );
    return functions;
  }
}
