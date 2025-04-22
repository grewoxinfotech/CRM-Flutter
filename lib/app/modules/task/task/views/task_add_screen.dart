import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/data/models/task/task/task_model.dart';
import 'package:crm_flutter/app/modules/task/task/controller/task_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskAddScreen extends StatelessWidget {
  final TaskModel? task;

  const TaskAddScreen({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.put(TaskController());

    List<Widget> items = [
      CrmTextField(
        title: "Task Name",
        controller: taskController.taskNameController,
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Enter task name' : null,
      ),
      CrmTextField(
        title: "Category",
        controller: taskController.categoryController,
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Enter task name' : null,
      ),
      CrmTextField(
        title: "Project",
        controller: taskController.projectController,
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Enter task name' : null,
      ),
      CrmTextField(
        title: "Lead",
        controller: taskController.leadController,
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Enter task name' : null,
      ),
      CrmTextField(
        title: "File",
        controller: taskController.fileController,
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Enter task name' : null,
      ),
      CrmTextField(
        title: "Description",
        controller: taskController.descriptionController,
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Enter task name' : null,
      ),
      SizedBox(),
      CrmButton(
        onTap: () =>taskController.addTask(),
        title: "Save",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const CrmBackButton(),
        title: const Text("Create New Task"),
      ),
      body: ListView.separated(
        itemCount: items.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        separatorBuilder: (context, s) => const SizedBox(height: 20),
        itemBuilder: (context, i) {
          return items[i];
        },
      ),
    );
  }
}
