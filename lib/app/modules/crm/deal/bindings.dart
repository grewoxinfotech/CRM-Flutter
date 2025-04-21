import 'package:crm_flutter/app/modules/crm/deal/controllers/deal_controller.dart';
import 'package:get/get.dart';

class DealBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DealController>(() => DealController());
  }
}
