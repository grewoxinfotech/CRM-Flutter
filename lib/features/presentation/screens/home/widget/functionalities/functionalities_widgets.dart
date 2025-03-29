import 'package:crm_flutter/features/presentation/screens/home/widget/functionalities/model/function_model.dart';
import 'package:crm_flutter/features/presentation/screens/home/widget/functionalities/widget/functions_box.dart';
import 'package:crm_flutter/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionalitiesWidgets extends StatelessWidget {
  const FunctionalitiesWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    List<FunctionModel> functionitems = FunctionModel.getFunctionitems();
    List<String> unitId = [];

    List<FunctionModel> filteredFunctions =
        unitId.isEmpty
            ? functionitems
            : functionitems
                .where((item) => unitId.contains(item.unitId))
                .toList();
    return CrmContainer(
      width: 500,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const CrmHeadline(title: "App Functionalities"),
          const SizedBox(height: 20),
          SizedBox(
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
                return FunctionsBox(
                  title: filteredFunctions[index].title.toString(),
                  icon: filteredFunctions[index].imagePath.toString(),
                  color: filteredFunctions[index].color,
                  onTap: () => Get.to(filteredFunctions[index].widget),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
