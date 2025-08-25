import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/crm/crm_functions/controller/crm_function_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functions/widget/crm_function_card.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class CrmFunctionsWidget extends StatelessWidget {
//   const CrmFunctionsWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(CrmFunctionController());
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: AppMargin.medium),
//       child: Obx(() {
//         final functions = controller.functions;
//
//         // Return empty container if list is empty
//         if (functions.isEmpty) {
//           return SizedBox(
//             height:
//                 MediaQuery.of(context).size.height * 0.7, // or a fixed height
//             child: const Center(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.lock_outline, size: 48, color: Colors.grey),
//                   SizedBox(height: 8),
//                   Text(
//                     "Access Denied",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//
//         return Column(
//           children: [
//             GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: AppPadding.small,
//                 crossAxisSpacing: AppPadding.small,
//                 childAspectRatio: 1.2,
//                 mainAxisExtent: 125,
//               ),
//               itemCount: functions.length,
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemBuilder: (context, i) {
//                 final func = functions[i];
//                 return FunctionCard(
//                   iconPath: func.iconPath,
//                   title: func.title,
//                   color: func.color,
//                   onTap:
//                       func.screenBuilder != null
//                           ? () => Get.to(func.screenBuilder)
//                           : null,
//                 );
//               },
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

class CrmFunctionsWidget extends StatelessWidget {
  const CrmFunctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CrmFunctionController());

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
