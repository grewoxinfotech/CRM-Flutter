import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/task/task/model/task_model.dart';
import 'package:crm_flutter/app/data/network/task/task/service/task_service.dart';
import 'package:crm_flutter/app/data/network/user/all_users/service/all_users_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskController extends GetxController {
  final RxList<TaskModel> task = <TaskModel>[].obs;
  final TaskService _taskService = TaskService();
  final AllUsersService _allUsersService = AllUsersService();
  final RxBool isLoading = false.obs;

  final taskNameController = TextEditingController();
  final fileController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final dueDateController = TextEditingController();
  final reminderDateController = TextEditingController();

  final RxnString priority = RxnString();
  final RxnString status = RxnString();
  final RxList<String> assignTo = <String>[].obs;
  final RxnString taskReporter = RxnString();
  final RxList<Map<String, dynamic>> teamMembers = <Map<String, dynamic>>[].obs;

  static const List<String> priorities = ['Low', 'Medium', 'High', 'Highest'];
  static const List<String> statuses = [
    'Not Started',
    'In Progress',
    'Completed',
    'On Hold',
    'Cancelled',
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      final userData = await SecureStorage.getUserData();
      final userId = userData?.id;
      if (userId != null) {
        await Future.wait([getTasks(userId), fetchUsers()]);
      }
    } catch (e) {
      print('Error initializing data: $e');
    }
  }

  Future<void> fetchUsers() async {
    try {
      final users = await _allUsersService.getUsers();
      teamMembers.value =
          users
              .map((user) => {'id': user.id, 'username': user.username})
              .toList();
    } catch (e) {
      print('Error in fetchUsers: $e');
    }
  }

  String _getStorageValue(String? displayValue) {
    return displayValue?.toLowerCase().replaceAll(' ', '_') ?? '';
  }

  String _getDisplayValue(String? storageValue) {
    if (storageValue == null) return priorities[0];
    return storageValue
        .split('_')
        .map(
          (word) =>
              word.isEmpty
                  ? ''
                  : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  String? getUsernameFromId(String id) {
    final user = teamMembers.firstWhereOrNull((member) => member['id'] == id);
    return user?['username'];
  }

  String? _getIdFromUsername(String username) {
    final user = teamMembers.firstWhereOrNull(
      (member) => member['username'] == username,
    );
    return user?['id'];
  }

  void clearFormData() {
    taskNameController.clear();
    startDateController.clear();
    dueDateController.clear();
    reminderDateController.clear();
    descriptionController.clear();
    fileController.clear();
    priority.value = priorities[0];
    status.value = statuses[0];
    assignTo.clear();
    taskReporter.value = null;
  }

  void initializeTaskData(TaskModel task) {
    clearFormData();

    taskNameController.text = task.taskName ?? '';

    if (task.startDate != null) {
      try {
        final date = DateTime.parse(task.startDate!);
        startDateController.text = DateFormat('dd-MM-yyyy').format(date);
      } catch (e) {
        startDateController.text = task.startDate!;
      }
    }

    if (task.dueDate != null) {
      try {
        final date = DateTime.parse(task.dueDate!);
        dueDateController.text = DateFormat('dd-MM-yyyy').format(date);
      } catch (e) {
        dueDateController.text = task.dueDate!;
      }
    }

    if (task.reminderDate != null) {
      try {
        final date = DateTime.parse(task.reminderDate!);
        reminderDateController.text = DateFormat('dd-MM-yyyy').format(date);
      } catch (e) {
        reminderDateController.text = task.reminderDate!;
      }
    }

    descriptionController.text = task.description ?? '';
    fileController.text = task.file ?? '';

    priority.value = _getDisplayValue(task.priority);
    status.value = _getDisplayValue(task.status);

    if (task.assignTo?['assignedusers']?.isNotEmpty == true) {
      final assigneeIds = task.assignTo!['assignedusers'] as List;
      final assigneeUsernames =
          assigneeIds
              .map((id) => getUsernameFromId(id.toString()))
              .where((name) => name != null)
              .map((name) => name!)
              .toList();
      assignTo.assignAll(assigneeUsernames);
    }

    if (task.taskReporter != null) {
      taskReporter.value = getUsernameFromId(task.taskReporter!);
    }
  }

  Future<List<TaskModel>> getTasks(String userId) async {
    try {
      isLoading.value = true;
      final response = await _taskService.getTasks(userId);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['message']['data'] != null) {
          final data = responseData['message']['data'];
          if (data is List) {
            final tasks = data.map((e) => TaskModel.fromJson(e)).toList();
            task.assignAll(tasks);
            return tasks;
          }
        }
      }
      return [];
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to fetch tasks: $e",
        contentType: ContentType.failure,
      );
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    final userData = await SecureStorage.getUserData();
    if (userData?.id != null) {
      await getTasks(userData!.id!);
    }
  }

  String? parseDDMMYYYYtoISO(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      final date = DateFormat('dd-MM-yyyy').parse(dateStr);
      return date.toIso8601String();
    } catch (_) {
      return dateStr;
    }
  }

  Future<void> addTask({required String userId}) async {
    try {
      final assigneeIds =
          assignTo
              .map((username) => _getIdFromUsername(username))
              .where((id) => id != null)
              .toList();
      final reporterId = _getIdFromUsername(taskReporter.value ?? '');

      final task = TaskModel(
        id: null,
        relatedId: userId,
        taskName: taskNameController.text,
        file: fileController.text.isEmpty ? null : fileController.text,
        startDate: parseDDMMYYYYtoISO(startDateController.text),
        dueDate: parseDDMMYYYYtoISO(dueDateController.text),
        assignTo: {'assignedusers': assigneeIds},
        status: _getStorageValue(status.value),
        priority: _getStorageValue(priority.value),
        description: descriptionController.text,
        reminderDate: parseDDMMYYYYtoISO(reminderDateController.text),
        clientId: userId,
        taskReporter: reporterId,
        createdBy: userId,
        updatedBy: null,
      );

      final response = await _taskService.createTask(task, userId);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.back();
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Task created successfully",
          contentType: ContentType.success,
        );
        await refreshData();
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to create task",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "An error occurred while creating the task",
        contentType: ContentType.failure,
      );
    }
  }

  Future<void> editTask(TaskModel model) async {
    try {
      if (model.id == null) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Task ID is missing",
          contentType: ContentType.failure,
        );
        return;
      }

      final assigneeIds =
          assignTo
              .map((username) => _getIdFromUsername(username))
              .where((id) => id != null)
              .toList();
      final reporterId = _getIdFromUsername(taskReporter.value ?? '');

      final updatedTask = TaskModel(
        id: model.id,
        relatedId: model.relatedId,
        taskName: taskNameController.text,
        file: fileController.text.isEmpty ? null : fileController.text,
        startDate: parseDDMMYYYYtoISO(startDateController.text),
        dueDate: parseDDMMYYYYtoISO(dueDateController.text),
        assignTo: {'assignedusers': assigneeIds},
        status: _getStorageValue(status.value),
        priority: _getStorageValue(priority.value),
        description: descriptionController.text,
        reminderDate: parseDDMMYYYYtoISO(reminderDateController.text),
        clientId: model.clientId,
        taskReporter: reporterId,
        createdBy: model.createdBy,
        updatedBy: model.updatedBy,
      );

      final response = await _taskService.updateTask(
        model.id!,
        updatedTask.toJson(),
      );

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Updated",
          message: "Task updated successfully",
          contentType: ContentType.success,
        );
        await refreshData();
        Get.back();
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to edit task",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to edit task: $e",
        contentType: ContentType.failure,
      );
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final response = await _taskService.deleteTask(id);

      if (response.statusCode == 200 || response.statusCode == 204) {
        task.removeWhere((t) => t.id == id);
        CrmSnackBar.showAwesomeSnackbar(
          title: "Deleted",
          message: "Task deleted successfully",
          contentType: ContentType.success,
        );
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to delete task",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to delete task: $e",
        contentType: ContentType.failure,
      );
    }
  }

  @override
  void dispose() {
    taskNameController.dispose();
    fileController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    dueDateController.dispose();
    reminderDateController.dispose();
    super.dispose();
  }
}
