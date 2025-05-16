import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String? id;
  final String? relatedId;
  final String? activityFrom;
  final String? activityId;
  final String? action;
  final String? performedBy;
  final String? activityMessage;
  final String? clientId;
  final String? createdAt;
  final String? updatedAt;

  const ActivityCard({
    super.key,
    this.id,
    this.relatedId,
    this.activityFrom,
    this.activityId,
    this.action,
    this.performedBy,
    this.activityMessage,
    this.clientId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return CrmCard(
      child: Column(
        children: [
          Text("Activity Card"),
          Text("id : $id"),
          Text("relatedId : $relatedId"),
          Text("activityFrom : $activityFrom"),
          Text("activityId : $activityId"),
          Text("action : $action"),
          Text("performedBy : $performedBy"),
          Text("activityMessage : $activityMessage"),
          Text("clientId : $clientId"),
          Text("createdAt : $createdAt"),
          Text("updatedAt : $updatedAt"),
        ],
      ),
    );
  }
}
