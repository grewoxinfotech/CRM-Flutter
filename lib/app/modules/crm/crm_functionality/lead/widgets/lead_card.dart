

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
