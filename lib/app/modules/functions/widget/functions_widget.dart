import 'package:crm_flutter/app/modules/functions/controller/function_controller.dart';
import 'package:crm_flutter/app/modules/functions/widget/function_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionsWidget extends StatelessWidget {
  const FunctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FunctionController());
    return CrmCard(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CrmHeadline(title: "App Functionalities"),

          const SizedBox(height: 10),
          Obx(
            ()=> GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
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
          ),
        ],
      ),
    );
  }
}
