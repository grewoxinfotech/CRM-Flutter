import 'package:crm_flutter/app/modules/crm/lead/controllers/lead_controller.dart';
import 'package:get/get.dart';

class LeadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadController>(() => LeadController());
  }
}
