import 'package:crm_flutter/app/modules/task/task/controller/task_controller.dart';
import 'package:get/get.dart';

class TaskBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TaskController>(()=>TaskController());
  }
}