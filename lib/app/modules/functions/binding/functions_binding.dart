import 'package:crm_flutter/app/modules/functions/controller/function_controller.dart';
import 'package:get/get.dart';

class FunctionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FunctionController>(() => FunctionController());
  }
}
