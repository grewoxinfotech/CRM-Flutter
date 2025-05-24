import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/task/model/task_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final GestureTapCallback? onEdit;
  final GestureTapCallback? onDelete;

  const TaskCard({super.key, required this.task, this.onEdit, this.onDelete});

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
    final String id = task.id.toString();
    final String relatedId = task.relatedId.toString();
    final String taskName = task.taskName.toString();
    final String file = task.file.toString();
    final String startDate = formatDate(task.startDate.toString());
    final String dueDate = formatDate(task.dueDate.toString());
    final String status = task.status.toString();
    final String priority = task.priority.toString();
    final String description = task.description.toString();
    final String reminderDate = formatDate(task.reminderDate.toString());
    final String clientId = task.clientId.toString();
    final String taskReporter = task.taskReporter.toString();
    final String createdBy = task.createdBy.toString();
    final String updatedBy = task.updatedBy.toString();
    final String createdAt = formatDate(task.createdAt.toString());
    final String updatedAt = formatDate(task.updatedAt.toString());

    return GestureDetector(
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.small),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
