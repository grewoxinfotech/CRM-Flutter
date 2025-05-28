import 'package:crm_flutter/app/data/network/all/crm/company/model/company_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyOverview extends StatelessWidget {
  const CompanyOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final CompanyModel company = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(company.companyName!),
      ),
    );
  }
}
