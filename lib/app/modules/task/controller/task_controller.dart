import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/models/task_model.dart';
import 'package:crm_flutter/app/data/service/task_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  RxBool isLoading = true.obs;
  final RxList<TaskModel> tasksList = <TaskModel>[].obs;
  final TaskService taskService = TaskService();
  final context = Get.context!;

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

  Future<void> getTask(String id) async {
    isLoading(true);
    try {
      final data = await taskService.fetchTasks(id);
      tasksList.assignAll(data);
      print("task data fetched successfully : ${data.length} data found!");
    } catch (e) {
      print("Error : $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to load Tasks",
        contentType: ContentType.warning,
        color: Get.theme.colorScheme.error,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> editTask(String id) async {}

  Future<bool> deleteTask(String id) async {
    isLoading(true);
    try {
      bool success = await taskService.deleteTask(id);
      if (success) {
        tasksList.removeWhere((task) => task.id == id);
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
    } finally {
      isLoading(false);
    }
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

