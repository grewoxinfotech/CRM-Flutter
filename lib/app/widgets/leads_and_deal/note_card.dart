import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/project/notes/note_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/status/crm_status_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;

  const NoteCard({super.key, required this.note});

  IconData _getNoteIcon(String? type) {
    switch (type) {
      case 'important':
        return LucideIcons.alertCircle;
      case 'general':
        return LucideIcons.banknote;
      default:
        return LucideIcons.stickyNote;
    }
  }

  Color _getNoteColor(BuildContext context, String? type) {
    switch (type) {
      case 'important':
        return Colors.redAccent;
      case 'general':
        return Colors.blueGrey;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    Widget _tile(IconData icon, String title) {
      return CrmCard(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        borderRadius: BorderRadius.circular(AppRadius.small),
        color: Colors.grey.withAlpha(50),
        boxShadow: [],
        child: FittedBox(
          child: Row(
            children: [
              Icon(icon, size: 14, color: AppColors.primary),
              AppSpacing.horizontalSmall,
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return CrmCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.transparent,
                child: CrmIc(
                  icon: LucideIcons.fileText,
                  color: AppColors.primary,
                ),
              ),
              AppSpacing.horizontalSmall,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${note.noteTitle}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      note.description ?? 'No Designation',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.horizontalSmall,
              CrmStatusCard(title: note.noteType!),
            ],
          ),
          AppSpacing.verticalSmall,

          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              if (note.employees != null && note.employees!.isNotEmpty) ...[
                _tile(LucideIcons.users2, note.employees!.join(', ')),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
