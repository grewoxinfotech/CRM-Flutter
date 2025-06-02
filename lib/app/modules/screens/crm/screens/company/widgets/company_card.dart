import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/company/model/company_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CompanyCard extends StatelessWidget {
  final CompanyModel? company;

  const CompanyCard({super.key,this.company});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Company name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "N/A",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),

            // Company type & category
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _tag(LucideIcons.building2, "N/A"),
                _tag(LucideIcons.tags, "N/A"),
              ],
            ),
            SizedBox(width: 10),

            // Contact info
            _infoRow(LucideIcons.mail, "N/A"),
            _infoRow(LucideIcons.phone, '"N/A" "N/A"'),
            _infoRow(LucideIcons.globe, "N/A"),
            SizedBox(width: 10),

            // Address section
            Row(
              children: [
                Expanded(
                  child: _locationBox(
                    'Billing',
                    "N/A",
                    "N/A",
                    LucideIcons.wallet,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _locationBox(
                    'Shipping',
                    "N/A",
                    "N/A",
                    LucideIcons.truck,
                  ),
                ),
              ],
            ),

            // Description
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
          Icon(icon, size: 16, color: AppColors.primary),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(IconData icon, String? label) {
    if (label == null || label.isEmpty) return const SizedBox();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(AppRadius.small),
      ),
      child: FittedBox(
        child: Row(
          children: [
            Icon(icon, size: 16, color: AppColors.primary),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationBox(
    String title,
    String? city,
    String? country,
    IconData icon,
  ) {
    return CrmCard(
      padding: const EdgeInsets.all(AppPadding.small),
      color: Colors.blue.shade50,
      boxShadow: [],
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.blueAccent),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${city ?? "-"}, ${country ?? "-"}',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
