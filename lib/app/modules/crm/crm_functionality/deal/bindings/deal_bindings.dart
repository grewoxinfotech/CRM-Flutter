import 'package:get/get.dart';

import '../../../../../data/network/sales_invoice/controller/sales_invoice_controller.dart';

class DealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesInvoiceController>(() => SalesInvoiceController());
  }
}
