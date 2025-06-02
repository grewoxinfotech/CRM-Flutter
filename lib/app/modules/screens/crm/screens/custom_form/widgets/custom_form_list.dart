import 'package:crm_flutter/app/data/network/all/crm/custom_form/custom_form_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/custom_form/custom_form_service.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/custom_form/widgets/custom_form_card.dart';
import 'package:crm_flutter/app/widgets/_screen/crm_future_list.dart';
import 'package:flutter/material.dart';

class CustomFormList extends StatelessWidget {
  final int? itemCount;
  final EdgeInsetsGeometry? padding;

  CustomFormList({super.key, this.itemCount, this.padding});

  @override
  Widget build(BuildContext context) {
    return CrmFutureList(
      padding: padding,
      itemCount: itemCount,
      physics: NeverScrollableScrollPhysics(),
      emptyText: "No Custom Form Found",
      future: CustomFormService.getCustomFrom(),
      itemBuilder:
          (context, customForm) => CustomFormCard(),
    );
  }
}
