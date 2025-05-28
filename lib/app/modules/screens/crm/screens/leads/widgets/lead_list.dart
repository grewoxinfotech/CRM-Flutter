import 'package:crm_flutter/app/data/network/all/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/lead/service/lead_service.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/widgets/lead_card.dart';
import 'package:crm_flutter/app/widgets/_screen/crm_future_list.dart';
import 'package:flutter/material.dart';

class LeadList extends StatelessWidget {
  final int? itemCount;
  final EdgeInsetsGeometry? padding;

  LeadList({super.key, this.itemCount, this.padding});

  @override
  Widget build(BuildContext context) {
    return CrmFutureList<LeadModel>(
      padding: padding,
      itemCount: itemCount,
      emptyText: "No Lead Found",
      future: LeadService.getLeads(),
      itemBuilder: (context, lead) => LeadCard(lead: lead),
    );
  }
}
