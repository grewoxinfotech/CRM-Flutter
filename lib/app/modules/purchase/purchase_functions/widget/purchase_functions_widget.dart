import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/common/indicators/crm_loading_circle.dart';
import '../../../purchase/purchase_functions/widget/purchase_function_card.dart';
import '../controller/purchase_function_controller.dart';

class PurchaseFunctionsWidget extends StatelessWidget {
  const PurchaseFunctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PurchaseFunctionController());

    // Track if 5-second timeout reached
    final isTimeout = false.obs;

    // Start 2-second timer
    Future.delayed(const Duration(seconds: 2), () {
      if (controller.functions.isEmpty) {
        isTimeout.value = true;
      }
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppMargin.medium),
      child: Obx(() {
        final functions = controller.functions;

        // Data loaded before timeout -> show grid
        if (functions.isNotEmpty) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppPadding.small,
              crossAxisSpacing: AppPadding.small,
              childAspectRatio: 1.2,
              mainAxisExtent: 125,
            ),
            itemCount: functions.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, i) {
              final func = functions[i];
              return FunctionCard(
                iconPath: func.iconPath,
                title: func.title,
                color: func.color,
                onTap:
                    func.screenBuilder != null
                        ? () => Get.to(func.screenBuilder)
                        : null,
              );
            },
          );
        }

        // Data still loading, timeout not reached -> show loader
        if (!isTimeout.value) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: const Center(child: CrmLoadingCircle()),
          );
        }

        // Timeout reached, data still empty -> Access Denied
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
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
      }),
    );
  }
}
