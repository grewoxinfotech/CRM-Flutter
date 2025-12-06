
import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:crm_flutter/app/data/network/system/currency/controller/currency_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/job/job_onboarding/job_onboarding_model.dart';
import '../controller/job_onboarding_controller.dart';

class JobOnboardingCard extends StatelessWidget {
  final JobOnboardingData job;
  RxString interviewerName = "".obs;

  JobOnboardingCard({Key? key, required this.job}) : super(key: key);

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case "selected":
        return Colors.green[700]!;
      case "rejected":
        return Colors.red[700]!;
      case "pending":
        return Colors.orange[700]!;
      default:
        return Colors.grey[600]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JobOnboardingController>();
    Get.lazyPut(() => CurrencyController());
    final currencyController = Get.find<CurrencyController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (job.interviewer != null) {
        final interviewer = await controller.getManagerById(job.interviewer!);
        interviewerName.value = interviewer?.username ?? '';
      }
      await currencyController.getCurrency();
    });

    return GestureDetector(
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Avatar + Job Info
            Row(
              children: [
                // Avatar / Job Icon
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.blueGrey[50],
                    child: Icon(
                      Icons.work_outline,
                      color: Colors.blueGrey[700],
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Job Basic Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Job ID: ${job.id!.substring(0, 6) ?? "-"}-${job.id!.substring(job.id!.length - 4)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Obx(
                        () => Text(
                          'Interviewer: ${interviewerName.value.isNotEmpty ? interviewerName.value : job.interviewer ?? "-"}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Job Type: ${job.jobType ?? "-"}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            const Divider(),

            // Details Grid
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _InfoChip(
                  icon: Icons.calendar_today,
                  label: 'Joining',
                  value:
                      job.joiningDate != null
                          ? formatDateString(job.joiningDate)
                          : '-',
                ),
                _InfoChip(
                  icon: Icons.today,
                  label: 'Days',
                  value: job.daysOfWeek ?? '-',
                ),
                Obx(() {
                  final currency = currencyController.currencyModel
                      .firstWhereOrNull(
                        (element) => element.id == job.currency,
                      );
                  if (currency == null) return SizedBox.shrink();
                  return _InfoChip(
                    icon: Icons.attach_money,
                    label: 'Salary',
                    value:
                        job.salary != null
                            ? '${currency.currencyIcon ?? "₹"} ${job.salary} (${job.salaryType ?? "-"} / ${job.salaryDuration ?? "-"})'
                            : '-',
                  );
                }),
                _InfoChip(
                  icon: Icons.info_outline,
                  label: 'Status',
                  value: job.status ?? '-',
                  valueColor: _getStatusColor(job.status),
                ),
                _InfoChip(
                  icon: Icons.person,
                  label: 'Created By',
                  value: job.createdBy ?? '-',
                ),
                _InfoChip(
                  icon: Icons.update,
                  label: 'Updated By',
                  value: job.updatedBy ?? '-',
                ),
                _InfoChip(
                  icon: Icons.access_time,
                  label: 'Created At',
                  value:
                      job.createdAt != null
                          ? formatDateString(job.createdAt)
                          : '-',
                ),
                _InfoChip(
                  icon: Icons.access_time_filled,
                  label: 'Updated At',
                  value:
                      job.updatedAt != null
                          ? formatDateString(job.updatedAt)
                          : '-',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widget for small info chips
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoChip({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.blueGrey[700]),
          const SizedBox(width: 4),
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
