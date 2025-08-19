import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:crm_flutter/app/modules/hrm/branch/controllers/branch_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/network/hrm/hrm_system/designation/designation_model.dart';

class DesignationCard extends StatelessWidget {
  final DesignationData designation;

  const DesignationCard({Key? key, required this.designation})
    : super(key: key);

  String formatDate(String? date) {
    if (date != null && date.isNotEmpty) {
      try {
        return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
      } catch (_) {
        return date;
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final BranchController branchController = Get.find<BranchController>();
    // Get branch name using ID
    String branchName = '';
    if (designation.branch != null && designation.branch!.isNotEmpty) {
      final branch = branchController.items.firstWhereOrNull(
        (b) => b.id == designation.branch,
      );
      branchName = branch?.branchName ?? designation.branch!;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Icon Placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.blue[100],
                child: Icon(Icons.badge, color: Colors.blue[700], size: 32),
              ),
            ),
            const SizedBox(width: 12),

            // Designation Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Designation Name
                  Text(
                    designation.designationName ?? 'Unnamed Designation',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Branch Name
                  if (branchName.isNotEmpty)
                    Text(
                      'Branch: $branchName',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 4),

                  // Created Date
                  if (designation.createdAt != null)
                    Text(
                      'Created: ${formatDateString(designation.createdAt)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
