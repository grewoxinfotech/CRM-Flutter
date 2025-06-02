import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/project/notes/note_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NoteCard extends StatelessWidget {
  final NoteModel? note;

  const NoteCard({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    Widget _tile(IconData icon, String title, Color color) {
      return CrmCard(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        borderRadius: BorderRadius.circular(AppRadius.small),
        color: color.withAlpha(30),
        boxShadow: [],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      );
    }

    return CrmCard(
      padding: const EdgeInsets.all(AppPadding.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${note!.noteTitle}",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    note!.description! ?? 'No Designation',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              CrmIc(icon: LucideIcons.moreVertical, color: AppColors.primary),
            ],
          ),
          _tile(LucideIcons.file, note!.noteType!, AppColors.success),
        ],
      ),
    );
  }
}
