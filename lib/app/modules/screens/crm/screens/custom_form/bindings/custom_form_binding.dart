import 'package:crm_flutter/app/modules/screens/crm/screens/custom_form/controllers/custom_form_controller.dart';
import 'package:get/get.dart';

class CustomFormBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CustomFormController>(() => CustomFormController());
  }
}