import 'package:crm_flutter/app/config/themes/resources/color_resources.dart';
import 'package:crm_flutter/app/features/screens/home/widget/functions/features/function_model.dart';
import 'package:crm_flutter/app/features/widgets/crm_card.dart';
import 'package:crm_flutter/app/features/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionModelView extends StatelessWidget {
  const FunctionModelView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FunctionModel> functions = FunctionModel.getFunctions();
    return GridView.builder(
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
        return tile(
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
    );
  }
}

class tile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? title;
  final String? subTitle;
  final String? iconPath;
  final Color? color;

  const tile({
    super.key,
    this.iconPath,
    this.color,
    this.title,
    this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CrmCard(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        color: Get.theme.colorScheme.primary.withAlpha(15),
        borderRadius: BorderRadius.circular(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CrmCard(
              width: 50,
              height: 50,
              color: color,
              child: CrmIcon(
                iconPath: iconPath.toString(),
                color: Get.theme.colorScheme.surface,
                width: 24,
              ),
            ),
            Column(
              children: [
                Text(
                  title.toString(),
                  style: TextStyle(fontWeight: FontWeight.w700, color: COLORRes.TEXT_PRIMARY),
                ),

                Text(
                  subTitle.toString() + " Items",
                  style: TextStyle(fontSize: 10, color: COLORRes.TEXT_PRIMARY.withAlpha(100)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
