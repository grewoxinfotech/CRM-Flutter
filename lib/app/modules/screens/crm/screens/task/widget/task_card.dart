import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskCard extends StatelessWidget {
  final String? id;
  final String? relatedId;
  final String? taskName;
  final String? category;
  final String? project;
  final String? lead;
  final String? file;
  final String? startDate;
  final String? dueDate;
  final String? assignTo;
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
    this.category,
    this.project,
    this.lead,
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
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color getStatusColor(String s) {
    switch (s.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'completed':
        return Colors.green;
      case 'in progress':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color textPrimary = Get.theme.colorScheme.onPrimary;
    Color textSecondary = Get.theme.colorScheme.onSecondary;

    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.small),
        margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
        child: Column(
          children: [
            AppBar(
              leading: Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  child: Text(
                    "G",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Get.theme.colorScheme.surface,
                    ),
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    createdBy.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Get.theme.colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    taskName.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Get.theme.colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      onEdit?.call();
                    } else if (value == 'delete') {
                      onDelete?.call();
                    }
                  },
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                ),
              ],
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(19),
              ),
            ),
            Row(
              children: [
                SizedBox(width: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusColor(status!).withAlpha(50),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    status!,
                    style: TextStyle(
                      color: getStatusColor(status!),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: getPriorityColor(priority!).withAlpha(50),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    priority!,
                    style: TextStyle(
                      color: getPriorityColor(priority!),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(width: 5),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5,
              ),
              child: RichText(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Get.theme.colorScheme.onPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: "Description :\n",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(text: description.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
