import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/date_time/format_date.dart';



// class ContactLeadCard extends StatelessWidget {
//   final String? title;
//   final String? stage;
//   final int? value;
//   final String? currency;
//   final String? pipeline;
//   final String? status;
//   final String? createdAt;
//   final VoidCallback? onTap;
//   final VoidCallback? onEdit;
//   final VoidCallback? onDelete;
//
//   const ContactLeadCard({
//     super.key,
//     this.title,
//     this.stage,
//     this.value,
//     this.currency,
//     this.pipeline,
//     this.status,
//     this.createdAt,
//     this.onTap,
//     this.onEdit,
//     this.onDelete,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final Color textPrimary = Get.theme.colorScheme.onPrimary;
//     final Color textSecondary = Get.theme.colorScheme.onSecondary;
//
//     return GestureDetector(
//       onTap: onTap,
//       child: CrmCard(
//         padding: const EdgeInsets.all(AppPadding.medium),
//         borderRadius: BorderRadius.circular(AppRadius.large),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title & Edit/Delete
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     title ?? "Lead Title",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       color: Get.theme.colorScheme.primary,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     if (onEdit != null)
//                       IconButton(
//                         icon: Icon(Icons.edit_outlined, color: Colors.green),
//                         onPressed: onEdit,
//                       ),
//                     if (onDelete != null)
//                       IconButton(
//                         icon: Icon(
//                           Icons.delete,
//                           color: Get.theme.colorScheme.error,
//                         ),
//                         onPressed: onDelete,
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//
//             // Stage & Status
//             Row(
//               children: [
//                 _infoItem("Stage", stage),
//                 _infoItem("Status", status),
//               ],
//             ),
//             const SizedBox(height: 8),
//
//             // Value & Pipeline
//             Row(
//               children: [
//                 _infoItem(
//                   "Value",
//                   (value != null && currency != null)
//                       ? "$currency $value"
//                       : "-",
//                 ),
//                 _infoItem("Pipeline", pipeline),
//               ],
//             ),
//             const SizedBox(height: 8),
//
//             // Created Date
//             _infoItem("Created", formatDate(createdAt ?? '')),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _infoItem(String label, String? value) {
//     final Color labelColor = Get.theme.colorScheme.onSecondary;
//     final Color valueColor = Get.theme.colorScheme.onPrimary;
//
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: labelColor,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 2),
//           Text(
//             value?.isNotEmpty == true ? value! : '-',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w700,
//               color: valueColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ContactLeadCard extends StatelessWidget {
  final String? title;
  final String? stage;
  final int? value;
  final String? currency;
  final String? pipeline;
  final String? status;
  final String? createdAt;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ContactLeadCard({
    super.key,
    this.title,
    this.stage,
    this.value,
    this.currency,
    this.pipeline,
    this.status,
    this.createdAt,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: ListTile(
        onTap: onTap,
        title: Text(
          title ?? 'Untitled Lead',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoLine('Stage', stage),
              _infoLine('Status', status),
              _infoLine(
                'Value',
                (value != null && currency != null) ? "$currency $value" : null,
              ),
              _infoLine('Pipeline', pipeline),
              _infoLine('Created', formatDate(createdAt ?? '')),
            ],
          ),
        ),
        trailing: Wrap(
          spacing: 4,
          children: [
            if (onEdit != null)
              IconButton(
                icon: const Icon(Icons.edit_outlined, color: Colors.green),
                onPressed: onEdit,
              ),
            if (onDelete != null)
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: theme.colorScheme.error,
                ),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }

  Widget _infoLine(String label, String? value) {
    return Text(
      "$label: ${value?.isNotEmpty == true ? value : '-'}",
      style: const TextStyle(fontSize: 13),
    );
  }
}
