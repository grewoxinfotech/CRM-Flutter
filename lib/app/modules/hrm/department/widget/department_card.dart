import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:crm_flutter/app/modules/hrm/branch/controllers/branch_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../care/constants/size_manager.dart';
import '../../../../data/network/hrm/hrm_system/departments/department_model.dart';

class DepartmentCard extends StatelessWidget {
  final DepartmentData department;

  const DepartmentCard({Key? key, required this.department}) : super(key: key);

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
    Get.lazyPut(()=>BranchController());
    final BranchController branchController = Get.find<BranchController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await branchController.getBranchById(department.branch!);
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
                    color: Colors.green[100],
                    child: Icon(
                      Icons.apartment,
                      color: Colors.green[700],
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Department Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Department Name
                      Text(
                        department.departmentName ?? 'Unnamed Department',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Branch Name
                      if (department.branch != null &&department.branch!.isNotEmpty)
                        Obx(
                          () {
                            final branch = branchController.items.firstWhereOrNull((element) => element.id == department.branch,);
                            if (branch == null) {
                              return SizedBox.shrink();
                            }
                            return Text(
                            'Branch: ${branch.branchName}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                          },
                        ),

                      const SizedBox(height: 4),

                      // Created Date
                      if (department.createdAt != null)
                        Text(
                          'Created: ${formatDateString(department.createdAt)}',
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
          ],
        ),
      ),
    );
  }
}
