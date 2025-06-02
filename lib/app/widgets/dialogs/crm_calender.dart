import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CrmCalendar extends StatefulWidget {
  final Map<DateTime, String> attendanceMap; // Keys: DateTime, Values: 'present', 'absent', etc.

  const CrmCalendar({Key? key, required this.attendanceMap}) : super(key: key);

  @override
  State<CrmCalendar> createState() => _CrmCalendarState();
}

class _CrmCalendarState extends State<CrmCalendar> {
  DateTime _currentMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final totalDays = DateUtils.getDaysInMonth(_currentMonth.year, _currentMonth.month);
    final startingWeekday = firstDay.weekday;

    final days = <Widget>[
      ...List.generate(startingWeekday - 1, (_) => const SizedBox()), // Fillers
      for (int day = 1; day <= totalDays; day++)
        _buildDayCell(DateTime(_currentMonth.year, _currentMonth.month, day)),
    ];

    return Obx(
      ()=> Column(
        children: [
          _buildMonthHeader(),
          const SizedBox(height: 8),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 7,
            children: days,
          ),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
            });
          },
        ),
        Text(
          DateFormat.yMMMM().format(_currentMonth),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            setState(() {
              _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
            });
          },
        ),
      ],
    );
  }

  Widget _buildDayCell(DateTime date) {
    final status = widget.attendanceMap[DateTime(date.year, date.month, date.day)];

    Color bgColor;
    IconData? icon;

    switch (status) {
      case 'present':
        bgColor = Colors.green.shade100;
        icon = Icons.check_circle;
        break;
      case 'absent':
        bgColor = Colors.red.shade100;
        icon = Icons.cancel;
        break;
      case 'leave':
        bgColor = Colors.orange.shade100;
        icon = Icons.beach_access;
        break;
      default:
        bgColor = Colors.grey.shade200;
    }

    return Obx(
      ()=> Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${date.day}', style: const TextStyle(fontWeight: FontWeight.bold)),
            if (icon != null) Icon(icon, size: 16),
          ],
        ),
      ),
    );
  }
}
