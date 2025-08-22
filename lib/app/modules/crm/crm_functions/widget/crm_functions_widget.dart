import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/crm/crm_functions/controller/crm_function_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functions/widget/crm_function_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class CrmFunctionsWidget extends StatelessWidget {
//   const CrmFunctionsWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(CrmFunctionController());
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: AppMargin.medium),
//       child: Column(
//         children: [
//           GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: AppPadding.small,
//               crossAxisSpacing: AppPadding.small,
//               childAspectRatio: 1.2,
//               mainAxisExtent: 125,
//             ),
//             itemCount: controller.functions.length,
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (context, i) {
//               return FunctionCard(
//                 iconPath: controller.functions[i].iconPath,
//                 title: controller.functions[i].title,
//                 color: controller.functions[i].color,
//                 onTap:
//                     () =>
//                         (controller.functions[i].screenBuilder != null)
//                             ? Get.to(controller.functions[i].screenBuilder)
//                             : null,
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

class CrmFunctionsWidget extends StatelessWidget {
  const CrmFunctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CrmFunctionController());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppMargin.medium),
      child: Obx(() {
        final functions = controller.functions;

        // Return empty container if list is empty
        if (functions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
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
            ),
          ],
        );
      }),
    );
  }
}
