import 'dart:ui';

import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:crm_flutter/app/data/network/system/function_model.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/views/lead_screen.dart';
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
      //  screenBuilder: CustomerScreen(),
      ),
      FunctionModel(
        title: 'Debit Note',
        iconPath: ICRes.document,
        color: const Color(0xff00a7ad),
        count: 66,
        //screenBuilder: InvoiceScreen(),
      ),
    ];
  }
}
