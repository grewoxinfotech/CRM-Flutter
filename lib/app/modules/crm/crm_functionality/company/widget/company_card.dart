import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../../../../data/network/crm/company/model/company_model.dart';
import '../controller/company_controller.dart';
import '../view/company_detail_screen.dart';

class CompanyCard extends StatelessWidget {
  final Data company;
  final Function(Data)? onTap;

  const CompanyCard({super.key, required this.company, this.onTap});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        company.createdAt != null
            ? DateFormat(
              'dd MMM yyyy',
            ).format(DateTime.parse(company.createdAt!))
            : 'N/A';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap!(company);
          } else {
            Get.to(() => CompanyDetailScreen(id: company.id!));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
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
                    if (company.website != null && company.website!.isNotEmpty)
                      _buildInfoRow('Website', company.website!),
                    // if (company.industry != null &&
                    //     company.industry!.isNotEmpty)
                    //   _buildInfoRow('Industry', company.!),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(formattedDate, style: const TextStyle(fontSize: 12)),
                  // if (company.country != null && company.country!.isNotEmpty)
                  //   Container(
                  //     margin: const EdgeInsets.only(top: 4),
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 6,
                  //       vertical: 2,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey[200],
                  //       borderRadius: BorderRadius.circular(4),
                  //     ),
                  //     child: Text(
                  //       company.country!,
                  //       style: const TextStyle(fontSize: 10),
                  //     ),
                  //   ),
                ],
              ),
            ],
          ),
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
