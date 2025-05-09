import 'package:crm_flutter/app/care/constants/size_manager.dart';
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
      margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
      padding: EdgeInsets.all(AppPadding.small),
      child: Column(
        children: [
          CrmHeadline(title: "App Functionalities"),
          AppSpacing.verticalSmall,
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
