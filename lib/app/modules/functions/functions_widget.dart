import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/function/controller/function_controller.dart';
import 'package:crm_flutter/app/modules/functions/widget/function_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionsWidget extends StatelessWidget {
  const FunctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FunctionController());
    final functions = controller.functions;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppPadding.small,
        mainAxisSpacing: AppPadding.small,
        mainAxisExtent: 60,
      ),
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: AppPadding.medium),
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder:
          (context, i) => FunctionCard(
            icon: functions[i].icon,
            title: functions[i].title,
            color: functions[i].color,
            onTap: () => Get.to(functions[i].screenBuilder),
          ),
    );
  }
}
