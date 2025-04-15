import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
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
  final DateTime? startDate;
  final DateTime? dueDate;
  final Map<String, dynamic>? assignTo;
  final String? status;
  final String? priority;
  final String? description;
  final DateTime? reminderDate;
  final String? clientId;
  final String? taskReporter;
  final String? createdBy;
  final String? updatedBy;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onEdit;
  final GestureTapCallback? onDelete;

  const TaskCard({
    Key? key,
    this.id,
    required this.relatedId,
    required this.taskName,
    required this.category,
    required this.project,
    required this.lead,
    required this.file,
    required this.startDate,
    required this.dueDate,
    required this.assignTo,
    required this.status,
    required this.priority,
    required this.description,
    required this.reminderDate,
    required this.clientId,
    required this.taskReporter,
    required this.createdBy,
    required this.updatedBy,
    this.onTap,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

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
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${taskName}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Get.theme.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 5),
              // 🔖 Status & Priority
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: getStatusColor(status!).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status!,
                      style: TextStyle(
                        color: getStatusColor(status!),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: getPriorityColor(priority!).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
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
              const SizedBox(height: 5),
              Row(
                children: [
                  // 📅 Dates Row
                  Text("${startDate!.toLocal().toString().split(' ')[0]}"),
                  Text("${dueDate!.toLocal().toString().split(' ')[0]}"),
                ],
              ),
              // 👥 Assign To + 👤 Client

              // 📝 Description
              if (description != null && description!.isNotEmpty) ...[
                Text("${description!}"),
              ],

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CrmIc(
                    iconPath: ICRes.edit,
                    width: 30,
                    color: ColorRes.success,
                    onTap: onEdit,
                  ),
                  const SizedBox(width: 10),
                  CrmIc(
                    iconPath: ICRes.delete,
                    width: 30,
                    color: ColorRes.error,
                    onTap: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
