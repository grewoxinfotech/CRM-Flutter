import 'package:crm_flutter/app/modules/task/controller/task_controller.dart';
import 'package:crm_flutter/app/modules/task/views/task_add_screen.dart';
import 'package:crm_flutter/app/modules/task/widget/task_card.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.put(TaskController());
    taskController.getTask("/EFdfN60unjUbWVIrrTptpeE");
    return Scaffold(

      appBar: AppBar(leading: CrmBackButton(),title: Text("Tasks",style: TextStyle(color: Colors.white),),backgroundColor: Get.theme.colorScheme.primary, centerTitle: false),
      floatingActionButton: CrmButton(
        title: "Add Task",
        onTap: () => Get.to(TaskAddScreen()),
      ),
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(15),
          itemCount: taskController.tasksList.length,
          separatorBuilder: (context, i) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            var task = taskController.tasksList[i];
            return TaskCard(
              id: task.id ?? "N/A",
              relatedId: task.relatedId ?? "N/A",
              taskName: task.taskName ?? "N/A",
              category: task.category ?? "N/A",
              project: task.project ?? "N/A",
              lead: task.lead ?? "N/A",
              file: task.file ?? "N/A",
              startDate: task.startDate ?? DateTime.now(),
              dueDate: task.dueDate ?? DateTime.now().add(Duration(days: 2)),
              assignTo: {"name": task.assignTo ?? "N/A"},
              status: task.status ?? task.status ?? "no loda",
              priority: task.priority ?? "N/A",
              description: task.description ?? "N/A",
              reminderDate: task.reminderDate ?? DateTime.now(),
              clientId: task.clientId ?? "N/A",
              taskReporter: task.taskReporter ?? "N/A",
              createdBy: task.createdBy ?? "N/A",
              updatedBy: task.updatedBy ?? "N/A",
              onTap: () {},
              onEdit: () {},
              onDelete: () {},
            );
          },
        ),
      ),
    );
  }
}
