import 'package:crm_flutter/app/modules/task/controller/task_controller.dart';
import 'package:get/get.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(()=>TaskController());
  }
}