import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:flutter/material.dart';
import '../../../../data/network/hrm/leave/leave/leave_model.dart';


Future<String?> showLeaveReasonDialog(BuildContext context, LeaveData leave) {
  return showDialog<String>(
    context: context,
    builder: (ctx) {
      final reason = (leave.reason ?? '').trim();
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Take Action'),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  reason.isEmpty ? '-' : reason,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: CrmButton(
                  onTap: () => Navigator.of(ctx).pop('reject'),
                  backgroundColor: ColorRes.error,
                  title: 'Reject',
                ),
              ),
              SizedBox(width: AppSpacing.medium),
              Expanded(
                child: CrmButton(
                  onTap: () => Navigator.of(ctx).pop('approve'),
                  title: 'Approve',
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
