import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:crm_flutter/app/modules/hrm/branch/controllers/branch_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../care/constants/size_manager.dart';
import '../../../../data/network/hrm/announcement/announcement_model.dart';

class AnnouncementCard extends StatelessWidget {
  final AnnouncementData announcement;

  const AnnouncementCard({Key? key, required this.announcement})
    : super(key: key);

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
    final BranchController branchController = Get.find<BranchController>();

    // Get branch name using ID (taking first branch if multiple)
    List<String> branchNames = [];

    if (announcement.branch != null &&
        announcement.branch!.branch != null &&
        announcement.branch!.branch!.isNotEmpty) {
      // announcement.branch!.branch is a list of branch IDs
      final branchIds = announcement.branch!.branch!;

      branchNames =
          branchController.items
              .where(
                (b) => branchIds.contains(b.id),
              ) // filter only matched branches
              .map((b) => b.branchName ?? '') // take branchName
              .where((name) => name.isNotEmpty) // avoid null/empty
              .toList();
    }

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
                      Icons.announcement,
                      color: Colors.green[700],
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Announcement Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        announcement.title ?? 'Untitled Announcement',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Branch Name
                      if (branchNames.isNotEmpty)
                        Text(
                          'Branch: ${branchNames.join(", ")}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 4),

                      // Description
                      if (announcement.description != null)
                        Text(
                          announcement.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 4),

                      // Created Date
                      if (announcement.createdAt != null)
                        Text(
                          'Created: ${formatDate(announcement.createdAt)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),

                      // Time & Date
                      if ( announcement.date != null)
                        Text(
                          'Scheduled Date: ${formatDate(announcement.date)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      if (announcement.time != null)
                        Text(
                          'Scheduled Time: ${announcement.time}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
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
