import 'package:crm_flutter/app/care/constants/size/margin_res.dart';
import 'package:crm_flutter/app/care/constants/size/padding_res.dart';
import 'package:crm_flutter/app/care/constants/size/space.dart';
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
      margin: MarginRes.horizontal4,
      padding: PaddingRes.all2,
      child: Column(
        children: [
          CrmHeadline(title: "App Functionalities"),

          Space(size: 10),
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
