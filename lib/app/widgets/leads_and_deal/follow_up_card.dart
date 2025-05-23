import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowUpCard extends StatelessWidget {
  final String? id;
  final String? subject;
  final String? dueDate;
  final String? priority;
  final String? taskReporter;
  final List<String>? assignedTo;
  final String? status;
  final Map<String, dynamic>? reminder;
  final Map<String, dynamic>? repeat;
  final String? description;
  final String? relatedId;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const FollowUpCard({
    super.key,
    this.id,
    this.subject,
    this.dueDate,
    this.priority,
    this.taskReporter,
    this.assignedTo,
    this.status,
    this.reminder,
    this.repeat,
    this.description,
    this.relatedId,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.onTap,
    this.onDelete,
    this.onEdit,
  });

  Color _getPriorityColor(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'highest':
        return ColorRes.error;
      case 'high':
        return ColorRes.warning;
      case 'medium':
        return Colors.orange;
      case 'low':
        return ColorRes.success;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return ColorRes.success;
      case 'in_progress':
        return ColorRes.warning;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return ColorRes.error;
      default:
        return Colors.grey;
    }
  }

  String _formatStatus(String? status) {
    if (status == null) return 'Unknown';
    return status.replaceAll('_', ' ').toTitleCase();
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Get.theme.colorScheme.onPrimary;
    final Color secondary = Get.theme.colorScheme.onSecondary;
    final Color borderColor = Get.theme.dividerColor;
    final priorityColor = _getPriorityColor(priority);
    final statusColor = _getStatusColor(status);

    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject & Priority
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subject ?? 'Untitled Task',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppPadding.small),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.small,
                    vertical: AppPadding.small / 2,
                  ),
                  decoration: BoxDecoration(
                    color: priorityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: priorityColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    priority?.toUpperCase() ?? 'NORMAL',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: priorityColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppPadding.small),

            // Due Date & Status
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: secondary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Due: ${dueDate ?? 'Not set'}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: secondary,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.small,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _formatStatus(status),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),

            if (description != null) ...[
              const SizedBox(height: AppPadding.small),
              Text(
                description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: secondary,
                ),
              ),
            ],

            Divider(color: borderColor, height: AppPadding.medium),

            // Metadata and Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Meta Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (reminder != null)
                      Row(
                        children: [
                          Icon(
                            Icons.notifications_outlined,
                            size: 12,
                            color: secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "${reminder!['reminder_date']} ${reminder!['reminder_time']}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: secondary,
                            ),
                          ),
                        ],
                      ),
                    Text(
                      "Created: ${createdAt ?? '-'}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: secondary,
                      ),
                    ),
                  ],
                ),

                // Action Buttons
                Row(
                  children: [
                    CrmIc(
                      iconPath: ICRes.edit,
                      color: ColorRes.success,
                      onTap: onEdit,
                    ),
                    AppSpacing.horizontalMedium,
                    CrmIc(
                      iconPath: ICRes.delete,
                      color: ColorRes.error,
                      onTap: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
} 