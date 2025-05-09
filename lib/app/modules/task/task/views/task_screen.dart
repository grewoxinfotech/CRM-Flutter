import 'package:crm_flutter/app/modules/task/task/controller/task_controller.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_add_screen.dart';
import 'package:crm_flutter/app/modules/task/task/widget/task_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});


  @override
  Widget build(BuildContext context) {
    Get.lazyPut<TaskController>(()=>TaskController());
    final TaskController taskController = Get.find();
    return Scaffold(
      appBar: AppBar(leading: CrmBackButton(), title: const Text("Tasks")),
      floatingActionButton: CrmButton(
        title: "Add Task",
        onTap: () => Get.to(TaskAddScreen()),
      ),
      body: FutureBuilder(
        future: taskController.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CrmLoadingCircle();
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                width: 250,
                child: Text(
                  'Server Error : \n${snapshot.error}',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final tasks = taskController.task;
            if (tasks.isEmpty) {
              return const Center(child: Text("No tasks available."));
            } else {
              return Obx(
                () => ViewScreen(
                  itemCount: tasks.length,
                  itemBuilder: (context, i) {
                    final data = tasks[i];
                    return TaskCard(
                      id: data.id ?? "N/A",
                      relatedId: data.relatedId ?? "N/A",
                      taskName: data.taskName ?? "N/A",
                      category: data.category ?? "N/A",
                      project: data.project ?? "N/A",
                      lead: data.lead ?? "N/A",
                      file: data.file ?? "N/A",
                      startDate: formatDate(data.startDate.toString()),
                      dueDate: formatDate(data.dueDate.toString()),
                      status: data.status ?? "N/A",
                      priority: data.priority ?? "N/A",
                      description: data.description ?? "N/A",
                      reminderDate: formatDate(data.reminderDate.toString()),
                      clientId: data.clientId ?? "N/A",
                      taskReporter: data.taskReporter ?? "N/A",
                      createdBy: data.createdBy ?? "N/A",
                      updatedBy: data.updatedBy ?? "N/A",
                      onDelete: () {
                        taskController.deleteTask(data.id.toString());
                      },
                    );
                  },
                ),
              );
            }
          } else {
            return const Center(child: Text("Something went wrong."));
          }
        },
      ),
    );
  }
}
