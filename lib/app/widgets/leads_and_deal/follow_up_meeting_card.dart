import 'package:crm_flutter/app/data/network/all/project/follow_up/follow_up_meeting_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FollowUpMeetingCard extends StatelessWidget {
  final FollowUpMeetingModel meeting;

  const FollowUpMeetingCard({super.key, required this.meeting});

  Color _getPriorityColor(String? priority) {
    switch (priority) {
      case 'highest':
        return Colors.red;
      case 'high':
        return Colors.orange;
      case 'medium':
        return Colors.amber;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatDateTime(String? date, String? time) {
    try {
      final dt = DateTime.parse('${date ?? ''}T${time ?? '00:00:00'}');
      return DateFormat('dd MMM yyyy • hh:mm a').format(dt);
    } catch (_) {
      return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priorityColor = _getPriorityColor(meeting.priority);

    return CrmCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  LucideIcons.heartHandshake,
                  color: priorityColor,
                  size: 26,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    meeting.title ?? 'No Title',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 6,
              children: [
                _buildInfoChip(
                  LucideIcons.calendar,
                  _formatDateTime(meeting.fromDate, meeting.fromTime),
                ),
                _buildInfoChip(
                  LucideIcons.clock,
                  _formatDateTime(meeting.toDate, meeting.toTime),
                ),
                _buildInfoChip(
                  LucideIcons.mapPin,
                  '${meeting.venue} (${meeting.location})',
                ),
                _buildInfoChip(
                  LucideIcons.activity,
                  meeting.meetingStatus?.replaceAll('_', ' ').toUpperCase() ??
                      'Unknown',
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (meeting.reminder?.reminderDate != null)
              _buildInfoChip(
                LucideIcons.bell,
                'Reminder: ${_formatDateTime(meeting.reminder?.reminderDate, meeting.reminder?.reminderTime)}',
              ),
            if (meeting.repeat?.repeatType != null)
              _buildInfoChip(
                LucideIcons.refreshCcw,
                'Repeats: ${meeting.repeat?.repeatType} (${meeting.repeat?.repeatTimes ?? '∞'} times)',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      labelStyle: const TextStyle(fontSize: 13),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
