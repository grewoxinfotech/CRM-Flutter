import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/task/task/controller/task_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final String? id;
  final String? relatedId;
  final String? taskName;
  final String? file;
  final String? startDate;
  final String? dueDate;
  final Map<String, dynamic>? assignTo;
  final String? status;
  final String? priority;
  final String? description;
  final String? reminderDate;
  final String? clientId;
  final String? taskReporter;
  final String? createdBy;
  final String? updatedBy;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onEdit;
  final GestureTapCallback? onDelete;

  const TaskCard({
    super.key,
    this.id,
    this.relatedId,
    this.taskName,
    this.file,
    this.startDate,
    this.dueDate,
    this.assignTo,
    this.status,
    this.priority,
    this.description,
    this.reminderDate,
    this.clientId,
    this.taskReporter,
    this.createdBy,
    this.updatedBy,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  Color getPriorityColor(String p) {
    switch (p.toLowerCase()) {
      case 'high':
        return ColorRes.error;
      case 'medium':
        return ColorRes.warning;
      case 'low':
        return ColorRes.success;
      default:
        return ColorRes.secondary;
    }
  }

  Color getStatusColor(String s) {
    switch (s.toLowerCase()) {
      case 'pending':
        return ColorRes.warning;
      case 'completed':
        return ColorRes.success;
      case 'in_progress':
        return ColorRes.primary;
      default:
        return ColorRes.secondary;
    }
  }

  String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'No date';
    try {
      DateTime date;
      try {
        date = DateTime.parse(dateStr);
      } catch (e) {
        final parts = dateStr.split(' ');
        if (parts.length == 3) {
          date = DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        } else {
          throw FormatException('Invalid date format: $dateStr');
        }
      }
      return DateFormat('MMM dd, yyyy').format(date.toLocal());
    } catch (e) {
      print('Error formatting date: $dateStr - $e');
      return 'Invalid date';
    }
  }

  String getAssignedUsers() {
    if (assignTo == null || !assignTo!.containsKey('assignedusers')) {
      return 'No assignees';
    }
    final users = assignTo!['assignedusers'] as List;
    if (users.isEmpty) return 'No assignees';
    
    // Get the TaskController instance to access the helper methods
    final TaskController taskController = Get.find<TaskController>();
    
    // Convert IDs to usernames
    final usernames = users.map((id) => 
      taskController.getUsernameFromId(id.toString()) ?? id.toString()
    ).toList();
    
    if (usernames.length == 1) {
      return usernames[0];
    }
    
    return '${usernames[0]}, +${usernames.length - 1} more';
  }

  Widget _buildUserAvatar(String userId, {double size = 24}) {
    final TaskController taskController = Get.find<TaskController>();
    final username = taskController.getUsernameFromId(userId) ?? userId;
    
    // Check if user has image (you might need to modify this based on your data structure)
    final hasImage = false; // Replace with actual image check
    final String? imageUrl = null; // Replace with actual image URL

    if (hasImage && imageUrl != null) {
      return CircleAvatar(
        radius: size / 2,
        backgroundImage: NetworkImage(imageUrl),
      );
    } else {
      return CircleAvatar(
        radius: size / 2,
        backgroundColor: ColorRes.primary.withOpacity(0.2),
        child: Text(
          username.isNotEmpty ? username[0].toUpperCase() : '?',
          style: TextStyle(
            color: ColorRes.primary,
            fontSize: size * 0.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  Widget _buildAssigneesAvatars() {
    if (assignTo == null || !assignTo!.containsKey('assignedusers')) {
      return const SizedBox();
    }

    final users = assignTo!['assignedusers'] as List;
    if (users.isEmpty) return const SizedBox();

    return SizedBox(
      height: 24,
      child: Stack(
        children: [
          for (int i = 0; i < users.length && i < 3; i++)
            Positioned(
              left: i * 16.0,
              child: _buildUserAvatar(users[i].toString()),
            ),
          if (users.length > 3)
            Positioned(
              left: 3 * 16.0,
              child: CircleAvatar(
                radius: 12,
                backgroundColor: ColorRes.primary.withOpacity(0.1),
                child: Text(
                  '+${users.length - 3}',
                  style: TextStyle(
                    color: ColorRes.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAssigneesSection() {
    if (assignTo == null || !assignTo!.containsKey('assignedusers')) {
      return Text(
        'No assignees',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Get.theme.colorScheme.onSecondary,
        ),
      );
    }

    final users = assignTo!['assignedusers'] as List;
    if (users.isEmpty) {
      return Text(
        'No assignees',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Get.theme.colorScheme.onSecondary,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAssigneesAvatars(),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              Icons.people,
              size: 12,
              color: Get.theme.colorScheme.onSecondary,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                getAssignedUsers(),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Get.theme.colorScheme.onSecondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCreatorAvatar() {
    if (createdBy == null || createdBy!.isEmpty) {
      return const SizedBox(width: 20);
    }

    return Row(
      children: [
        _buildUserAvatar(createdBy!, size: 20),
        const SizedBox(width: 4),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Get.theme.colorScheme.onPrimary;
    final Color secondary = Get.theme.colorScheme.onSecondary;
    final Color borderColor = Get.theme.dividerColor;

    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    taskName ?? "Untitled Task",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(status ?? "").withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: getStatusColor(status ?? "").withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    status?.replaceAll('_', ' ').toUpperCase() ?? "UNKNOWN",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: getStatusColor(status ?? ""),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Priority & Dates
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: getPriorityColor(priority ?? "").withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: getPriorityColor(priority ?? "").withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    priority?.toUpperCase() ?? "UNKNOWN",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: getPriorityColor(priority ?? ""),
                    ),
                  ),
                ),
                if (startDate != null || dueDate != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: secondary.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      "${formatDate(startDate)} - ${formatDate(dueDate)}",
                      style: TextStyle(
                        fontSize: 12,
                        color: secondary,
                      ),
                    ),
                  ),
              ],
            ),

            // Description
            if (description != null && description!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.description,
                    size: 16,
                    color: secondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description!,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: secondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            Divider(color: borderColor, height: 16),

            // Updated Footer with Assignees, Creator and Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Meta Info
                Expanded(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      _buildAssigneesSection(),
                    const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildCreatorAvatar(),
                          Flexible(
                            child: Text(
                      "Created by: ${createdBy ?? '-'}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: secondary,
                      ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                    ),
                  ],
                  ),
                ),

                // Action Buttons
                Row(
                  children: [
                    CrmIc(
                      iconPath: ICRes.edit,
                      color: ColorRes.success,
                      onTap: onEdit,
                    ),
                    const SizedBox(width: 16),
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

