import 'package:crm_flutter/app/modules/screens/crm/screens/task/controller/task_controller.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/views/task_add_screen.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/task/widget/task_list.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: const Text("Tasks")),
      floatingActionButton: CrmButton(
        title: "Add Task",
        onTap: () => Get.to(TaskAddScreen()),
      ),
      body: TaskList(),
    );
  }
}
