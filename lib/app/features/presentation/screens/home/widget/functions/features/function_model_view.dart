// 📁 function_grid.dart

import 'package:crm_flutter/app/features/presentation/screens/home/widget/functions/features/function_model_widget.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionModelView extends StatelessWidget {
  const FunctionModelView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = FunctionModel.all();

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
        return GestureDetector(
          onTap: () {
            if (item.screenBuilder != null) {
              Get.to(item.screenBuilder!());
            }
          },
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
                  color: item.color,
                  child: CrmIcon(iconPath: item.iconPath,color: Get.theme.colorScheme.surface, width: 24),
                ),
                const SizedBox(height: 10),
                Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: item.color,
                  ),
                ),
                Text(
                  "${item.count} items",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
