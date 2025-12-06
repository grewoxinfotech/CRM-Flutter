import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../care/constants/size_manager.dart';
import '../../../../../care/utils/format.dart';
import '../../../../../data/network/job/interview_schedule/interview_schedule_model.dart';
import '../controllers/interview_schedule_controller.dart';

class InterviewScheduleCard extends StatelessWidget {
  final InterviewScheduleController controller = Get.find();
  final InterviewScheduleData schedule;

   InterviewScheduleCard({Key? key, required this.schedule})
      : super(key: key);

  /// Format the date string

  /// Assign color based on interview type
  Color _getColorByType(String? type) {
    switch (type?.toLowerCase()) {
      case "hr":
        return Colors.orange;
      case "technical":
        return Colors.blue;
      case "manager":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getColorByInterviewType(String? type) {
    switch (type?.toLowerCase()) {
      case "online":
        return Colors.orange;
      case "offline":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await controller.getJobApplicationById(schedule.candidate!);
      await controller.getJobById(schedule.job!);
      await controller.getManagerById(schedule.interviewer!);

    });
    return CrmCard(
      padding: const EdgeInsets.all(AppSpacing.medium),
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _getColorByInterviewType(schedule.interviewType).withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppSpacing.extraLarge),
            ),
            child: Icon(
              Icons.event_available_rounded,
              color: _getColorByInterviewType(schedule.interviewType),
              size: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.medium),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () {
                    final job = controller.jobApplications.firstWhereOrNull((item) => item.id == schedule.candidate);
                    if (job == null) {
                      return const Text(
                        "N/A",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                    return Text(
                    "${job.name ?? "N/A"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                  },
                ),
                const SizedBox(height: 4),
                Obx(
                      () {
                    final job = controller.jobPositions.firstWhereOrNull((item) => item.id == schedule.job);
                    if (job == null) {
                      return const Text(
                        "N/A",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                    return Text(
                      "Job: ${job.title ?? "N/A"}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
                SizedBox(height: 4),

                SizedBox(height: 4),
                Text(
                  "${formatDateString(schedule.startOn ?? '')} at ${schedule.startTime ?? ''}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Interview type badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getColorByInterviewType(schedule.interviewType).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              schedule.interviewType ?? "Other",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: _getColorByInterviewType(schedule.interviewType),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
