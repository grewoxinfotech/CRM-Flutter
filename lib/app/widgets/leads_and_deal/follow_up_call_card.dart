import 'package:crm_flutter/app/data/network/all/project/follow_up/follow_up_call_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FollowUpCallCard extends StatelessWidget {
  final FollowUpCallModel call;

  const FollowUpCallCard({super.key, required this.call});

  @override
  Widget build(BuildContext context) {
    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'completed':
          return Colors.green;
        case 'pending':
          return Colors.orange;
        case 'missed':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return CrmCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              call.subject,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(LucideIcons.userPlus, size: 16),
                const SizedBox(width: 6),
                Expanded(
                  child: Text('Assigned: ${call.assignedTo.join(', ')}'),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(LucideIcons.target, size: 16),
                const SizedBox(width: 6),
                Text('Purpose: ${call.callPurpose}'),
                const Spacer(),
                Icon(LucideIcons.flag, size: 16),
                const SizedBox(width: 4),
                Text(call.priority),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
