import 'package:crm_flutter/app/modules/screens/hrm/screens/attendance/controllers/attendance_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  AttendanceController attendanceController = Get.put(AttendanceController());
}
