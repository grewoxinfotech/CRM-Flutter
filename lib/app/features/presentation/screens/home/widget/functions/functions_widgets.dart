
import 'package:crm_flutter/app/features/presentation/screens/home/widget/functions/features/function_model_view.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FunctionsWidgets extends StatelessWidget {
  const FunctionsWidgets({super.key});

  @override
  Widget build(BuildContext context) {

    return CrmContainer(
      width: 500,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const CrmHeadline(title: "App Functionalities"),
          const SizedBox(height: 20),
          const FunctionModelView(),
        ],
      ),
    );
  }
}
