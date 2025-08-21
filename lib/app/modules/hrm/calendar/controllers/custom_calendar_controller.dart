import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CalendarController extends GetxController {
  var focusedMonth = DateTime.now().obs;
  var selectedDay = Rxn<DateTime>();

  final Map<DateTime, List<String>> events = {
    DateTime(2025, 8, 21): ['Meeting with HR', 'Client Call'],
    DateTime(2025, 8, 25): ['Project Deadline'],
    DateTime(2025, 9, 5): ['Team Lunch', 'Code Review'],
  };

  void previousMonth() {
    focusedMonth.value = DateTime(focusedMonth.value.year, focusedMonth.value.month - 1);
  }

  void nextMonth() {
    focusedMonth.value = DateTime(focusedMonth.value.year, focusedMonth.value.month + 1);
  }

  void selectDay(DateTime day) {
    selectedDay.value = day;
  }

  List<String> getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  List<Widget> buildCalendarDays() {
    final firstDayOfMonth = DateTime(focusedMonth.value.year, focusedMonth.value.month, 1);
    final lastDayOfMonth = DateTime(focusedMonth.value.year, focusedMonth.value.month + 1, 0);

    int startWeekday = firstDayOfMonth.weekday; // Monday=1
    int daysInMonth = lastDayOfMonth.day;

    List<Widget> dayWidgets = [];

    // Empty slots before the first day
    for (int i = 1; i < startWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    // Days of month
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDay = DateTime(focusedMonth.value.year, focusedMonth.value.month, day);
      bool isSelected = selectedDay.value != null &&
          selectedDay.value!.day == day &&
          selectedDay.value!.month == focusedMonth.value.month;

      dayWidgets.add(
        GestureDetector(
          onTap: () => selectDay(currentDay),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              "$day",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      );
    }

    return dayWidgets;
  }
}
