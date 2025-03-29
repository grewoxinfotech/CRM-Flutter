import 'package:crm_flutter/app/features/presentation/screens/home/widget/functions/features/function_model_widget.dart';
import 'package:crm_flutter/app/features/presentation/screens/home/widget/functions/widget/function_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionModelView extends StatelessWidget {
  const FunctionModelView({super.key});

  @override
  Widget build(BuildContext context) {
    List<FunctionModelWidget> functionitems = FunctionModelWidget.getwidgets();
    List<String> unitId = [];

    List<FunctionModelWidget> filteredFunctions =
        unitId.isEmpty
            ? functionitems
            : functionitems
                .where((item) => unitId.contains(item.unitId))
                .toList();
    return SizedBox(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: filteredFunctions.length,
        itemBuilder: (context, index) {
          return FunctionTile(
            title: filteredFunctions[index].title.toString(),
            icon: filteredFunctions[index].imagePath.toString(),
            color: filteredFunctions[index].color,
            onTap: () => Get.to(filteredFunctions[index].widget),
          );
        },
      ),
    );
  }
}
