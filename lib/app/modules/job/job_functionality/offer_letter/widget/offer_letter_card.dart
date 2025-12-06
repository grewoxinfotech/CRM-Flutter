
import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:crm_flutter/app/data/network/system/currency/controller/currency_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/job/offer_letter/offer_letter_model.dart';
import '../controllers/offer_letter_controller.dart';

class OfferLetterCard extends StatelessWidget {
  final OfferLetterData offerLetter;

  const OfferLetterCard({Key? key, required this.offerLetter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OfferLetterController>();
    Get.lazyPut(()=>CurrencyController());
    final currencyController = Get.find<CurrencyController>();
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      await currencyController.getCurrency();
      await controller.getJobApplicationById(offerLetter.jobApplicant!);
      await controller.getJobById(offerLetter.job!);
    });

    return CrmCard(
      padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.orange.shade100,
                child: Icon(
                  Icons.assignment_outlined,
                  color: Colors.orange.shade700,
                  size: 30,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () {
                        final job = controller.jobPositions.firstWhereOrNull((element) => element.id == offerLetter.job);
                        if (job == null) return const SizedBox.shrink();
                        return Text(
                        job.title ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                      },
                    ),
                    if (offerLetter.jobApplicant != null) ...[
                      const SizedBox(height: 4),
                      Obx(
                        () {
                          final applicant = controller.jobApplications.firstWhereOrNull((element) => element.id == offerLetter.jobApplicant);
                          if (applicant == null) return const SizedBox.shrink();
                          return Text(
                          "Applicant: ${applicant.name}",
                          style: const TextStyle(fontSize: 14, color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
                        );
                        },
                      ),
                    ],
                  ],
                ),
              ),
              _buildStatusChip(offerLetter.status),
            ],
          ),

          const SizedBox(height: 12),

          /// SALARY & CURRENCY
          if (offerLetter.salary != null) ...[
            Obx(
              () {
                final currency = currencyController.currencyModel.firstWhereOrNull((element) => element.id == offerLetter.currency);
                if (currency == null) return const SizedBox.shrink();
                return _infoRow(Icons.monetization_on, "Salary",
                  "${currency.currencyIcon ?? '₹'} ${offerLetter.salary}");
              },
            ),
          ],

          /// EXPECTED JOINING DATE
          if (offerLetter.expectedJoiningDate != null) ...[
            _infoRow(Icons.event_available, "Joining Date", formatDateString(offerLetter.expectedJoiningDate!)),
          ],

          /// OFFER EXPIRY
          if (offerLetter.offerExpiry != null) ...[
            _infoRow(Icons.timer_off, "Offer Expiry", formatDateString(offerLetter.offerExpiry!)),
          ],

          /// DESCRIPTION
          if (offerLetter.description != null && offerLetter.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              "Description: ${offerLetter.description!}",
              style: const TextStyle(fontSize: 13, color: Colors.black87),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          const SizedBox(height: 12),

          /// FILE LINK
          if (offerLetter.file != null && offerLetter.file!.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () => _openFile(offerLetter.file!),
                child: Text(
                  "View Offer Letter",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Status chip with color coding
  Widget _buildStatusChip(String? status) {
    if (status == null) return const SizedBox();

    Color bg;
    Color text;
    switch (status.toLowerCase()) {
      case "accepted":
        bg = Colors.green.shade100;
        text = Colors.green.shade800;
        break;
      case "rejected":
        bg = Colors.red.shade100;
        text = Colors.red.shade800;
        break;
      default:
        bg = Colors.orange.shade100;
        text = Colors.orange.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppSpacing.small),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: text,
        ),
      ),
    );
  }

  /// Info row with icon + label + value
  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Open offer letter file
  Future<void> _openFile(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }
}
