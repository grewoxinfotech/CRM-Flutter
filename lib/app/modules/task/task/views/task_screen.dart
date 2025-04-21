import 'package:crm_flutter/app/modules/task/task/controller/task_controller.dart';
import 'package:crm_flutter/app/modules/task/task/views/task_add_screen.dart';
import 'package:crm_flutter/app/modules/task/task/widget/task_card.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.put(TaskController());
    return Scaffold(
      appBar: AppBar(
        leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
        title: Text("Tasks"),
        centerTitle: false,
      ),
      floatingActionButton: CrmButton(
        title: "Add Task",
        onTap: () => Get.to(TaskAddScreen()),
      ),
      body: FutureBuilder(
        future: taskController.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(child: Text("No task"));
            } else {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: 80,
                ),
                separatorBuilder: (context, i) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final data = taskController.task[i];
                  return TaskCard(
                    id:
                        (data.id.toString().isEmpty)
                            ? "N/A"
                            : data.id.toString(),
                    relatedId:
                        (data.relatedId.toString().isEmpty)
                            ? "N/A"
                            : data.relatedId.toString(),
                    taskName:
                        (data.taskName.toString().isEmpty)
                            ? "N/A"
                            : data.taskName.toString(),
                    category:
                        (data.category.toString().isEmpty)
                            ? "N/A"
                            : data.category.toString(),
                    project:
                        (data.project.toString().isEmpty)
                            ? "N/A"
                            : data.project.toString(),
                    lead:
                        (data.lead.toString().isEmpty)
                            ? "N/A"
                            : data.lead.toString(),
                    file:
                        (data.file.toString().isEmpty)
                            ? "N/A"
                            : data.file.toString(),
                    startDate:
                        (data.startDate.toString().isEmpty)
                            ? "N/A"
                            : data.startDate.toString(),
                    dueDate:
                        (data.dueDate.toString().isEmpty)
                            ? "N/A"
                            : data.dueDate.toString(),
                    assignTo:
                        (data.assignTo.toString().isEmpty)
                            ? "N/A"
                            : data.assignTo.toString(),
                    status:
                        (data.status.toString().isEmpty)
                            ? "N/A"
                            : data.status.toString(),
                    priority:
                        (data.priority.toString().isEmpty)
                            ? "N/A"
                            : data.priority.toString(),
                    description:
                        (data.description.toString().isEmpty)
                            ? "N/A"
                            : data.description.toString(),
                    reminderDate:
                        (data.reminderDate.toString().isEmpty)
                            ? "N/A"
                            : data.reminderDate.toString(),
                    clientId:
                        (data.clientId.toString().isEmpty)
                            ? "N/A"
                            : data.clientId.toString(),
                    taskReporter:
                        (data.taskReporter.toString().isEmpty)
                            ? "N/A"
                            : data.taskReporter.toString(),
                    createdBy:
                        (data.createdBy.toString().isEmpty)
                            ? "N/A"
                            : data.createdBy.toString(),
                    updatedBy:
                        (data.updatedBy.toString().isEmpty)
                            ? "N/A"
                            : data.updatedBy.toString(),
                    onTap: () {},
                    onEdit: () {},
                    onDelete: () {
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert),
                        onSelected: (value) {
                          // Handle your action here
                          if (value == 'edit') {
                            // Navigate or show dialog
                          } else if (value == 'delete') {
                            // Delete something
                          }
                        },
                        itemBuilder:
                            (BuildContext context) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                      );
                    },
                  );
                },
              );
            }
          } else {
            return CrmLoadingCircle();
          }
        },
      ),
    );
  }
}
