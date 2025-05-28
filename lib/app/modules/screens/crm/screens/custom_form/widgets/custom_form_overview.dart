import 'package:crm_flutter/app/data/network/all/crm/custom_form/custom_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFormOverview extends StatelessWidget {
  const CustomFormOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomFormModel customForm = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(customForm.title!),
      ),
    );
  }
}
