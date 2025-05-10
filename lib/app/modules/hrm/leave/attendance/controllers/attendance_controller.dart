import 'package:get/get.dart';

class AttendanceController extends GetxController {
  final focusedDay = DateTime.now().obs;
  final selectedDay = Rxn<DateTime>();

  void onDaySelected(DateTime selected, DateTime focused) {
    selectedDay.value = selected;
    focusedDay.value = focused;
  }

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
