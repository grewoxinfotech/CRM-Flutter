import 'package:flutter/material.dart';

import '../../../../data/network/hrm/meeting/meeting_model.dart';

class MeetingCard extends StatelessWidget {
  final MeetingData meeting;

  const MeetingCard({Key? key, required this.meeting}) : super(key: key);

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return '';
    try {
      final parsedDate = DateTime.parse(date);
      return "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
    } catch (e) {
      return date;
    }
  }

  String formatTime(String? start, String? end) {
    if ((start == null || start.isEmpty) && (end == null || end.isEmpty)) {
      return '';
    }
    return "${start ?? ''} - ${end ?? ''}";
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
                color: Colors.purple[100],
                child: Icon(
                  Icons.video_call, // Meeting icon
                  color: Colors.purple[700],
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Meeting Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Meeting Title
                  Text(
                    meeting.title ?? 'Untitled Meeting',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Meeting Date
                  if (meeting.date != null)
                    Text(
                      "Date: ${formatDate(meeting.date)}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),

                  const SizedBox(height: 4),

                  // Meeting Time
                  if (meeting.startTime != null || meeting.endTime != null)
                    Text(
                      "Time: ${formatTime(meeting.startTime, meeting.endTime)}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),

                  const SizedBox(height: 4),

                  // Meeting Status
                  if (meeting.status != null && meeting.status!.isNotEmpty)
                    Text(
                      'Status: ${meeting.status}',
                      style: TextStyle(
                        fontSize: 13,
                        color:
                            meeting.status == "scheduled"
                                ? Colors.green[700]
                                : Colors.red[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  const SizedBox(height: 4),

                  // Department
                  if (meeting.department != null &&
                      meeting.department!.isNotEmpty)
                    Text(
                      'Dept: ${meeting.department}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.indigo,
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
