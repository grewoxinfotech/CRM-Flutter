
import 'package:get/get.dart';

import '../../../../../data/network/crm/crm_system/label/service/label_service.dart';
import '../controllers/product_service_controller.dart';


class ProductServicesBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize services first
    Get.lazyPut<LabelService>(() => LabelService(), fenix: true);
    Get.lazyPut<ProductsServicesController>(() => ProductsServicesController(), fenix: true);
  }
}
