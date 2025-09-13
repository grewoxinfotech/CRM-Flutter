import 'dart:ui';

import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:crm_flutter/app/data/network/system/function_model.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/views/products_services_page.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_screen.dart';
import 'package:crm_flutter/app/test_screen.dart';
import 'package:get/get.dart';

import '../../crm/crm_functionality/company/view/company_screen.dart';
import '../../crm/crm_functionality/contact/views/contact_screen.dart';
import '../../crm/crm_functionality/deal/views/deal_screen.dart';

class FunctionController extends GetxController {
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
        iconPath: ICRes.lead,
        color: const Color(0xffFFBD21),
        screenBuilder: LeadScreen(),
      ),
      FunctionModel(
        title: 'Deals',
        iconPath: ICRes.lead,
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
        title: 'Contacts',
        iconPath: ICRes.customer,
        color: const Color(0xff6D5DD3),
        count: 10,
        screenBuilder: ContactScreen(),
      ),
      FunctionModel(
        title: 'Company',
        iconPath: ICRes.company,
        color: const Color(0xff2B648F),
        count: 4,
        screenBuilder: CompanyScreen(),
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
        title: 'Test',
        iconPath: ICRes.taskBox,
        color: const Color(0xff0AC947),
        count: 2,
        screenBuilder: TestScreen(),
      ),
    ];
  }
}
