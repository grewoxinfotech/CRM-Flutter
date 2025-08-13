import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/crm/crm_functions/controller/crm_function_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functions/widget/crm_function_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/sales_function_controller.dart';

class SalesFunctionsWidget extends StatelessWidget {
  const SalesFunctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SalesFunctionController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppMargin.medium),
      child: Column(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppPadding.small,
              crossAxisSpacing: AppPadding.small,
              childAspectRatio: 1.2,
              mainAxisExtent: 125,
            ),
            itemCount: controller.functions.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return FunctionCard(
                iconPath: controller.functions[i].iconPath,
                title: controller.functions[i].title,
                color: controller.functions[i].color,
                onTap:
                    () =>
                        (controller.functions[i].screenBuilder != null)
                            ? Get.to(controller.functions[i].screenBuilder)
                            : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
