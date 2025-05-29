import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/all/crm/company/model/company_model.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/company/widgets/company_overview.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CompanyCard extends StatelessWidget {
  final CompanyModel company;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CompanyCard({
    super.key,
    required this.company,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(CompanyOverview(), arguments: company),
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
                    company.companyName ?? 'No Company Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color:AppColors. textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            AppSpacing.verticalSmall,

            // Company type & category
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _tag(LucideIcons.building2, company.companyType),
                _tag(LucideIcons.tags, company.companyCategory),
              ],
            ),
            AppSpacing.verticalSmall,

            // Contact info
            _infoRow(LucideIcons.mail, company.email),
            _infoRow(
              LucideIcons.phone,
              '${company.phoneCode ?? ''} ${company.phoneNumber ?? ''}',
            ),
            _infoRow(LucideIcons.globe, company.website),
            AppSpacing.verticalSmall,

            // Address section
            Row(
              children: [
                Expanded(
                  child: _locationBox(
                    'Billing',
                    company.billingCity,
                    company.billingCountry,
                    LucideIcons.wallet,
                  ),
                ),
                AppSpacing.horizontalSmall,
                Expanded(
                  child: _locationBox(
                    'Shipping',
                    company.shippingCity,
                    company.shippingCountry,
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
          AppSpacing.horizontalSmall,
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color:AppColors. textSecondary,
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
            Icon(icon, size: 16, color:AppColors. primary),
            AppSpacing.horizontalSmall,
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
              AppSpacing.horizontalSmall,
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
              color:AppColors. textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
