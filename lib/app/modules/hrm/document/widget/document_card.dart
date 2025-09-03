import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../care/constants/size_manager.dart';
import '../../../../data/network/hrm/document/document_model.dart';



class DocumentCard extends StatelessWidget {
  final DocumentData document;

  const DocumentCard({Key? key, required this.document}) : super(key: key);

  /// Open file link in browser or PDF viewer
  Future<void> _openFile(BuildContext context, String fileUrl) async {
    final uri = Uri.parse(fileUrl);

    await launchUrl(uri, mode: LaunchMode.inAppBrowserView);

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Placeholder
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.orange[100],
                    child: Icon(
                      Icons.description, // document icon
                      color: Colors.orange[700],
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Document Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Document Name
                      Text(
                        document.name ?? 'Untitled Document',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Role
                      if (document.role != null && document.role!.isNotEmpty)
                        Text(
                          "Role: ${document.role!}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 4),

                      // Description
                      if (document.description != null &&
                          document.description!.isNotEmpty)
                        Text(
                          document.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 6),

                      // File link button
                      if (document.file != null && document.file!.isNotEmpty)
                        GestureDetector(
                          onTap: () => _openFile(context, document.file!),
                          child: Row(
                            children: const [
                              Icon(Icons.picture_as_pdf,
                                  size: 18, color: Colors.red),
                              SizedBox(width: 6),
                              Text(
                                "View File",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
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
