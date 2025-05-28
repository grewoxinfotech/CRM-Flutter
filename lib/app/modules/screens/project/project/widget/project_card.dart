import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String? id;
  final String? projectName;
  final String? startDate;
  final String? endDate;
  final String? projectMembers;
  final String? projectCategory;
  final String? projectDescription;
  final String? client;
  final String? currency;
  final String? budget;
  final String? estimatedMonths;
  final String? estimatedHours;
  final String? files;
  final String? tag;
  final String? status;
  final String? clientId;
  final String? createdBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const ProjectCard({
    super.key,
    this.id,
    this.projectName,
    this.startDate,
    this.endDate,
    this.projectMembers,
    this.projectCategory,
    this.projectDescription,
    this.client,
    this.currency,
    this.budget,
    this.estimatedMonths,
    this.estimatedHours,
    this.files,
    this.tag,
    this.status,
    this.clientId,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text("id : $id"),
            Text("projectName : $projectName"),
            Text("startDate : $startDate"),
            Text("endDate : $endDate"),
            Text("projectMembers : $projectMembers"),
            Text("projectCategory : $projectCategory"),
            Text("projectDescription : $projectDescription"),
            Text("client : $client"),
            Text("currency : $currency"),
            Text("budget : $budget"),
            Text("estimatedMonths : $estimatedMonths"),
            Text("estimatedHours : $estimatedHours"),
            Text("files : $files"),
            Text("tag : $tag"),
            Text("status : $status"),
            Text("clientId : $clientId"),
            Text("createdBy : $createdBy"),
            Text("createdAt : $createdAt"),
            Text("updatedAt : $updatedAt"),
          ],
        ),
      ),
    );
  }
}
