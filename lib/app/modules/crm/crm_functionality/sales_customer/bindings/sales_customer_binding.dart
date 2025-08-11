import 'package:crm_flutter/app/data/network/sales_customer/controller/sales_customer_controller.dart';
import 'package:get/get.dart';

class SalesCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesCustomerController>(
      () => SalesCustomerController(),
    );
  }
} 