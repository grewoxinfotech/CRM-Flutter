
import 'package:crm_flutter/app/modules/job/job_functionality/job_list/controllers/job_list_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/job/job_applications/job_application_model.dart';
import '../controllers/job_application_controller.dart';

class JobApplicationCard extends StatelessWidget {
  final JobApplicationData application;

  const JobApplicationCard({Key? key, required this.application})
    : super(key: key);

  Future<void> _openCv(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }

  Widget _infoRow(String label, String? value, {Color? color}) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 13,
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: color ?? Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobApplicationController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getJobById(application.job!);
    });

    return GestureDetector(
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Candidate Avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.orange[100],
                    child: const Icon(
                      Icons.person,
                      color: Colors.orange,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Candidate Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name & Job
                      Text(
                        application.name ?? 'Unnamed Candidate',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (application.job != null &&
                          application.job!.isNotEmpty)
                        Obx(() {
                          final job = controller.jobPositions.firstWhereOrNull(
                            (job) => job.id == application.job,
                          );
                          if (job == null) {
                            return SizedBox.shrink();
                          }
                          return Text(
                            job.title!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blueGrey,
                            ),
                          );
                        }),

                      const SizedBox(height: 6),

                      // Contact Info
                      _infoRow('Email', application.email),
                      _infoRow('Phone', application.phone),
                      _infoRow('Location', application.location),
                      _infoRow('Current Location', application.currentLocation),
                      _infoRow('Notice Period', application.noticePeriod),
                      _infoRow(
                        'Total Experience',
                        application.totalExperience,
                        color: Colors.purple[700],
                      ),
                      _infoRow(
                        'Status',
                        application.status,
                        color: Colors.green[700],
                      ),
                      _infoRow('Applied Source', application.appliedSource),

                      // CV Link
                      if (application.cvPath != null &&
                          application.cvPath!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: InkWell(
                            onTap: () => _openCv(application.cvPath!),
                            child: Text(
                              'View CV',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blue[700],
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                              ),
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
