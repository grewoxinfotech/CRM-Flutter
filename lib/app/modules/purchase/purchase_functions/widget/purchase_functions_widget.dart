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
      child: Obx(() {
        final functions = controller.functions;

        // Return empty container if list is empty
        if (functions.isEmpty) {
          return SizedBox(
            height:
                MediaQuery.of(context).size.height * 0.7, // or a fixed height
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_outline, size: 48, color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    "Access Denied",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          );
        }
        return Column(
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
        );
      }),
    );
  }
}
