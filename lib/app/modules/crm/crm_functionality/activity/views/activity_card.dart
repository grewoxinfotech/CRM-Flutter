import 'package:flutter/material.dart';
import 'package:crm_flutter/app/data/network/activity/model/activity_model.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const ActivityCard({
    super.key,
    required this.activity,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          '${activity.action?.toUpperCase() ?? 'N/A'} - ${activity.activityFrom ?? 'N/A'}',
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(activity.activityMessage ?? 'No Message'),
            Text('Performed by: ${activity.performedBy ?? 'N/A'}'),
            Text('Date: ${formatDate(activity.createdAt.toString())}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onEdit != null)
              IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
          ],
        ),
      ),
    );
  }
}
