import 'package:crm_flutter/app/modules/screens/hrm/screens/leave_management/controllers/leave_controller.dart';
import 'package:get/get.dart';

class LeaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveController>(() => LeaveController());
  }
}
