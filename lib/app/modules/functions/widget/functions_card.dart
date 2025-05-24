import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/function/model/function_model.dart';
import 'package:crm_flutter/app/modules/functions/widget/function_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionsCard extends StatelessWidget {
  const FunctionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final functions = FunctionModel.getFunctions();
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppPadding.small,
        mainAxisSpacing: AppPadding.small,
        mainAxisExtent: 60,
      ),
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: AppPadding.medium),
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder:
          (context, i) => FunctionCard(
            icon: functions[i].icon,
            title: functions[i].title,
            color: functions[i].color,
            onTap: () => Get.toNamed(functions[i].appRoutes!),
          ),
    );
  }
}
