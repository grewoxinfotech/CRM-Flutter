import 'package:crm_flutter/app/modules/deals/controllers/deal_controller.dart';
import 'package:get/get.dart';

class LeadBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<DealController>(() => DealController());
  }
}
