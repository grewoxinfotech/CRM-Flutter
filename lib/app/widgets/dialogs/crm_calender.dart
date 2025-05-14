import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CrmCalendar extends StatefulWidget {
  final Map<DateTime, String> attendanceMap; // 'present', 'absent', etc.

  const CrmCalendar({Key? key, required this.attendanceMap})
      : super(key: key);

  @override
  State<CrmCalendar> createState() => _CrmCalendarState();
}

class _CrmCalendarState extends State<CrmCalendar> {
  DateTime _currentMonth = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final totalDays = DateUtils.getDaysInMonth(_currentMonth.year, _currentMonth.month);

    final startingWeekday = firstDayOfMonth.weekday;
    final days = List<Widget>.generate(startingWeekday - 1, (_) => Container()); // Empty spaces

    for (int day = 1; day <= totalDays; day++) {
      final date = DateTime(_currentMonth.year, _currentMonth.month, day);
      final status = widget.attendanceMap[DateTime(date.year, date.month, date.day)];

      days.add(_buildDayCell(date, status));
    }

    return Column(
      children: [
        _buildMonthHeader(),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 7,
          children: days,
        ),
      ],
    );
  }

  Widget _buildMonthHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
            });
          },
          icon: Icon(Icons.arrow_back),
        ),
        Text(
          DateFormat.yMMMM().format(_currentMonth),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
            });
          },
          icon: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }

  Widget _buildDayCell(DateTime date, String? status) {
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
      case 'model':
        bgColor = Colors.orange.shade100;
        icon = Icons.beach_access;
        break;
      default:
        bgColor = Colors.grey.shade200;
    }

    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${date.day}'),
            if (icon != null) Icon(icon, size: 16),
          ],
        ),
      ),
    );
  }
}
