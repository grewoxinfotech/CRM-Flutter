import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/models/task/task/task_model.dart';
import 'package:crm_flutter/app/data/service/task_service.dart';
import 'package:crm_flutter/app/data/service/user/user_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final RxList<TaskModel> task = <TaskModel>[].obs;
  final UserService userService = Get.put(UserService());
  final TaskService taskService = TaskService();

  final formKey = GlobalKey<FormState>();
  final taskNameController = TextEditingController();
  final categoryController = TextEditingController();
  final projectController = TextEditingController();
  final leadController = TextEditingController();
  final fileController = TextEditingController();
  final descriptionController = TextEditingController();


  @override
  void dispose() {
    taskNameController.dispose();
    categoryController.dispose();
    projectController.dispose();
    leadController.dispose();
    fileController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<List> getTasks() async {
    final data = await taskService.getTasks("/${userService.user.value!.id}");
    print(userService.user.value!.id);
    task.assignAll(data.map((e) => TaskModel.fromJson(e)).toList());
    return data;
  }

  Future<void> addTask() async {
    final model = TaskModel(
      taskName: taskNameController.text,
        category : categoryController.text,
        project : projectController.text,
        lead : leadController.text,
        file : fileController.text,
        description : descriptionController.text,
    );

    final response = await taskService.createTask(model.toJson());

    if (response.statusCode == 201) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Success",
        message: getMessage(response),
        contentType: ContentType.success,
      );
      // Navigator.pop(context); // optional: wapas jao
    } else {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: getMessage(response),
        contentType: ContentType.failure,
      );
    }
  }

  Future<void> editTask(TaskModel model) async {
    final response = await taskService.updateTask(model.id!, model.toJson());

    if (response.statusCode == 200) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Updated",
        message: getMessage(response),
        contentType: ContentType.success,
      );
      await getTasks();
    } else {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: getMessage(response),
        contentType: ContentType.failure,
      );
    }
  }

  Future<void> deleteTask(String id) async {
    final response = await taskService.deleteTask(id);

    if (response.statusCode == 200 || response.statusCode == 204) {
      task.removeWhere((t) => t.id == id);
      CrmSnackBar.showAwesomeSnackbar(
        title: "Deleted",
        message: getMessage(response),
        contentType: ContentType.success,
      );
    } else {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: getMessage(response),
        contentType: ContentType.failure,
      );
    }
  }

  String getMessage(dynamic response) {
    try {
      final body = response.body;
      if (body is String) return body;
      if (body is Map<String, dynamic>) return body['message'] ?? 'No message';
    } catch (_) {}
    return "Something went wrong";
  }
}
