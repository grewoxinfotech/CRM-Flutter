import 'package:crm_flutter/app/modules/screens/crm/screens/contect/controllers/contact_controller.dart';
import 'package:get/get.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }
}
