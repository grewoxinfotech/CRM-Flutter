import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:get/get.dart';

class LabelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LabelService>(() => LabelService(), fenix: true);
    Get.lazyPut<LabelController>(() => LabelController(), fenix: true);
  }
} 