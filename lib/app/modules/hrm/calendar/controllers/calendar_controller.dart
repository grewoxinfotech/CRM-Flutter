import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/calendar/calendar_model.dart';
import '../../../../data/network/hrm/calendar/calendar_service.dart';

class CalendarController extends PaginatedController<CalendarData> {
  final CalendarService _service = CalendarService();
  final String url = UrlRes.calendar;
  var error = ''.obs;

  final formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController labelController = TextEditingController();
  final TextEditingController colorController = TextEditingController();

  // Calendar State
  var focusedMonth = DateTime.now().obs;
  var selectedDay = Rxn<DateTime>();

  var swipeDirection = 0.obs; // -1 = left, +1 = right

  @override
  Future<List<CalendarData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchCalendars(page: page);
      return response;
    } catch (e) {
      print("Exception in fetchItems: $e");
      throw Exception("Exception in fetchItems: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }

  void resetForm() {
    nameController.clear();
    startDateController.clear();
    endDateController.clear();
    labelController.clear();
    colorController.clear();
  }

  /// ---- Calendar Navigation ----
  void previousMonth() {
    swipeDirection.value = 1;
    focusedMonth.value =
        DateTime(focusedMonth.value.year, focusedMonth.value.month - 1);
  }

  void nextMonth() {
    swipeDirection.value = -1;
    focusedMonth.value =
        DateTime(focusedMonth.value.year, focusedMonth.value.month + 1);
  }

  void selectDay(DateTime day) {
    selectedDay.value = day;
  }

  /// ---- Get events for a day ----
  List<CalendarData> getEventsForDay(DateTime day) {
    return items
        .where((event) =>
    event.startDate != null &&
        DateFormat("yyyy-MM-dd").format(DateTime.tryParse(event.startDate!)!) ==
            DateFormat("yyyy-MM-dd").format(day))
        .toList();
  }

  /// ---- Map labels to colors ----
  Color _getColorByLabel(String? label) {
    switch (label?.toLowerCase()) {
      case "personal":
        return Colors.blue;
      case "work":
        return Colors.green;
      case "important":
        return Colors.red;
      default:
        return Colors.orange; // other
    }
  }

  List<Color> getEventColorsForDay(DateTime day) {
    final eventsForDay = getEventsForDay(day);
    final colors = <Color>[];

    for (var e in eventsForDay) {
      final color = _getColorByLabel(e.label);
      if (!colors.contains(color)) {
        colors.add(color);
      }
    }

    return colors.take(4).toList(); // max 4 ticks
  }

  /// ---- CRUD METHODS ----
  Future<CalendarData?> getCalendarById(String id) async {
    try {
      final existingEvent = items.firstWhereOrNull((item) => item.id == id);
      if (existingEvent != null) {
        return existingEvent;
      } else {
        final event = await _service.getCalendarById(id);
        if (event != null) {
          items.add(event);
          items.refresh();
          return event;
        }
      }
    } catch (e) {
      print("Get calendar error: $e");
    }
    return null;
  }

  Future<bool> createCalendar(CalendarData event) async {
    try {
      final success = await _service.createCalendar(event);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create calendar error: $e");
      return false;
    }
  }

  Future<bool> updateCalendar(String id, CalendarData updatedEvent) async {
    try {
      final success = await _service.updateCalendar(id, updatedEvent);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedEvent;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update calendar error: $e");
      return false;
    }
  }

  Future<bool> deleteCalendar(String id) async {
    try {
      final success = await _service.deleteCalendar(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete calendar error: $e");
      return false;
    }
  }

  /// ---- Build Calendar Days ----
  List<Widget> buildCalendarDays() {
    final firstDayOfMonth =
    DateTime(focusedMonth.value.year, focusedMonth.value.month, 1);
    final lastDayOfMonth =
    DateTime(focusedMonth.value.year, focusedMonth.value.month + 1, 0);

    int startWeekday = firstDayOfMonth.weekday; // Monday=1
    int daysInMonth = lastDayOfMonth.day;

    List<Widget> dayWidgets = [];

    // Empty slots before 1st day
    for (int i = 1; i < startWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }

    // Days of current month
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDay =
      DateTime(focusedMonth.value.year, focusedMonth.value.month, day);
      bool isSelected = selectedDay.value != null &&
          selectedDay.value!.day == day &&
          selectedDay.value!.month == focusedMonth.value.month;

      final eventColors = getEventColorsForDay(currentDay);

      dayWidgets.add(
        GestureDetector(
          onTap: () => selectDay(currentDay),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange.withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$day",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.orange : Colors.black,
                  ),
                ),
                if (eventColors.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: eventColors
                          .map((c) => Container(
                        width: 20,
                        height: 3,
                        margin:
                        const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.rectangle,borderRadius: BorderRadius.circular(AppSpacing.large)
                        ),
                      ))
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }

    return dayWidgets;
  }
}
