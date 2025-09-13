import 'package:crm_flutter/app/care/widget/common_widget.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/size_manager.dart';

import '../../../../../data/network/job/job_candidate/job_candidate_model.dart';
import '../controllers/job_candidate_controller.dart';

class JobCandidateCard extends StatelessWidget {
  final JobCandidateData candidate;
  RxnString recruiterName = RxnString();

  JobCandidateCard({Key? key, required this.candidate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobCandidateController>();

    // Load recruiter/assigned HR details after build
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   if (candidate.recruiterId != null && candidate.recruiterId!.isNotEmpty) {
    //     recruiterName.value =
    //     await controller.getRecruiterNameById(candidate.recruiterId!);
    //   }
    // });

    return GestureDetector(
      onTap: () {
        // Could navigate to detail screen later
        // controller.openCandidateDetail(candidate);
      },
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Row(
          children: [
            // Avatar / Placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 60,
                height: 60,
                color: Colors.orange[100],
                child: Icon(Icons.person, color: Colors.orange[700], size: 32),
              ),
            ),
            const SizedBox(width: 12),

            // Candidate Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Candidate Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        candidate.name ?? 'Unnamed Candidate',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 6),
                      if (candidate.status != null &&
                          candidate.status!.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppSpacing.small,
                            ),
                            color:
                                candidate.status == 'Selected'
                                    ? Colors.green[100]
                                    : Colors.orange[100],
                          ),
                          child: Text(
                            '${candidate.status}',
                            style: TextStyle(
                              fontSize: 13,
                              color:
                                  candidate.status == 'Selected'
                                      ? Colors.green[700]
                                      : Colors.orange[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),

                  // const SizedBox(height: 6),

                  // Email / Phone
                  if ((candidate.email != null &&
                          candidate.email!.isNotEmpty) ||
                      (candidate.phone != null && candidate.phone!.isNotEmpty))
                    Text(
                      candidate.email?.isNotEmpty == true
                          ? candidate.email!
                          : candidate.phone ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                  const SizedBox(height: 4),

                  // Position Applied
                  // if (candidate.positionApplied != null &&
                  //     candidate.positionApplied!.isNotEmpty)
                  //   Text(
                  //     'Position: ${candidate.positionApplied!}',
                  //     style: const TextStyle(
                  //       fontSize: 14,
                  //       color: Colors.black87,
                  //     ),
                  //     maxLines: 1,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  //
                  // const SizedBox(height: 4),
                  //
                  // // Recruiter Info
                  // if (candidate.recruiterId != null &&
                  //     candidate.recruiterId!.isNotEmpty)
                  //   Obx(
                  //         () => Text(
                  //       'Recruiter: ${recruiterName.value ?? ''}',
                  //       style: TextStyle(
                  //         fontSize: 13,
                  //         color: Colors.green[700],
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  if (candidate.phone != null && candidate.phone!.isNotEmpty)
                    CommonWidget.buildText('${candidate.phone}', 'Phone: '),
                  const SizedBox(height: 4),
                  if (candidate.noticePeriod != null)
                    CommonWidget.buildText(
                      '${candidate.noticePeriod}',
                      'Notice Period: ',
                    ),
                  const SizedBox(height: 4),
                  if (candidate.totalExperience != null)
                    CommonWidget.buildText(
                      '${candidate.totalExperience} years',
                      'Experience: ',
                    ),
                  // Candidate Status
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
