// import 'package:crm_flutter/app/care/constants/ic_res.dart';
// import 'package:crm_flutter/app/care/constants/size_manager.dart';
// import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
// import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class LeadCard extends StatelessWidget {
//   final GestureTapCallback? onTap;
//   final Color? color;
//   final String? id;
//   final String? inquiryId;
//   final String? leadTitle;
//   final String? leadStage;
//   final String? pipeline;
//   final String? currency;
//   final String? leadValue;
//   final String? companyName;
//   final String? firstName;
//   final String? lastName;
//   final String? phoneCode;
//   final String? telephone;
//   final String? email;
//   final String? address;
//   final String? leadMembers;
//   final String? source;
//   final String? category;
//   final String? files;
//   final String? status;
//   final String? interestLevel;
//   final String? leadScore;
//   final String? isConverted;
//   final String? clientId;
//   final String? createdBy;
//   final String? updatedBy;
//   final String? createdAt;
//   final String? updatedAt;
//
//   const LeadCard({
//     super.key,
//     this.onTap,
//     this.color,
//     this.id,
//     this.inquiryId,
//     this.leadTitle,
//     this.leadStage,
//     this.pipeline,
//     this.currency,
//     this.leadValue,
//     this.companyName,
//     this.firstName,
//     this.lastName,
//     this.phoneCode,
//     this.telephone,
//     this.email,
//     this.address,
//     this.leadMembers,
//     this.source,
//     this.category,
//     this.files,
//     this.status,
//     this.interestLevel,
//     this.leadScore,
//     this.isConverted,
//     this.clientId,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
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
//         child: Column(
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
//                         leadTitle?.isNotEmpty == true ? leadTitle! : 'No Title',
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       if (companyName?.isNotEmpty == true) ...[
//                         Text(
//                           companyName?.isNotEmpty == true
//                               ? companyName!
//                               : (firstName?.isNotEmpty == true ||
//                                   lastName?.isNotEmpty == true)
//                               ? '${firstName ?? ''} ${lastName ?? ''}'
//                               : 'No Company',
//                           style: TextStyle(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w600,
//                             color: textSecondary,
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
//                       leadValue?.isNotEmpty == true
//                           ? '${currency} ${leadValue}.00'
//                           : '',
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
//                         color: textPrimary,
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
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w700,
//             // color: iconColor,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:crm_flutter/app/care/widget/common_widget.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/crm/lead/model/lead_model.dart';

// class LeadCard extends StatelessWidget {
//   final GestureTapCallback? onTap;
//   final Color? color;
//   final String? id;
//   final String? inquiryId;
//   final String? leadTitle;
//   final String? leadStage;
//   final String? pipeline;
//   final String? currency;
//   final String? leadValue;
//   final String? companyName;
//   final String? firstName;
//   final String? lastName;
//   final String? phoneCode;
//   final String? telephone;
//   final String? email;
//   final String? address;
//   final String? leadMembers;
//   final String? source;
//   final String? category;
//   final String? files;
//   final String? status;
//   final String? interestLevel;
//   final String? leadScore;
//   final String? isConverted;
//   final String? clientId;
//   final String? createdBy;
//   final String? updatedBy;
//   final String? createdAt;
//   final String? updatedAt;
//
//   const LeadCard({
//     super.key,
//     this.onTap,
//     this.color,
//     this.id,
//     this.inquiryId,
//     this.leadTitle,
//     this.leadStage,
//     this.pipeline,
//     this.currency,
//     this.leadValue,
//     this.companyName,
//     this.firstName,
//     this.lastName,
//     this.phoneCode,
//     this.telephone,
//     this.email,
//     this.address,
//     this.leadMembers,
//     this.source,
//     this.category,
//     this.files,
//     this.status,
//     this.interestLevel,
//     this.leadScore,
//     this.isConverted,
//     this.clientId,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: CrmCard(
//         padding: const EdgeInsets.all(AppPadding.medium),
//         margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
//         borderRadius: BorderRadius.circular(AppRadius.large),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Header: Lead Title + Status
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     leadTitle ?? "No Title",
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 8,
//                     vertical: 4,
//                   ),
//                   decoration: BoxDecoration(
//                     color:
//                         color != null
//                             ? getStatusColor(status).withOpacity(0.2)
//                             : null,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     status ?? "Unknown",
//                     style: TextStyle(
//                       color: getStatusColor(status),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//
//             /// Lead Stage + Pipeline
//             Row(
//               children: [
//                 CommonWidget.buildChips(leadStage ?? "Stage"),
//                 const SizedBox(width: 8),
//                 CommonWidget.buildChips(pipeline ?? "Pipeline"),
//               ],
//             ),
//             const SizedBox(height: 12),
//
//             /// Lead Value + Currency
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "${currency ?? ''} ${leadValue ?? 0}",
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: Colors.green,
//                   ),
//                 ),
//                 // Text(
//                 //   "Created: ${createdAt != null ? createdAt : '-'}",
//                 //   style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                 // ),
//                 _buildText("${createdAt != null ? createdAt : '-'}", "Created: ")
//               ],
//             ),
//             const SizedBox(height: 12),
//
//             /// Source + Category + Interest Level
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (source?.isNotEmpty == true)
//                   Flexible(child: _buildText("${source ?? '-'}", "Source: ")),
//
//                 if (category?.isNotEmpty == true)
//                   Flexible(
//                     child: _buildText("${category ?? '-'}", "Category: "),
//                   ),
//
//                 if (interestLevel?.isNotEmpty == true)
//                   Flexible(
//                     child: _buildText("${interestLevel ?? '-'}", "Interest: "),
//                   ),
//               ],
//             ),
//
//             /// Optional: Converted Badge
//             if (isConverted == true)
//               Container(
//                 margin: const EdgeInsets.only(top: 8),
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.green.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Text(
//                   "Converted",
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildText(
//     String text,
//     String title, {
//     double fontSize = 14,
//     FontWeight fontWeight = FontWeight.normal,
//     Color color = Colors.black,
//     TextOverflow overflow = TextOverflow.ellipsis,
//     int? maxLines,
//   }) {
//     return RichText(
//       text: TextSpan(
//         children: [
//           TextSpan(
//             text: title,
//             style: TextStyle(
//               fontSize: fontSize,
//               fontWeight: FontWeight.w700,
//               color: Colors.black,
//             ),
//           ),
//           TextSpan(
//             text: text,
//             style: TextStyle(
//               fontSize: fontSize,
//               fontWeight: fontWeight,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//       overflow: overflow,
//       maxLines: maxLines,
//     );
//   }
//
//   Color getStatusColor(String? status) {
//     switch (status?.toLowerCase()) {
//       case 'active':
//         return Colors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'running':
//         return Colors.blue;
//       default:
//         return Colors.grey; // fallback color
//     }
//   }
// }


import 'package:crm_flutter/app/care/widget/common_widget.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';

import '../../../../../care/constants/size_manager.dart';

class LeadCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Color? color;
  final String? id;
  final String? inquiryId;
  final String? leadTitle;
  final String? leadStage;
  final String? pipeline;
  final String? currency;
  final String? leadValue;
  final String? companyName;
  final String? firstName;
  final String? lastName;
  final String? phoneCode;
  final String? telephone;
  final String? email;
  final String? address;
  final String? leadMembers;
  final String? source;
  final String? category;
  final String? files;
  final String? status;
  final String? interestLevel;
  final String? leadScore;
  final String? isConverted;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;

  const LeadCard({
    super.key,
    this.onTap,
    this.color,
    this.id,
    this.inquiryId,
    this.leadTitle,
    this.leadStage,
    this.pipeline,
    this.currency,
    this.leadValue,
    this.companyName,
    this.firstName,
    this.lastName,
    this.phoneCode,
    this.telephone,
    this.email,
    this.address,
    this.leadMembers,
    this.source,
    this.category,
    this.files,
    this.status,
    this.interestLevel,
    this.leadScore,
    this.isConverted,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
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
            /// Header: Lead Title + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    leadTitle ?? "No Title",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 20,),
                if (status?.isNotEmpty == true)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: getStatusColor(status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status ?? "Unknown",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            /// Lead Stage + Pipeline
            Row(
              children: [
                if (leadStage?.isNotEmpty == true)
                CommonWidget.buildChips(leadStage ?? "Stage"),
                const SizedBox(width: 8),
                if (pipeline?.isNotEmpty == true)
                CommonWidget.buildChips(pipeline ?? "Pipeline"),
              ],
            ),
            const SizedBox(height: 12),

            /// Lead Value + Created Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${currency ?? ''} ${leadValue ?? '0'}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.teal,
                  ),
                ),
                _buildText(
                  createdAt ?? "-",
                  "Created: ",
                  fontSize: 12,
                  color: Colors.grey[600]!,
                ),
              ],
            ),
            const SizedBox(height: 10),

            /// Source + Category + Interest Level
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (source?.isNotEmpty == true)
                  Flexible(
                    child: _buildText(
                      source!,
                      "Source: ",
                      fontSize: 12,
                      color: Colors.grey[700]!,
                    ),
                  ),
                if (category?.isNotEmpty == true)
                  Flexible(
                    child: _buildText(
                      category!,
                      "Category: ",
                      fontSize: 12,
                      color: Colors.grey[700]!,
                    ),
                  ),
                if (interestLevel?.isNotEmpty == true)
                  Flexible(
                    child: _buildText(
                      interestLevel!,
                      "Interest: ",
                      fontSize: 12,
                      color: Colors.grey[700]!,
                    ),
                  ),
              ],
            ),

            /// Optional: Converted Badge
            if (isConverted == "true")
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Converted",
                  style: TextStyle(
                    color: Colors.green,
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
        required Color color,
        TextOverflow overflow = TextOverflow.ellipsis,
        int? maxLines,
      }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
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
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  Color getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
        return Colors.green.shade600;
      case 'pending':
        return Colors.orange.shade700;
      case 'running':
        return Colors.blue.shade600;
      default:
        return Colors.grey.shade500; // fallback color
    }
  }
}
