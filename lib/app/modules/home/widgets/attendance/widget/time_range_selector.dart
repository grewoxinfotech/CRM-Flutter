import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/attendance_widget.dart';

class TimeRangeSelector extends StatelessWidget {
  final Function(String) onSelected;

  TimeRangeSelector({super.key, required this.onSelected});

  // Removed "Year"

  // final RxString selectedItem = "Month".obs;

  @override
  Widget build(BuildContext context) {
    Get.put(AttendanceController());
    final AttendanceController controller = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          controller.items.map((item) {
            return GestureDetector(
              onTap: () {
                controller.selectedRange.value = item;
                onSelected(item); // Notify parent about selection
              },
              child: Obx(
                () => _text(item, controller.selectedRange.value == item),
              ),
            );
          }).toList(),
    );
  }

  Widget _text(String text, bool isSelected) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
        color:
            isSelected
                ? Get.theme.colorScheme.primary
                : Get.theme.colorScheme.onSecondary,
      ),
    );
  }
}
