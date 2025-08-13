import 'dart:ui';

import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:crm_flutter/app/data/network/system/function_model.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/views/customer_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/invoice/views/invoice_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/views/products_services_page.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_screen.dart';
import 'package:crm_flutter/app/test_screen.dart';
import 'package:get/get.dart';

class CrmFunctionController extends GetxController {
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
        title: 'Leads',
        iconPath: ICRes.leads,
        color: const Color(0xffFFBD21),
        screenBuilder: LeadScreen(),
      ),
      FunctionModel(
        title: 'Deals',
        iconPath: ICRes.leads,
        color: const Color(0xff28B999),
      ),
      FunctionModel(
        title: 'Tasks',
        iconPath: ICRes.task,
        color: const Color(0xff0AC947),
        screenBuilder: TaskScreen(),
      ),
      FunctionModel(
        title: 'Contacts',
        iconPath: ICRes.customer,
        color: const Color(0xff6D5DD3),
        count: 10,
      ),
      FunctionModel(
        title: 'Company',
        iconPath: ICRes.employees,
        color: const Color(0xff2B648F),
        count: 4,
      ),
      FunctionModel(
        title: 'Sales',
        iconPath: ICRes.clients,
        color: const Color(0xffFFCC01),
        count: 45,
        screenBuilder: ProductsServicesScreen(),
      ),
      FunctionModel(
        title: 'Contract',
        iconPath: ICRes.contract,
        color: const Color(0xff3400AD),
        count: 66,
      ),
      FunctionModel(
        title: 'Customer',
        iconPath: ICRes.customer,
        color: const Color(0xff00a7ad),
        count: 66,
        screenBuilder: CustomerScreen(),
      ),
      FunctionModel(
        title: 'Invoice',
        iconPath: ICRes.document,
        color: const Color(0xff00a7ad),
        count: 66,
        screenBuilder: InvoiceScreen(),
      ),
    ];
  }
}
