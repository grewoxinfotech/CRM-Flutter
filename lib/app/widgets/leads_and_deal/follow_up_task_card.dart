import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/project/follow_up/follow_up_task_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FollowUpTaskCard extends StatelessWidget {
  final FollowUpTaskModel call;

  const FollowUpTaskCard({super.key, required this.call});

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

  String _formatDate(String? date) {
    if (date == null) return 'N/A';
    try {
      final d = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(d);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final priorityColor = _getPriorityColor(call.priority);

    return CrmCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(LucideIcons.phoneCall, color: priorityColor, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    call.subject ?? 'No Subject',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    call.description ?? 'No Description',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    children: [
                      _buildInfoIcon(
                        context,
                        LucideIcons.calendar,
                        _formatDate(call.dueDate),
                      ),
                      if (call.reminder?.reminderDate != null)
                        _buildInfoIcon(
                          context,
                          LucideIcons.bell,
                          '${_formatDate(call.reminder!.reminderDate)} at ${call.reminder!.reminderTime}',
                        ),
                      _buildInfoIcon(
                        context,
                        LucideIcons.circleDot,
                        call.status?.replaceAll('_', ' ').toUpperCase() ?? 'Unknown',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoIcon(BuildContext context, IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
