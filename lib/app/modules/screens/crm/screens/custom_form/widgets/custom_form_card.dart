import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/custom_form/custom_form_model.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/custom_form/widgets/custom_form_overview.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomFormCard extends StatelessWidget {
  final CustomFormModel customForm;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CustomFormCard({
    super.key,
    required this.customForm,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(CustomFormOverview(), arguments: customForm),
      child: CrmCard(
        padding: EdgeInsets.all(AppPadding.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    customForm.title ?? 'Untitled Form',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textPrimary,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, color: divider),
              ],
            ),

            /// Description
            if ((customForm.description ?? '').isNotEmpty)
              Text(
                customForm.description!,
                style: TextStyle(
                  fontSize: 12,
                  color: textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            AppSpacing.verticalSmall,

            /// Event Info
            _infoRow(
              LucideIcons.calendarClock,
              _dateRange(customForm.startDate, customForm.endDate),
            ),
            _infoRow(LucideIcons.mapPin, customForm.eventLocation),
            _infoRow(LucideIcons.partyPopper, customForm.eventName),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String? value) {
    if (value == null || value.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: textPrimary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }


  String _dateRange(DateTime? start, DateTime? end) {
    if (start == null || end == null) return '-';
    return '${_formatDate(start)} → ${_formatDate(end)}';
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
