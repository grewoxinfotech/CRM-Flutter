import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/modules/task/task/controller/task_controller.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_add_screen.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_edit_screen.dart';
import 'package:crm_flutter/app/modules/task/task/widget/task_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    
    return Scaffold(
      appBar: AppBar(
        leading: const CrmBackButton(), 
        title: const Text("Tasks")
      ),
      floatingActionButton: CrmButton(
                title: "Add New Task",
        onTap: () async {
          final userData = await SecureStorage.getUserData();
          if (userData?.id != null) {
            await Get.to(() => TaskAddScreen(
              userId: userData!.id!,
            ));
            // Refresh data when returning from add screen
            taskController.refreshData();
          } else {
            Get.snackbar(
              'Error',
              'User data not found. Please login again.',
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
      ),
      body: FutureBuilder(
        future: taskController.refreshData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CrmLoadingCircle();
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(  
                width: 250,   
                  child: Text(
                  'Server Error : \n${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
          } else {
            return Obx(
              () {
                final tasks = taskController.task;
                if (tasks.isEmpty) {
                  return const Center(child: Text("No tasks available."));
                }
                
                return ViewScreen(
                  itemCount: tasks.length,
                  itemBuilder: (context, i) {
                    final data = tasks[i];
            return TaskCard(
              id: data.id,
              relatedId: data.relatedId,
              taskName: data.taskName,
              file: data.file,
              startDate: formatDate(data.startDate?.toString() ?? ""),
              dueDate: formatDate(data.dueDate?.toString() ?? ""),
              assignTo: data.assignTo,
              status: data.status,
              priority: data.priority,
              description: data.description,
              reminderDate: formatDate(data.reminderDate?.toString() ?? ""),
              clientId: data.clientId,
              taskReporter: data.taskReporter,
              createdBy: data.createdBy,
              updatedBy: data.updatedBy,
              onEdit: () async {
                final userData = await SecureStorage.getUserData();
                if (userData?.id != null) {
                  await Get.to(() => TaskEditScreen(
                    task: data,
                    userId: userData!.id!,
                  ));
                  // Refresh data when returning from edit screen
                  taskController.refreshData();
                } else {
                  Get.snackbar(
                    'Error',
                    'User data not found. Please login again.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              onDelete: () {
                if (data.id != null) {
                  taskController.deleteTask(data.id!);
                }
              },
            );
          },
        );
              },
            );
          }
        },
      ),
    );
  }
}
