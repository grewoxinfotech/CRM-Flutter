// import 'package:crm_flutter/app/care/constants/ic_res.dart';
// import 'package:crm_flutter/app/care/constants/size_manager.dart';
// import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
// import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class DealCard extends StatelessWidget {
//   final String? id;
//   final String? dealTitle;
//   final String? currency;
//   final String? value;
//   final String? pipeline;
//   final String? stage;
//   final String? status;
//   final String? label;
//   final String? closedDate;
//   final String? firstName;
//   final String? lastName;
//   final String? email;
//   final String? phone;
//   final String? source;
//   final String? companyName;
//   final String? website;
//   final String? address;
//   final String? products;
//   final String? files;
//   final String? assignedTo;
//   final String? clientId;
//   final String? isWon;
//   final String? companyId;
//   final String? contactId;
//   final String? createdBy;
//   final String? updatedBy;
//   final String? createdAt;
//   final String? updatedAt;
//   final Color? color;
//   final GestureTapCallback? onTap;
//   final GestureTapCallback? onDelete;
//   final GestureTapCallback? onEdit;
//
//   const DealCard({
//     super.key,
//     this.id,
//     this.color,
//     this.dealTitle,
//     this.currency,
//     this.value,
//     this.pipeline,
//     this.stage,
//     this.status,
//     this.label,
//     this.closedDate,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.phone,
//     this.source,
//     this.companyName,
//     this.website,
//     this.address,
//     this.files,
//     this.assignedTo,
//     this.clientId,
//     this.isWon,
//     this.companyId,
//     this.contactId,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//     this.onTap,
//     this.onDelete,
//     this.onEdit,
//     this.products,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     Color textPrimary = Get.theme.colorScheme.onPrimary;
//     Color textSecondary = Get.theme.colorScheme.onSecondary;
//     return GestureDetector(
//       onTap: onTap,
//       child: CrmCard(
//         padding: const EdgeInsets.all(AppPadding.medium),
//         margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
//         borderRadius: BorderRadius.circular(AppRadius.large),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Top Title Row
//             Row(
//               children: [
//                 // Lead Title & Company Name
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         dealTitle ?? '',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       if (companyName != null) ...[
//                         Text(
//                           companyName ?? '',
//                           style: TextStyle(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//                 AppSpacing.verticalSmall,
//                 // Value & Source
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '${currency ?? ''} ${value ?? '0'}.00',
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                         color: color,
//                       ),
//                     ),
//                     Text(
//                       source ?? '',
//                       style: TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Divider(color: Get.theme.dividerColor, height: AppPadding.medium),
//             // Bottom Status Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _infoTile(ICRes.task, status, color),
//                 _infoTile(ICRes.calendar, createdAt, color),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _infoTile(String iconPath, String? title, Color? iconColor) {
//     return Row(
//       children: [
//         CrmIc(iconPath: iconPath, width: 14),
//         const SizedBox(width: AppPadding.small),
//         Text(
//           title ?? '',
//           style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
//         ),
//       ],
//     );
//   }
// }
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/widget/common_widget.dart';

class DealCard extends StatelessWidget {
  final String? id;
  final String? dealTitle;
  final String? currency;
  final String? value;
  final String? pipeline;
  final String? stage;
  final String? status;
  final String? label;
  final String? closedDate;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? source;
  final String? companyName;
  final String? website;
  final String? address;
  final String? products;
  final String? files;
  final String? assignedTo;
  final String? clientId;
  final String? isWon;
  final String? companyId;
  final String? contactId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final Color? color;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const DealCard({
    super.key,
    this.id,
    this.color,
    this.dealTitle,
    this.currency,
    this.value,
    this.pipeline,
    this.stage,
    this.status,
    this.label,
    this.closedDate,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.source,
    this.companyName,
    this.website,
    this.address,
    this.files,
    this.assignedTo,
    this.clientId,
    this.isWon,
    this.companyId,
    this.contactId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.onTap,
    this.onDelete,
    this.onEdit,
    this.products,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header: Deal Title + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    dealTitle ?? "No Title",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        color != null
                            ? getStatusColor(status).withOpacity(0.2)
                            : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status ?? "Unknown",
                    style: TextStyle(
                      color: getStatusColor(status),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Stage + Pipeline chips
            Row(
              children: [
                if (stage != null) CommonWidget.buildChips(stage ?? "Stage"),
                const SizedBox(width: 8),
                if (pipeline != null)
                  CommonWidget.buildChips(pipeline ?? "Pipeline"),
              ],
            ),
            const SizedBox(height: 12),

            /// Value + Currency
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${currency ?? ''} ${value ?? '0'}.00",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Created: ${createdAt ?? '-'}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Company + Source
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (companyName != null)
                  Flexible(child: _buildText(companyName!, "Company: ")),
                if (source != null)
                  Flexible(child: _buildText(source!, "Source: ")),
              ],
            ),

            /// Closed Date (Optional)
            if (closedDate != null)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Closed: $closedDate",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(
    String text,
    String title, {
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
          ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Color getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'won':
        return Colors.green;
      case 'lost':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
