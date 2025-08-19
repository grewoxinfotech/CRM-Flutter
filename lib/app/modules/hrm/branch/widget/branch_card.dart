import 'package:flutter/material.dart';

import '../../../../data/network/hrm/hrm_system/branch/branch_model.dart';

class BranchCard extends StatelessWidget {
  final BranchData branch;

  const BranchCard({Key? key, required this.branch}) : super(key: key);

  String formatBranchCode(String? code) {
    if (code != null && code.isNotEmpty) {
      return code.length <= 6 ? code : code.substring(code.length - 6);
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: Icon(
                  Icons.account_tree, // branch icon
                  color: Colors.blue[700],
                  size: 32,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Branch Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Branch Name
                  Text(
                    branch.branchName ?? 'Unnamed Branch',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  // Branch Code
                  // if (branch.code != null && branch.code!.isNotEmpty)
                  //   Text(
                  //     "Code: ${formatBranchCode(branch.code)}",
                  //     style: const TextStyle(
                  //       fontSize: 14,
                  //       color: Colors.blueGrey,
                  //     ),
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  //
                  // const SizedBox(height: 4),

                  // Branch Address
                  if (branch.branchAddress != null &&
                      branch.branchAddress!.isNotEmpty)
                    Text(
                      branch.branchAddress!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 4),

                  // Branch Manager
                  if (branch.branchManager != null &&
                      branch.branchManager!.isNotEmpty)
                    Text(
                      'Manager: ${branch.branchManager!}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w600,
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
