import 'package:crm_flutter/app/data/network/all/crm/company/model/company_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/company/service/company_service.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/company/widgets/company_card.dart';
import 'package:crm_flutter/app/widgets/_screen/crm_future_list.dart';
import 'package:flutter/material.dart';

class CompanyList extends StatelessWidget {
  final int? itemCount;
  final EdgeInsetsGeometry? padding;

  CompanyList({super.key, this.itemCount, this.padding});

  @override
  Widget build(BuildContext context) {
    return CrmFutureList<CompanyModel>(
      padding: padding,
      itemCount: itemCount,
      emptyText: "No Company Found",
      future: CompanyService.getCompany(),
      itemBuilder: (context, company) => CompanyCard(company: company),
    );
  }
}
