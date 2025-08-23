import 'dart:ui';

import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:crm_flutter/app/data/network/system/function_model.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:crm_flutter/app/modules/access/controller/access_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/hrm/announcement/views/announcement_screen.dart';
import 'package:crm_flutter/app/modules/hrm/attendance/views/attendance_screen.dart';
import 'package:crm_flutter/app/modules/hrm/branch/views/branch_screen.dart';
import 'package:crm_flutter/app/modules/hrm/department/views/department_screen.dart';
import 'package:crm_flutter/app/modules/hrm/designation/views/designation_screen.dart';
import 'package:crm_flutter/app/modules/hrm/document/screen/document_screen.dart';
import 'package:crm_flutter/app/modules/hrm/employee/views/employee_screen.dart';
import 'package:crm_flutter/app/modules/hrm/holiday/views/holiday_screen.dart';
import 'package:crm_flutter/app/modules/hrm/leave_management/views/leave_screen.dart';
import 'package:crm_flutter/app/modules/hrm/payroll/views/payroll_screen.dart';
import 'package:crm_flutter/app/modules/hrm/role/views/role_screen.dart';
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

import '../../../../care/constants/access_res.dart';
import '../../../../data/database/helper/sqlite_db_helper.dart';
import '../../../../data/database/storage/secure_storage_service.dart';
import '../../../hrm/calendar/views/calendar_screen.dart';
import '../../../hrm/meeting/views/meeting_screen.dart';
import '../../../hrm/training/views/training_screen.dart';

class PurchaseFunctionController extends GetxController {
  final RxList<FunctionModel> functions = <FunctionModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _initAccessController();
  }

  Future<void> _initAccessController() async {
    // Initialize AccessController if not already
    AccessController accessController;
    if (!Get.isRegistered<AccessController>()) {
      accessController = Get.put(AccessController());
    } else {
      accessController = Get.find<AccessController>();
    }

    // Fetch role data
    final DBHelper dbHelper = DBHelper();
    final user = await SecureStorage.getUserData();
    final roleId = user?.roleId;
    if (roleId == null) return;

    final roleData = await dbHelper.getRoleById(roleId);
    if (roleData == null) return;

    // Initialize AccessController with permissions
    accessController.init(roleData.permissions ?? {});

    // Now safely update functions
    updateFunctions(accessController);
  }

  void updateFunctions(AccessController accessController) {
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

    if (!Get.isRegistered<AccessController>()) {
      Get.put(AccessController());
    }

    functions.value = [
      if (accessController.can(
            AccessModule.purchaseVendor,
            AccessAction.view,
          ) ||
          accessController.can(
            AccessModule.purchaseVendor,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.purchaseVendor,
            AccessAction.update,
          ) ||
          accessController.can(
            AccessModule.purchaseVendor,
            AccessAction.delete,
          ))
        FunctionModel(
          title: 'Vendor',
          iconPath: ICRes.clients,
          color: const Color(0xffFFCC01),
          count: 45,
          screenBuilder: VendorsScreen(),
        ),
      if (accessController.can(
            AccessModule.purchaseBilling,
            AccessAction.view,
          ) ||
          accessController.can(
            AccessModule.purchaseBilling,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.purchaseBilling,
            AccessAction.update,
          ) ||
          accessController.can(
            AccessModule.purchaseBilling,
            AccessAction.delete,
          ))
        FunctionModel(
          title: 'Billing',
          iconPath: ICRes.customer,
          color: const Color(0xff00a7ad),
          count: 66,
          screenBuilder: BillingScreen(),
        ),
      if (accessController.can(AccessModule.debitNote, AccessAction.view) ||
          accessController.can(AccessModule.debitNote, AccessAction.create) ||
          accessController.can(AccessModule.debitNote, AccessAction.update) ||
          accessController.can(AccessModule.debitNote, AccessAction.delete))
        FunctionModel(
          title: 'Debit Note',
          iconPath: ICRes.document,
          color: const Color(0xff68ad00),
          count: 66,
          screenBuilder: DebitNotesScreen(),
        ),
    ];
  }
}
