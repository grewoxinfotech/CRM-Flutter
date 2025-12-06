import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../care/constants/size_manager.dart';
import '../../../../data/network/hrm/leave/leave/leave_model.dart';

class LeaveCard extends StatelessWidget {
  final LeaveData leave;

  const LeaveCard({Key? key, required this.leave}) : super(key: key);

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
    return GestureDetector(
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    // Icon Placeholder
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 60,
                        height: 60,
                        color: Colors.green[100],
                        child: Icon(
                          Icons.event_note,
                          color: Colors.green[700],
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Leave Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Leave Type
                          Text(
                            leave.leaveType?.toUpperCase() ?? 'LEAVE',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 6),

                          // Reason
                          if (leave.reason != null && leave.reason!.isNotEmpty)
                            Text(
                              'Reason: ${leave.reason}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                          const SizedBox(height: 4),

                          // Date Range
                          if (leave.startDate != null)
                            Text(
                              'From: ${formatDateString(leave.startDate)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),

                          const SizedBox(height: 4),
                          if (leave.endDate != null)
                            Text(
                              'To: ${formatDateString(leave.endDate)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),

                          const SizedBox(height: 4),

                          // Status + Half Day
                          Row(
                            children: [
                              Text(
                                'Status: ${leave.status ?? 'Pending'}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      (leave.status == 'approved')
                                          ? Colors.green
                                          : (leave.status == 'rejected')
                                          ? Colors.red
                                          : Colors.orange,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          // Created Date
                          if (leave.createdAt != null)
                            Text(
                              'Applied: ${formatDateString(leave.createdAt)}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (leave.isHalfDay == true) ...[
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Card(
                      color: Colors.deepPurple[50],
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        child: Text(
                          "Half Day",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple[700],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
