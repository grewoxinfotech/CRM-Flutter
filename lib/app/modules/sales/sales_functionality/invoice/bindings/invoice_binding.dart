import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../../../crm/crm_functionality/sales_invoice/controller/sales_invoice_create_controller.dart';

class InvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesInvoiceCreateController>(
      () => SalesInvoiceCreateController(),
    );
  }
}
