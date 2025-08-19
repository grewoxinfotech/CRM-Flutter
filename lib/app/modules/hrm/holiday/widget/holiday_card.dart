import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/network/hrm/hrm_system/holiday/holiday_model.dart';

class HolidayCard extends StatelessWidget {
  final HolidayData holiday;

  const HolidayCard({Key? key, required this.holiday}) : super(key: key);

  String formatDate(String? date) {
    if (date != null && date.isNotEmpty) {
      try {
        return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
      } catch (_) {
        return date;
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Icon Placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.green[100],
                child: Icon(Icons.event, color: Colors.green[700], size: 32),
              ),
            ),
            const SizedBox(width: 12),

            // Holiday Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Holiday Name
                  Text(
                    holiday.holidayName ?? 'Unnamed Holiday',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Leave Type
                  if (holiday.leaveType != null &&
                      holiday.leaveType!.isNotEmpty)
                    Text(
                      'Type: ${holiday.leaveType}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),

                  const SizedBox(height: 4),

                  // Dates
                  if (holiday.startDate != null)
                    Text(
                      'From: ${formatDateString(holiday.startDate)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  if (holiday.endDate != null)
                    Text(
                      'To: ${formatDateString(holiday.endDate)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
