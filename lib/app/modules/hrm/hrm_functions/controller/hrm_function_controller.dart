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

class HrmFunctionController extends GetxController {
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
      if (accessController.can(AccessModule.employee, AccessAction.view) ||
          accessController.can(AccessModule.employee, AccessAction.create) ||
          accessController.can(AccessModule.employee, AccessAction.update) ||
          accessController.can(AccessModule.employee, AccessAction.delete))
        FunctionModel(
          title: 'Employee',
          iconPath: ICRes.employee,
          color: const Color(0xffad0000),
          count: 66,
          screenBuilder: EmployeeScreen(),
        ),
      if (accessController.can(AccessModule.branch, AccessAction.view) ||
          accessController.can(AccessModule.branch, AccessAction.create) ||
          accessController.can(AccessModule.branch, AccessAction.update) ||
          accessController.can(AccessModule.branch, AccessAction.delete))
        FunctionModel(
          title: 'Branch',
          iconPath: ICRes.employee,
          color: const Color(0xff0070ad),
          count: 66,
          screenBuilder: BranchScreen(),
        ),
      if (accessController.can(AccessModule.designation, AccessAction.view) ||
          accessController.can(AccessModule.designation, AccessAction.create) ||
          accessController.can(AccessModule.designation, AccessAction.update) ||
          accessController.can(AccessModule.designation, AccessAction.delete))
        FunctionModel(
          title: 'Designation',
          iconPath: ICRes.employee,
          color: const Color(0xff2000ad),
          count: 66,
          screenBuilder: DesignationScreen(),
        ),
      if (accessController.can(AccessModule.department, AccessAction.view) ||
          accessController.can(AccessModule.department, AccessAction.create) ||
          accessController.can(AccessModule.department, AccessAction.update) ||
          accessController.can(AccessModule.department, AccessAction.delete))
        FunctionModel(
          title: 'Department',
          iconPath: ICRes.employee,
          color: const Color(0xffad4800),
          count: 66,
          screenBuilder: DepartmentScreen(),
        ),
      if (accessController.can(AccessModule.holiday, AccessAction.view) ||
          accessController.can(AccessModule.holiday, AccessAction.create) ||
          accessController.can(AccessModule.holiday, AccessAction.update) ||
          accessController.can(AccessModule.holiday, AccessAction.delete))
        FunctionModel(
          title: 'Holiday',
          iconPath: ICRes.calendar,
          color: const Color(0xff00ad09),
          count: 66,
          screenBuilder: HolidayScreen(),
        ),
      if (accessController.can(AccessModule.leaveList, AccessAction.view) ||
          accessController.can(AccessModule.leaveList, AccessAction.create) ||
          accessController.can(AccessModule.leaveList, AccessAction.update) ||
          accessController.can(AccessModule.leaveList, AccessAction.delete))
        FunctionModel(
          title: 'Leave Management',
          iconPath: ICRes.calendar,
          color: const Color(0xff00ad99),
          count: 66,
          screenBuilder: LeaveScreen(),
        ),
      if (accessController.can(AccessModule.payroll, AccessAction.view) ||
          accessController.can(AccessModule.payroll, AccessAction.create) ||
          accessController.can(AccessModule.payroll, AccessAction.update) ||
          accessController.can(AccessModule.payroll, AccessAction.delete))
        FunctionModel(
          title: 'Pay Roll',
          iconPath: ICRes.calendar,
          color: const Color(0xff6e00ad),
          count: 66,
          screenBuilder: PayrollScreen(),
        ),
      if (accessController.can(AccessModule.announcement, AccessAction.view) ||
          accessController.can(
            AccessModule.announcement,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.announcement,
            AccessAction.update,
          ) ||
          accessController.can(AccessModule.announcement, AccessAction.delete))
        FunctionModel(
          title: 'Announcement',
          iconPath: ICRes.notifications,
          color: const Color(0xff005fad),
          count: 66,
          screenBuilder: AnnouncementScreen(),
        ),
      if (accessController.can(AccessModule.meeting, AccessAction.view) ||
          accessController.can(AccessModule.meeting, AccessAction.create) ||
          accessController.can(AccessModule.meeting, AccessAction.update) ||
          accessController.can(AccessModule.meeting, AccessAction.delete))
        FunctionModel(
          title: 'Meeting',
          iconPath: ICRes.notifications,
          color: const Color(0xff3a00ad),
          count: 66,
          screenBuilder: MeetingScreen(),
        ),
      if (accessController.can(AccessModule.trainingSetup, AccessAction.view) ||
          accessController.can(
            AccessModule.trainingSetup,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.trainingSetup,
            AccessAction.update,
          ) ||
          accessController.can(AccessModule.trainingSetup, AccessAction.delete))
        FunctionModel(
          title: 'Training',
          iconPath: ICRes.notifications,
          color: const Color(0xffad0062),
          count: 66,
          screenBuilder: TrainingScreen(),
        ),
      if (accessController.can(AccessModule.document, AccessAction.view) ||
          accessController.can(AccessModule.document, AccessAction.create) ||
          accessController.can(AccessModule.document, AccessAction.update) ||
          accessController.can(AccessModule.document, AccessAction.delete))
        FunctionModel(
          title: 'Document',
          iconPath: ICRes.file,
          color: const Color(0xff00a7ad),
          count: 66,
          screenBuilder: DocumentScreen(),
        ),
      if (accessController.can(AccessModule.role, AccessAction.view) ||
          accessController.can(AccessModule.role, AccessAction.create) ||
          accessController.can(AccessModule.role, AccessAction.update) ||
          accessController.can(AccessModule.role, AccessAction.delete))
        FunctionModel(
          title: 'Role',
          iconPath: ICRes.file,
          color: const Color(0xff68ad00),
          count: 66,
          screenBuilder: RoleScreen(),
        ),
      if (accessController.can(
            AccessModule.attendanceList,
            AccessAction.view,
          ) ||
          accessController.can(
            AccessModule.attendanceList,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.attendanceList,
            AccessAction.update,
          ) ||
          accessController.can(
            AccessModule.attendanceList,
            AccessAction.delete,
          ))
        FunctionModel(
          title: 'Attendance',
          iconPath: ICRes.file,
          color: const Color(0xff0028ad),
          count: 66,
          screenBuilder: AttendanceScreen(),
        ),
      // if (accessController.can(AccessModule.taskCalendar, AccessAction.view) ||
      //     accessController.can(AccessModule.employee, AccessAction.create) ||
      //     accessController.can(AccessModule.employee, AccessAction.update) ||
      //     accessController.can(AccessModule.employee, AccessAction.delete))
      FunctionModel(
        title: 'Calendar',
        iconPath: ICRes.calendar,
        color: const Color(0xffad0000),
        count: 66,
        screenBuilder: CalendarScreen(),
      ),
    ];
  }
}
