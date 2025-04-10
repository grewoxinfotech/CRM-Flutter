// 📁 function_grid.dart

import 'package:crm_flutter/app/config/themes/resources/icon_resources.dart';
import 'package:crm_flutter/app/features/data/deal/deal_controller.dart';
import 'package:crm_flutter/app/features/data/lead/lead_controller.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead_&_deal/screens/deal/deals_screen.dart';
import 'package:crm_flutter/app/features/presentation/screens/lead_&_deal/screens/lead/leads_screen.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionModelView extends StatelessWidget {
  const FunctionModelView({super.key});

  @override
  Widget build(BuildContext context) {
    final LeadController leadController = Get.put(LeadController());
    final DealController dealController = Get.put(DealController());

    final items = [
      FunctionModel(
        title: 'Leads',
        iconPath: ICRes.leads,
        color: const Color(0xffFFBD21),
        count: leadController.leadsList.length,
        screenBuilder: () => LeadsScreen(),
      ),
      FunctionModel(
        title: 'Deals',
        iconPath: ICRes.leads,
        color: const Color(0xff28B999),
        count: dealController.dealsList.length,
        screenBuilder: () => DealsScreen(),
      ),
      FunctionModel(
        title: 'Tasks',
        iconPath: ICRes.task,
        color: const Color(0xff0AC947),
        count: 56,
      ),
      FunctionModel(
        title: 'Customer',
        iconPath: ICRes.custemer,
        color: const Color(0xff6D5DD3),
        count: 10,
      ),
      FunctionModel(
        title: 'Employee',
        iconPath: ICRes.employees,
        color: const Color(0xff2B648F),
        count: 4,
      ),
      FunctionModel(
        title: 'Clients',
        iconPath: ICRes.clients,
        color: const Color(0xffFFCC01),
        count: 45,
      ),
      FunctionModel(
        title: 'Contract',
        iconPath: ICRes.contract,
        color: const Color(0xff3400AD),
        count: 66,
      ),
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1.2,
        mainAxisExtent: 140,
      ),
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, i) {
        final item = items[i];
        return Column(
          children: [
            tile(
              iconPath: item.iconPath,
              title: item.title,
              subTitle: item.count.toString(),
              color: item.color,
              onTap: () => (item.screenBuilder != null)
                    ? Get.to(item.screenBuilder!())
                    : null,
            ),
          ],
        );
      },
    );
  }
}

class FunctionModel {
  final String title;
  final String iconPath;
  final Color color;
  final int count;
  final Widget Function()? screenBuilder;

  FunctionModel({
    required this.title,
    required this.iconPath,
    required this.color,
    required this.count,
    this.screenBuilder,
  });
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
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.outline.withOpacity(0.2),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CrmContainer(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              color: color,
              child: CrmIcon(
                iconPath: iconPath.toString(),
                color: Get.theme.colorScheme.surface,
                width: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
            Obx(
              () => Text(
                subTitle.toString(),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
