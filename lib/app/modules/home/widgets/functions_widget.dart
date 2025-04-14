import 'package:crm_flutter/app/data/models/function_model.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:crm_flutter/app/widgets/function/function_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionsWidget extends StatelessWidget {
  const FunctionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FunctionModel> functions = FunctionModel.getFunctions();
    return CrmCard(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CrmHeadline(title: "App Functionalities"),

          const SizedBox(height: 10),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.2,
              mainAxisExtent: 125,
            ),
            itemCount: functions.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return FunctionCard(
                iconPath: functions[i].iconPath,
                title: functions[i].title,
                subTitle: functions[i].count.toString(),
                color: functions[i].color,
                onTap:
                    () =>
                        (functions[i].screenBuilder != null)
                            ? Get.to(functions[i].screenBuilder)
                            : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
