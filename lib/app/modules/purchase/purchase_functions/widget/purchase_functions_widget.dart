import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../purchase/purchase_functions/widget/purchase_function_card.dart';
import '../controller/purchase_function_controller.dart';

class PurchaseFunctionsWidget extends StatelessWidget {
  const PurchaseFunctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PurchaseFunctionController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppMargin.medium),
      child: Column(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
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
