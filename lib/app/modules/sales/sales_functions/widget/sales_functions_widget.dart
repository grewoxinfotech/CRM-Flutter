import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/crm/crm_functions/controller/crm_function_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functions/widget/crm_function_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/common/indicators/crm_loading_circle.dart';
import '../controller/sales_function_controller.dart';


class SalesFunctionsWidget extends StatelessWidget {
  const SalesFunctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SalesFunctionController());

    // Observable to track 2-second timeout
    final isTimeout = false.obs;

    // Start 5-second timer
    Future.delayed(const Duration(seconds: 2), () {
      if (controller.functions.isEmpty) {
        isTimeout.value = true;
      }
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppMargin.medium),
      child: Obx(() {
        final functions = controller.functions;

        // Data loaded before timeout
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

        // Data still loading and 5 seconds not passed -> show loader
        if (!isTimeout.value) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: const Center(child: CrmLoadingCircle()),
          );
        }

        // Timeout reached and data still empty -> Access Denied
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
