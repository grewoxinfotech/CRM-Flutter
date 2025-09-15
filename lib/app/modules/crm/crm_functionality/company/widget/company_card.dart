import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/crm/company/model/company_model.dart';
import '../controller/company_controller.dart';
import '../view/company_detail_screen.dart';

class CompanyCard extends StatelessWidget {
  final CompanyData company;
  final Function(CompanyData)? onTap;

  const CompanyCard({super.key, required this.company, this.onTap});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        company.createdAt != null
            ? DateFormat(
              'dd MMM yyyy',
            ).format(DateTime.parse(company.createdAt!))
            : 'N/A';

    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!(company);
        } else {
          Get.to(() => CompanyDetailScreen(id: company.id!));
        }
      },
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Text(
                    (company.companyName != null &&
                            company.companyName!.isNotEmpty)
                        ? company.companyName![0].toUpperCase()
                        : '?',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company.companyName ?? 'No Name',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      if (company.phoneNumber != null &&
                          company.phoneNumber!.isNotEmpty)
                        _buildInfoRow('Phone', company.phoneNumber!),
                      if (company.email != null && company.email!.isNotEmpty)
                        _buildInfoRow('Email', company.email!),
                      if (company.website != null &&
                          company.website!.isNotEmpty)
                        _buildInfoRow('Website', company.website!),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(formattedDate, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text('$label: $value', style: const TextStyle(fontSize: 12)),
    );
  }
}
