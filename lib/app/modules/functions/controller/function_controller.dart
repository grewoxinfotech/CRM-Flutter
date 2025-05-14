import 'dart:ui';

import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/network/system/function_model.dart';
import 'package:crm_flutter/app/modules/account/sales/view/sales_customer/views/customer_screen.dart';
import 'package:crm_flutter/app/modules/crm/deal/views/deal_screen.dart';
import 'package:crm_flutter/app/modules/crm/lead/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/hrm/attendance/views/attendance_screen.dart';
import 'package:crm_flutter/app/modules/hrm/leave/views/leave_screen.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_screen.dart';
import 'package:crm_flutter/app/test_screen.dart';
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
        title: 'Leads',
        iconPath: ICRes.leads,
        color: const Color(0xffFFBD21),
        screenBuilder: LeadScreen(),
      ),
      FunctionModel(
        title: 'Deals',
        iconPath: ICRes.leads,
        color: const Color(0xff28B999),
        screenBuilder: DealScreen(),
      ),
      FunctionModel(
        title: 'Tasks',
        iconPath: ICRes.task,
        color: const Color(0xff0AC947),
        screenBuilder: TaskScreen(),
      ),
      FunctionModel(
        title: 'Attendance',
        iconPath: ICRes.calendar,
        color: const Color(0xff623434),
        screenBuilder: AttendanceScreen(),
      ),
      FunctionModel(
        title: 'Leaves',
        iconPath: ICRes.logout,
        color: const Color(0xff0AC947),
        screenBuilder: LeaveScreen(),
      ),
      FunctionModel(
        title: 'Customer',
        iconPath: ICRes.customer,
        color: const Color(0xff6D5DD3),
        screenBuilder: CustomerScreen(),
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
