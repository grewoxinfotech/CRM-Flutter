import 'package:crm_flutter/app/modules/task/task/controller/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskEditScreen extends StatelessWidget {
  const TaskEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<TaskController>(()=>TaskController());
    final TaskController taskController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
      ),
    );
  }
}
