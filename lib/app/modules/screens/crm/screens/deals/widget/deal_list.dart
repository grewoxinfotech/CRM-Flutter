import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/deal/service/deal_service.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/deals/widget/deal_card.dart';
import 'package:crm_flutter/app/widgets/_screen/crm_future_list.dart';
import 'package:flutter/material.dart';

class DealList extends StatelessWidget {
  final int? itemCount;
  final EdgeInsetsGeometry? padding;

  DealList({super.key, this.itemCount, this.padding});

  @override
  Widget build(BuildContext context) {
    return CrmFutureList(
      padding: padding,
      itemCount: itemCount,
      physics: NeverScrollableScrollPhysics(),
      emptyText: "No Deal Found",
      future: DealService.getDeals(),
      itemBuilder: (context, deal) => DealCard(deal: deal),
    );
  }
}
