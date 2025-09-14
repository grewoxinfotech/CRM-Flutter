import 'package:crm_flutter/app/care/widget/common_widget.dart';
import 'package:crm_flutter/app/modules/job/job_functionality/job_list/controllers/job_list_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/job/job_candidate/job_candidate_model.dart';
import '../controllers/job_candidate_controller.dart';

class JobCandidateCard extends StatelessWidget {
  final JobCandidateData candidate;
  const JobCandidateCard({Key? key, required this.candidate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobCandidateController>();
    Get.lazyPut(() => JobListController());
    final jobListController = Get.find<JobListController>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await jobListController.getJobById(candidate.job!);
    });

    Color statusColor(String? status) {
      switch (status?.toLowerCase()) {
        case 'shortlisted':
          return Colors.green;
        case 'reject':
          return Colors.red;
        case 'interviewed':
          return Colors.orange;
        default:
          return Colors.blueGrey;
      }
    }

    return GestureDetector(
      onTap: () {
        // Handle card tap
      },
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.medium,
          vertical: AppMargin.small,
        ),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar with gradient background
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.orange.shade200, Colors.orange.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(Icons.person, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),

            // Candidate Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          candidate.name ?? 'Unnamed Candidate',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (candidate.status?.isNotEmpty ?? false)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(AppRadius.small),
                            color: statusColor(candidate.status).withOpacity(0.2),
                          ),
                          child: Text(
                            candidate.status!,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: statusColor(candidate.status),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Contact Info
                  if (candidate.email?.isNotEmpty ?? false)
                    CommonWidget.buildText(candidate.email!, 'Email: '),
                  if (candidate.phone?.isNotEmpty ?? false)
                    CommonWidget.buildText(candidate.phone!, 'Phone: '),

                  const SizedBox(height: 6),

                  // Job Info
                  if (candidate.job?.isNotEmpty ?? false)
                    Obx(() {
                      final job = jobListController.items
                          .firstWhereOrNull((item) => item.id == candidate.job);
                      if (job == null) return const SizedBox.shrink();
                      return CommonWidget.buildText(job.title!, 'Job: ');
                    }),
                  if (candidate.appliedSource?.isNotEmpty ?? false)
                    CommonWidget.buildText(
                        candidate.appliedSource!, 'Applied Source: '),
                  if (candidate.location?.isNotEmpty ?? false)
                    CommonWidget.buildText(candidate.location!, 'Location: '),
                  if (candidate.currentLocation?.isNotEmpty ?? false)
                    CommonWidget.buildText(
                        candidate.currentLocation!, 'Current Location: '),
                  if (candidate.totalExperience != null)
                    CommonWidget.buildText(
                        '${candidate.totalExperience} years', 'Experience: '),
                  if (candidate.noticePeriod != null)
                    CommonWidget.buildText(candidate.noticePeriod!, 'Notice Period: '),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
