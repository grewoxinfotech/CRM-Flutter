import 'dart:ui';

import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/database/helper/sqlite_db_helper.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:crm_flutter/app/data/network/system/function_model.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/company/view/company_screen.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/contact/views/contact_screen.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/views/customer_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/invoice/views/invoice_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/views/products_services_page.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_screen.dart';
import 'package:crm_flutter/app/test_screen.dart';
import 'package:get/get.dart';

import '../../../access/controller/access_controller.dart';
import '../../crm_functionality/deal/views/deal_screen.dart';

class CrmFunctionController extends GetxController {
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
      if (accessController.can(AccessModule.lead, AccessAction.view) ||
          accessController.can(AccessModule.lead, AccessAction.create) ||
          accessController.can(AccessModule.lead, AccessAction.update) ||
          accessController.can(AccessModule.lead, AccessAction.delete))
        FunctionModel(
          title: 'Leads',
          iconPath: ICRes.lead,
          color: const Color(0xffFFBD21),
          screenBuilder: LeadScreen(),
        ),
      if (accessController.can(AccessModule.deal, AccessAction.view) ||
          accessController.can(AccessModule.deal, AccessAction.create) ||
          accessController.can(AccessModule.deal, AccessAction.update) ||
          accessController.can(AccessModule.deal, AccessAction.delete))
        FunctionModel(
          title: 'Deals',
          iconPath: ICRes.deal,
          color: const Color(0xff28B999),
          screenBuilder: DealScreen(),
        ),

      FunctionModel(
        title: 'Company',
        iconPath: ICRes.company,
        color: const Color(0xff2B648F),
        count: 4,
        screenBuilder: CompanyScreen(),
      ),
      FunctionModel(
        title: 'Contacts',
        iconPath: ICRes.contact,
        color: const Color(0xff6D5DD3),
        count: 10,
        screenBuilder: ContactScreen(),
      ),
      if (accessController.can(AccessModule.task, AccessAction.view) ||
          accessController.can(AccessModule.task, AccessAction.create) ||
          accessController.can(AccessModule.task, AccessAction.update) ||
          accessController.can(AccessModule.task, AccessAction.delete))
        FunctionModel(
          title: 'Tasks',
          iconPath: ICRes.task,
          color: const Color(0xffad5c00),
          screenBuilder: TaskScreen(),
        ),


    ];
  }
}
