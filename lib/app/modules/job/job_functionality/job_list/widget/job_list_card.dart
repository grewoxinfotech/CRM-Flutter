import 'package:crm_flutter/app/data/network/user/all_users/model/all_users_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/job/job_list/job_list_model.dart';

import '../controllers/job_list_controller.dart';

class JobListCard extends StatelessWidget {
  final JobData job;
  Rxn<User> createdByUser = Rxn<User>();

  JobListCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobListController>();

    // fetch createdBy user details after build
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   if (job.createdBy != null && job.createdBy!.isNotEmpty) {
    //     createdByUser.value = await controller.getJobCreatorById(job.createdBy!);
    //   }
    // });

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
                    color: Colors.orange[100],
                    child: Icon(
                      Icons.work, // job icon
                      color: Colors.orange[700],
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Job Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Job Title
                      Text(
                        job.title ?? 'Untitled Job',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Job Department
                      // if (job.description != null && job.department!.isNotEmpty)
                      //   Text(
                      //     "Department: ${job.department}",
                      //     style: const TextStyle(
                      //       fontSize: 14,
                      //       color: Colors.blueGrey,
                      //     ),
                      //     maxLines: 1,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      const SizedBox(height: 4),

                      // Job Location
                      if (job.location != null && job.location!.isNotEmpty)
                        Text(
                          job.location!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 4),

                      // Created By
                      if (job.createdBy != null &&
                          job.createdBy!.isNotEmpty) ...[
                        Text(
                          'Created by: ${job.createdBy}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.green[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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
