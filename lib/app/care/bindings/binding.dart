import 'package:get/get.dart';
import 'package:crm_flutter/app/modules/deals/controllers/deal_controller.dart';
import 'package:crm_flutter/app/modules/leads/controllers/lead_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DealController>(() => DealController());
    Get.lazyPut<LeadController>(() => LeadController());
  }
}
