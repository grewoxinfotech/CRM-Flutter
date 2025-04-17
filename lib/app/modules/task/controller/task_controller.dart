import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/models/task_model.dart';
import 'package:crm_flutter/app/data/service/task_service.dart';
import 'package:crm_flutter/app/data/service/user/user_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final RxList<TaskModel> task = <TaskModel>[].obs;
  final UserService userService = Get.put(UserService());
  final TaskService taskService = TaskService();

  final TextEditingController id = TextEditingController();
  final TextEditingController relatedId = TextEditingController();
  final TextEditingController taskName = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController project = TextEditingController();
  final TextEditingController lead = TextEditingController();
  final TextEditingController file = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController dueDate = TextEditingController();
  final TextEditingController assignTo = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController priority = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController reminderDate = TextEditingController();
  final TextEditingController clientId = TextEditingController();
  final TextEditingController taskReporter = TextEditingController();
  final TextEditingController createdBy = TextEditingController();
  final TextEditingController updatedBy = TextEditingController();

  Future<void> addTask() async {}

  Future<List> getTasks() async {
    final data = await taskService.getTasks("/${userService.user.value!.id}");
    task.assignAll(data.map((e) => TaskModel.fromJson(e)).toList());
    return data;
  }

  Future<void> editTask(String id) async {}

  Future<bool> deleteTask(String id) async {
    try {
      bool success = await taskService.deleteTask(id);
      if (success) {
        task.removeWhere((task) => task.id == id);
        Get.back();
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Task deleted successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to delete Task!",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Something went wrong",
        contentType: ContentType.failure,
      );
      return false;
    } finally {}
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    id.dispose();
    relatedId.dispose();
    taskName.dispose();
    category.dispose();
    project.dispose();
    lead.dispose();
    file.dispose();
    startDate.dispose();
    dueDate.dispose();
    assignTo.dispose();
    status.dispose();
    priority.dispose();
    description.dispose();
    reminderDate.dispose();
    clientId.dispose();
    taskReporter.dispose();
    createdBy.dispose();
    updatedBy.dispose();
  }
}
