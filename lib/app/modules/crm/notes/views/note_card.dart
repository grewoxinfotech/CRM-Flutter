import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteCard extends StatelessWidget {
  final String? id;
  final String? relatedId;
  final String? noteTitle;
  final String? noteType;
  final String? description;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final GestureTapCallback? onEdit;

  const NoteCard({
    super.key,
    this.id,
    this.relatedId,
    this.noteTitle,
    this.noteType,
    this.description,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.onTap,
    this.onDelete,
    this.onEdit,
  });

  Color _getNoteTypeColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'important':
        return ColorRes.warning;
      case 'urgent':
        return ColorRes.error;
      case 'normal':
      default:
        return ColorRes.success;
    }
  }

  Color _getNoteTypeBackgroundColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'important':
        return ColorRes.warning.withOpacity(0.1);
      case 'urgent':
        return ColorRes.error.withOpacity(0.1);
      case 'normal':
      default:
        return ColorRes.success.withOpacity(0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Get.theme.colorScheme.onPrimary;
    final Color secondary = Get.theme.colorScheme.onSecondary;
    final Color borderColor = Get.theme.dividerColor;
    final noteTypeColor = _getNoteTypeColor(noteType);
    final noteTypeBgColor = _getNoteTypeBackgroundColor(noteType);

    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Type
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    noteTitle ?? 'Untitled Note',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppPadding.small),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.small,
                    vertical: AppPadding.small / 2,
                  ),
                  decoration: BoxDecoration(
                    color: noteTypeBgColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: noteTypeColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    noteType ?? 'normal',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: noteTypeColor,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppPadding.small),

            // Description
            Text(
              description ?? 'No description available.',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: secondary,
              ),
            ),

            Divider(color: borderColor, height: AppPadding.medium),

            // Metadata and Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Meta Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ID: ${id ?? '-'}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: secondary,
                      ),
                    ),
                    Text(
                      "Created: ${createdAt ?? '-'}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: secondary,
                      ),
                    ),
                  ],
                ),

                // Action Buttons
                Row(
                  children: [
                    CrmIc(
                      iconPath: ICRes.edit,
                      color: ColorRes.success,
                      onTap: onEdit,
                    ),
                    AppSpacing.horizontalMedium,
                    CrmIc(
                      iconPath: ICRes.delete,
                      color: ColorRes.error,
                      onTap: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
