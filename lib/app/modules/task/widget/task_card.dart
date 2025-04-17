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
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CrmCard(
              margin: const EdgeInsets.all(5),
              borderRadius: BorderRadius.circular(19),
              color: Get.theme.colorScheme.background,
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    "G",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Get.theme.colorScheme.surface,
                    ),
                  ),
                ),
                title: Text(
                  createdBy.toString(),
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,color: Get.theme.colorScheme.onPrimary),
                ),
                subtitle: Text(taskName.toString(),
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,color: Get.theme.colorScheme.onSecondary),
                ),
                trailing: Icon(Icons.menu),
              ),
            ),
            Divider(
              color: Get.theme.dividerColor,
              height:   0,
              indent: 20,
              endIndent: 20,
            ),
            Row(
              children: [
                CrmCard(
                  color: Get.theme.colorScheme.background,
                  height: 40,
                  width: 10,
                  borderRadius: BorderRadius.horizontal(right: Radius.elliptical(10,20)),
                  boxShadow: [],
                ),
                const SizedBox(width: 10,),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
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
                    ],
                  ),
                ),
                const SizedBox(width: 10,),

                CrmCard(
                  color: Get.theme.colorScheme.background,
                  height: 40,
                  width: 10,
                  borderRadius: BorderRadius.horizontal(left: Radius.elliptical(10,20)),

                ),
              ],
            ),
            Divider(
              height: 0,
              color: Get.theme.dividerColor,
              indent: 20,
              endIndent: 20,
            ),
            CrmCard(
              color: Get.theme.colorScheme.background,
              borderRadius: BorderRadius.circular(19),
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(10),
              child: Text(description.toString(),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,color: Get.theme.colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
