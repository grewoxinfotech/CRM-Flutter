import 'package:crm_flutter/app/modules/screens/crm/screens/task/controller/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskEditScreen extends StatelessWidget {
  const TaskEditScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final taskController = Get.put(TaskController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
      ),
    );
  }
}
