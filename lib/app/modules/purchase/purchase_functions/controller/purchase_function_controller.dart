import 'dart:ui';

import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:crm_flutter/app/data/network/system/function_model.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/hrm/branch/views/branch_screen.dart';
import 'package:crm_flutter/app/modules/hrm/department/views/department_screen.dart';
import 'package:crm_flutter/app/modules/hrm/designation/views/designation_screen.dart';
import 'package:crm_flutter/app/modules/hrm/employee/views/employee_screen.dart';
import 'package:crm_flutter/app/modules/hrm/holiday/views/holiday_screen.dart';
import 'package:crm_flutter/app/modules/hrm/leave_management/views/leave_screen.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/debit_notes/views/debit_note_screen.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/billing/views/billing_screen.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/vendor/views/vendor_screen.dart';
import 'package:crm_flutter/app/modules/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/views/customer_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/invoice/views/invoice_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/views/products_services_page.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_screen.dart';
import 'package:crm_flutter/app/test_screen.dart';
import 'package:get/get.dart';

class PurchaseFunctionController extends GetxController {
  final RxList<FunctionModel> functions = <FunctionModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    updateFunctions();
  }

  void updateFunctions() {
    // Initialize RolesService first
    if (!Get.isRegistered<RolesService>()) {
      Get.put(RolesService());
    }

    // Then initialize RoleController
    if (!Get.isRegistered<RoleController>()) {
      Get.put(RoleController());
    }

    // Initialize LabelService and LabelController
    if (!Get.isRegistered<LabelService>()) {
      Get.put(LabelService());
    }

    if (!Get.isRegistered<LabelController>()) {
      Get.put(LabelController());
    }

    functions.value = [
      FunctionModel(
        title: 'Vendor',
        iconPath: ICRes.clients,
        color: const Color(0xffFFCC01),
        count: 45,
        screenBuilder: VendorsScreen(),
      ),
      FunctionModel(
        title: 'Billing',
        iconPath: ICRes.customer,
        color: const Color(0xff00a7ad),
        count: 66,
        screenBuilder: BillingScreen(),
      ),
      FunctionModel(
        title: 'Debit Note',
        iconPath: ICRes.document,
        color: const Color(0xff68ad00),
        count: 66,
        screenBuilder: DebitNotesScreen(),
      ),
      FunctionModel(
        title: 'Employee',
        iconPath: ICRes.employee,
        color: const Color(0xffad0000),
        count: 66,
        screenBuilder: EmployeeScreen(),
      ),
      FunctionModel(
        title: 'Branch',
        iconPath: ICRes.employee,
        color: const Color(0xff0070ad),
        count: 66,
        screenBuilder: BranchScreen(),
      ),
      FunctionModel(
        title: 'Designation',
        iconPath: ICRes.employee,
        color: const Color(0xff2000ad),
        count: 66,
        screenBuilder: DesignationScreen(),
      ),
      FunctionModel(
        title: 'Department',
        iconPath: ICRes.employee,
        color: const Color(0xffad4800),
        count: 66,
        screenBuilder: DepartmentScreen(),
      ),
      FunctionModel(
        title: 'Holiday',
        iconPath: ICRes.calendar,
        color: const Color(0xff00ad09),
        count: 66,
        screenBuilder: HolidayScreen(),
      ),
      FunctionModel(
        title: 'Leave Management',
        iconPath: ICRes.calendar,
        color: const Color(0xff00ad99),
        count: 66,
        screenBuilder: LeaveScreen(),
      ),
    ];
  }
}
