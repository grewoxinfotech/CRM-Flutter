import 'package:crm_flutter/app/data/network/task/task/model/task_model.dart';
import 'package:crm_flutter/app/modules/task/task/controller/task_controller.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskEditScreen extends StatelessWidget {
  final TaskData task;
  final String userId;

  const TaskEditScreen({super.key, required this.task, required this.userId});

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    taskController.initializeTaskData(task);

    List<Widget> items = [
      CrmTextField(
        title: "Task Name",
        controller: taskController.taskNameController,
        hintText: "Enter task name",
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Enter task name' : null,
        prefixIcon: Icons.task_alt,
        isRequired: true,
      ),

      CrmTextField(
        title: "Start Date",
        controller: taskController.startDateController,
        hintText: "Select start date",
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Select start date' : null,
        prefixIcon: Icons.calendar_today,
        isRequired: true,
        onTap: () => _selectDate(context, taskController.startDateController),
        enabled: true,
      ),

      CrmTextField(
        title: "Due Date",
        controller: taskController.dueDateController,
        hintText: "Select due date",
        validator:
            (value) =>
                value == null || value.isEmpty ? 'Select due date' : null,
        prefixIcon: Icons.event,
        isRequired: true,
        onTap: () => _selectDate(context, taskController.dueDateController),
        enabled: true,
      ),

      CrmDropdownField<String>(
        title: "Priority",
        value: taskController.priority.value,
        hintText: "Select priority",
        isRequired: true,
        prefixIcon: Icons.priority_high,
        items:
            TaskController.priorities
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
        onChanged: (val) => taskController.priority.value = val,
      ),

      CrmDropdownField<String>(
        title: "Status",
        value: taskController.status.value,
        hintText: "Select status",
        isRequired: true,
        prefixIcon: Icons.flag,
        items:
            TaskController.statuses
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
        onChanged: (val) => taskController.status.value = val,
      ),

      Obx(
        () => CrmDropdownField<String>(
          title: "Assign To",
          value: taskController.assignTo.toList(),
          hintText: "Select team members",
          isRequired: true,
          isMultiSelect: true,
          prefixIcon: Icons.people,
          items:
              taskController.teamMembers
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e['username'] as String,
                      child: Text(e['username']?.toString() ?? ''),
                    ),
                  )
                  .toList(),
          onChanged: (val) {
            if (val is List<String>) {
              taskController.assignTo.clear();
              taskController.assignTo.addAll(val);
            }
          },
        ),
      ),

      Obx(
        () => CrmDropdownField<String>(
          title: "Task Reporter",
          value: taskController.taskReporter.value,
          hintText: "Select task reporter",
          isRequired: true,
          prefixIcon: Icons.person,
          items:
              taskController.teamMembers
                  .map(
                    (e) => DropdownMenuItem(
                      value: e['username'] as String,
                      child: Text(e['username']?.toString() ?? ''),
                    ),
                  )
                  .toList(),
          onChanged: (val) => taskController.taskReporter.value = val,
        ),
      ),

      CrmTextField(
        title: "Reminder Date",
        controller: taskController.reminderDateController,
        hintText: "Select reminder date",
        prefixIcon: Icons.notifications,
        onTap:
            () => _selectDate(context, taskController.reminderDateController),
        enabled: true,
      ),

      CrmTextField(
        title: "Description",
        controller: taskController.descriptionController,
        hintText: "Enter task description",
        prefixIcon: Icons.description,
        maxLines: 3,
      ),

      CrmTextField(
        title: "Task File",
        controller: taskController.fileController,
        hintText: "Enter file URL",
        prefixIcon: Icons.attach_file,
      ),

      const SizedBox(height: 20),

      CrmButton(
        onTap: () => taskController.editTask(task),
        title: "Update Task",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const CrmBackButton(),
        title: const Text("Edit Task"),
      ),
      body: ViewScreen(
        itemCount: items.length,
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, i) => items[i],
      ),
    );
  }
}
