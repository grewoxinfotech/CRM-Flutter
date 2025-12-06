
import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../care/constants/size_manager.dart';
import '../../../../../widgets/common/display/crm_card.dart';
import '../../../../../data/network/job/job_list/job_list_model.dart';
import '../controllers/job_list_controller.dart';

class JobListCard extends StatelessWidget {
  final JobData job;

  JobListCard({Key? key, required this.job}) : super(key: key);

  // Status color mapping
  Color _getColorByStatus(String? status) {
    switch (status?.toLowerCase()) {
      case "active":
        return Colors.green;
      case "inactive":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  // Job type color mapping
  Color _getColorByType(String? type) {
    switch (type?.toLowerCase()) {
      case "full-time":
        return Colors.blue.shade700;
      case "part-time":
        return Colors.green.shade600;
      case "contract":
        return Colors.amber.shade700;
      case "internship":
        return Colors.red.shade600;
      case "temporary":
        return Colors.orange.shade800;
      default:
        return Colors.grey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobListController>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.loadCurrencies();
      await controller.getManagerById(job.recruiter!);
    });

    return GestureDetector(
      onTap: () {
        // Example: Navigate to job details
        // controller.viewJobDetails(job.id);
      },
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Icon + Title + Status
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.orange[100],
                    child: Icon(
                      Icons.work,
                      color: Colors.orange[700],
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              job.title ?? 'Untitled Job',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (job.status != null && job.status!.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getColorByStatus(
                                  job.status,
                                ).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                job.status!.capitalize.toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _getColorByStatus(job.status),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      if (job.jobType != null && job.jobType!.isNotEmpty)
                        Text(
                          "Type: ${job.jobType}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: _getColorByType(job.jobType),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Location
            if (job.location != null && job.location!.isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      job.location!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

            // Recruiter
            if (job.recruiter != null && job.recruiter!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Obx(() {
                  final manager = controller.managers.firstWhereOrNull(
                    (element) => element.id == job.recruiter,
                  );
                  if (manager == null) return const SizedBox.shrink();

                  return Text(
                    'Recruiter: ${manager.username}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }),
              ),

            // Experience & Salary
            if ((job.workExperience != null &&
                    job.workExperience!.isNotEmpty) ||
                (job.expectedSalary != null && job.expectedSalary!.isNotEmpty))
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    if (job.workExperience != null &&
                        job.workExperience!.isNotEmpty)
                      Text(
                        'Experience: ${job.workExperience}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    if ((job.workExperience != null &&
                            job.workExperience!.isNotEmpty) &&
                        (job.expectedSalary != null &&
                            job.expectedSalary!.isNotEmpty))
                      const SizedBox(width: 16),
                    if (job.expectedSalary != null &&
                        job.expectedSalary!.isNotEmpty)
                      Obx(() {
                        final currency = controller.currencies.firstWhereOrNull(
                          (element) => element.id == job.currency,
                        );

                        if (currency == null) return const SizedBox.shrink();

                        return Text(
                          'Salary: ${currency!.currencyIcon ?? ''} ${job.expectedSalary}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        );
                      }),
                  ],
                ),
              ),

            _buildSkills(job),
            _buildInterviewRounds(job),

            // Dates
            if ((job.startDate != null && job.startDate!.isNotEmpty) ||
                (job.endDate != null && job.endDate!.isNotEmpty))
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'Start: ${formatDateString(job.startDate) ?? "N/A"}  |  End: ${formatDateString(job.endDate) ?? "N/A"}',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),

            // Created By
            if (job.createdBy != null && job.createdBy!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  'Created by: ${job.createdBy}',
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
    );
  }

  Widget _buildSkills(JobData job) {
    if (job.skills == null || job.skills!.skills.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Wrap(
        spacing: 6,
        runSpacing: 4,
        children: job.skills!.skills.map((skill) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            skill,
            style: const TextStyle(fontSize: 12, color: Colors.blue),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildInterviewRounds(JobData job) {
    if (job.interviewRounds == null || job.interviewRounds!.interviewRounds.isEmpty)
      return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Wrap(
        spacing: 6,
        runSpacing: 4,
        children: job.interviewRounds!.interviewRounds.map((round) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            round,
            style: const TextStyle(fontSize: 12, color: Colors.green),
          ),
        )).toList(),
      ),
    );
  }

}
