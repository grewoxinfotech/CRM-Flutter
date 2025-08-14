import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../contoller/vendor_controller.dart';

class VendorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorController>(() => VendorController());
  }
}
