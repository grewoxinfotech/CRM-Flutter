// 📁 functions_section.dart

import 'package:crm_flutter/app/features/presentation/screens/home/widget/functions/features/function_model_view.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_container.dart';
import 'package:crm_flutter/app/features/presentation/widgets/crm_headline.dart';
import 'package:flutter/material.dart';

class FunctionsWidgets extends StatelessWidget {
  const FunctionsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return CrmContainer(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(10),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CrmHeadline(
            title: "App Functionalities",
            padding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          const SizedBox(height: 10),
          FunctionModelView(),
        ],
      ),
    );
  }
}
