// 📁 functions_section.dart

import 'package:crm_flutter/app/features/screens/home/widget/functions/features/function_model_view.dart';
import 'package:crm_flutter/app/features/widgets/crm_card.dart';
import 'package:crm_flutter/app/features/widgets/crm_headline.dart';
import 'package:flutter/material.dart';

class FunctionsWidgets extends StatelessWidget {
  const FunctionsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return const CrmCard(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          CrmHeadline(title: "App Functionalities"),
          SizedBox(height: 10),
          FunctionModelView(),
        ],
      ),
    );
  }
}
