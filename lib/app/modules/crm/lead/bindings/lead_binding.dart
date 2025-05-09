import 'package:crm_flutter/app/modules/crm/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import 'package:get/get.dart';

class LeadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadController>(() => LeadController(), fenix: true);
    Get.lazyPut<TabBarController>(() => TabBarController(), fenix: true);
  }
}
