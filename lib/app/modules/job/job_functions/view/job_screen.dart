import 'package:crm_flutter/app/modules/job/job_functions/controller/job_function_controller.dart';
import 'package:crm_flutter/app/modules/job/job_functions/widget/job_function_widget.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobScreen extends StatelessWidget {
  final controller = Get.put(JobFunctionController());

  JobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List widgets = [JobFunctionsWidget()];

    return Scaffold(
      appBar: AppBar(title: Text("Job")),
      body: ViewScreen(
        itemCount: widgets.length,
        itemBuilder: (context, i) => widgets[i],
      ),
    );
  }
}
