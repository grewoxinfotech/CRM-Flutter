import 'package:get/get.dart';
import 'package:crm_flutter/app/data/network/crm/follow_Ups/follow_ups_task/controller/followup_task_controller.dart';
import 'package:crm_flutter/app/data/network/crm/follow_Ups/follow_ups_task/service/followup_task_service.dart';

class FollowUpTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowUpTaskService>(() => FollowUpTaskService());
    Get.lazyPut<FollowUpTaskController>(() => FollowUpTaskController());
  }
} 