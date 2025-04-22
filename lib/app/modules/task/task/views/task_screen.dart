import 'package:crm_flutter/app/modules/task/task/controller/task_controller.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_add_screen.dart';
import 'package:crm_flutter/app/modules/task/task/widget/task_card.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskController = Get.put(TaskController());

    return Scaffold(
      appBar: AppBar(
        leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
        title: const Text("Tasks"),
        centerTitle: false,
      ),
      floatingActionButton: CrmButton(
        title: "Add Task",
        onTap: () => Get.to(() => TaskAddScreen()),
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
              return ListView.separated(
                itemCount: tasks.length,
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: 80,
                ),
                separatorBuilder: (context, i) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final data = tasks[i];
                  String formatDate(String? dateString) {
                    try {
                      final date = DateTime.parse(dateString ?? '');
                      return DateFormat('dd MM yyyy').format(date);
                    } catch (e) {
                      return DateFormat('dd MM yyyy').format(DateTime.now());
                    }
                  }

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
