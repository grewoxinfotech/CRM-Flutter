
import 'package:get/get.dart';

import '../../../../../data/network/crm/contact/services/contact_services.dart';
import '../controller/contact_controller.dart';



class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactService>(() => ContactService());
    Get.lazyPut<ContactController>(() => ContactController());
  }
}