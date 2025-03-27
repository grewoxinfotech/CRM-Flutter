import 'package:crm_flutter/features/data/models/model_functionalities.dart';
import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_container.dart';
import 'package:crm_flutter/features/presentation/widgets/widget_custem/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildAppFunctionsSection(BuildContext context) {
  List<FunctionModel> functionitems = FunctionModel.getFunctionitems();
  List<String> unitId = [];

  List<FunctionModel> filteredFunctions = unitId.isEmpty
      ? functionitems
      : functionitems.where((item) => unitId.contains(item.unitId)).toList();

  return CrmContainer(
    margin: const EdgeInsets.symmetric(horizontal: 20),

    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        const CrmHeadline(title: "App Functionalities", showViewAll: false),
        // /// Pie Chart with Default Data Handling
        // buildPieChart(
        //   filteredFunctions.isNotEmpty
        //       ? filteredFunctions.map((items) => buildPieChartSection(items.num ?? 1, items.color ?? Colors.grey)).toList()
        //       : [buildPieChartSection(1, Colors.grey)],
        // ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SizedBox(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 24,
                mainAxisExtent: 160,
              ),
              itemCount: filteredFunctions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(filteredFunctions[index].unitId.toString());
                  },
                  child: CrmContainer(
                    borderRadius: BorderRadius.circular(30),
                    color: Get.theme.colorScheme.outline.withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: filteredFunctions[index].color,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Image.asset(
                            filteredFunctions[index].imagePath.toString(),
                            width: 50,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(filteredFunctions[index].title.toString()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}
