import 'package:crm_flutter/app/data/network/user/all_users/model/all_users_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/size_manager.dart';
import '../../../../data/network/hrm/hrm_system/branch/branch_model.dart';
import '../controllers/branch_controller.dart';

class BranchCard extends StatelessWidget {
  final BranchData branch;
  Rxn<User> manager = Rxn<User>();

  BranchCard({Key? key, required this.branch}) : super(key: key);

  String formatBranchCode(String? code) {
    if (code != null && code.isNotEmpty) {
      return code.length <= 6 ? code : code.substring(code.length - 6);
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BranchController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      manager.value = await controller.getManagerById(branch.branchManager!);
    });
    return GestureDetector(
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          children: [
            Row(
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
                        Obx(
                          () => Text(
                            'Manager: ${manager.value?.username} ',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
