import 'dart:ui';

import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:crm_flutter/app/data/network/system/function_model.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/views/lead_screen.dart';
import 'package:crm_flutter/app/modules/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/credit_notes/views/credit_notes_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/customer/views/customer_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/invoice/views/invoice_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/views/products_services_page.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/revenue/views/revenue_screen.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_screen.dart';
import 'package:crm_flutter/app/test_screen.dart';
import 'package:get/get.dart';

import '../../../../care/constants/access_res.dart';
import '../../../../data/database/helper/sqlite_db_helper.dart';
import '../../../../data/database/storage/secure_storage_service.dart';
import '../../../access/controller/access_controller.dart';

class SalesFunctionController extends GetxController {
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
            AccessModule.productServices,
            AccessAction.view,
          ) ||
          accessController.can(
            AccessModule.productServices,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.productServices,
            AccessAction.update,
          ) ||
          accessController.can(
            AccessModule.productServices,
            AccessAction.delete,
          ))
        FunctionModel(
          title: 'Product & Service',
          iconPath: ICRes.product,
          color: const Color(0xffFFCC01),
          count: 45,
          screenBuilder: ProductsServicesScreen(),
        ),
      if (accessController.can(AccessModule.salesCustomer, AccessAction.view) ||
          accessController.can(
            AccessModule.salesCustomer,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.salesCustomer,
            AccessAction.update,
          ) ||
          accessController.can(AccessModule.salesCustomer, AccessAction.delete))
        FunctionModel(
          title: 'Customer',
          iconPath: ICRes.customer,
          color: const Color(0xff00a7ad),
          count: 66,
          screenBuilder: CustomerScreen(),
        ),
      if (accessController.can(AccessModule.salesInvoice, AccessAction.view) ||
          accessController.can(
            AccessModule.salesInvoice,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.salesInvoice,
            AccessAction.update,
          ) ||
          accessController.can(AccessModule.salesInvoice, AccessAction.delete))
        FunctionModel(
          title: 'Invoice',
          iconPath: ICRes.salesInvoice,
          color: const Color(0xff5f00ad),
          count: 66,
          screenBuilder: InvoiceScreen(),
        ),
      if (accessController.can(AccessModule.creditNotes, AccessAction.view) ||
          accessController.can(AccessModule.creditNotes, AccessAction.create) ||
          accessController.can(AccessModule.creditNotes, AccessAction.update) ||
          accessController.can(AccessModule.creditNotes, AccessAction.delete))
        FunctionModel(
          title: 'Credit Notes',
          iconPath: ICRes.creditNote,
          color: const Color(0xffad001a),
          count: 66,
          screenBuilder: CreditNoteScreen(),
        ),
      if (accessController.can(AccessModule.salesRevenue, AccessAction.view) ||
          accessController.can(
            AccessModule.salesRevenue,
            AccessAction.create,
          ) ||
          accessController.can(
            AccessModule.salesRevenue,
            AccessAction.update,
          ) ||
          accessController.can(AccessModule.salesRevenue, AccessAction.delete))
        FunctionModel(
          title: 'Revenue',
          iconPath: ICRes.revenue,
          color: const Color(0xff005fad),
          // color: const Color(0xff005fad),
          count: 66,
          screenBuilder: RevenueScreen(),
        ),
    ];
  }
}
