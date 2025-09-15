// import 'dart:convert';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
// import 'package:crm_flutter/app/data/network/task/task/model/task_model.dart';
// import 'package:crm_flutter/app/data/network/task/task/service/task_service.dart';
// import 'package:crm_flutter/app/data/network/user/all_users/service/all_users_service.dart';
// import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../care/pagination/controller/pagination_controller.dart';
//
// class TaskController extends PaginatedController<TaskData> {
//   final RxList<TaskData> task = <TaskData>[].obs;
//   final TaskService _taskService = TaskService();
//   final AllUsersService _allUsersService = AllUsersService();
//   final RxBool isLoading = false.obs;
//
//   final taskNameController = TextEditingController();
//   final fileController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final startDateController = TextEditingController();
//   final dueDateController = TextEditingController();
//   final reminderDateController = TextEditingController();
//
//   final RxnString priority = RxnString();
//   final RxnString status = RxnString();
//   final RxList<String> assignTo = <String>[].obs;
//   final RxnString taskReporter = RxnString();
//   final RxList<Map<String, dynamic>> teamMembers = <Map<String, dynamic>>[].obs;
//
//   static const List<String> priorities = ['Low', 'Medium', 'High', 'Highest'];
//   static const List<String> statuses = [
//     'Not Started',
//     'In Progress',
//     'Completed',
//     'On Hold',
//     'Cancelled',
//   ];
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initializeData();
//   }
//
//   Future<void> _initializeData() async {
//     try {
//       final userData = await SecureStorage.getUserData();
//       final userId = userData?.id;
//       if (userId != null) {
//         await Future.wait([getTasks(userId), fetchUsers()]);
//       }
//     } catch (e) {
//       print('Error initializing data: $e');
//     }
//   }
//
//   Future<void> fetchUsers() async {
//     try {
//       final users = await _allUsersService.getUsers();
//       teamMembers.value =
//           users
//               .map((user) => {'id': user.id, 'username': user.username})
//               .toList();
//     } catch (e) {
//       print('Error in fetchUsers: $e');
//     }
//   }
//
//   String _getStorageValue(String? displayValue) {
//     return displayValue?.toLowerCase().replaceAll(' ', '_') ?? '';
//   }
//
//   String _getDisplayValue(String? storageValue) {
//     if (storageValue == null) return priorities[0];
//     return storageValue
//         .split('_')
//         .map(
//           (word) =>
//               word.isEmpty
//                   ? ''
//                   : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
//         )
//         .join(' ');
//   }
//
//   String? getUsernameFromId(String id) {
//     final user = teamMembers.firstWhereOrNull((member) => member['id'] == id);
//     return user?['username'];
//   }
//
//   String? _getIdFromUsername(String username) {
//     final user = teamMembers.firstWhereOrNull(
//       (member) => member['username'] == username,
//     );
//     return user?['id'];
//   }
//
//   void clearFormData() {
//     taskNameController.clear();
//     startDateController.clear();
//     dueDateController.clear();
//     reminderDateController.clear();
//     descriptionController.clear();
//     fileController.clear();
//     priority.value = priorities[0];
//     status.value = statuses[0];
//     assignTo.clear();
//     taskReporter.value = null;
//   }
//
//   void initializeTaskData(TaskData task) {
//     clearFormData();
//
//     taskNameController.text = task.taskName ?? '';
//
//     if (task.startDate != null) {
//       try {
//         final date = DateTime.parse(task.startDate!);
//         startDateController.text = DateFormat('dd-MM-yyyy').format(date);
//       } catch (e) {
//         startDateController.text = task.startDate!;
//       }
//     }
//
//     if (task.dueDate != null) {
//       try {
//         final date = DateTime.parse(task.dueDate!);
//         dueDateController.text = DateFormat('dd-MM-yyyy').format(date);
//       } catch (e) {
//         dueDateController.text = task.dueDate!;
//       }
//     }
//
//     if (task.reminderDate != null) {
//       try {
//         final date = DateTime.parse(task.reminderDate!);
//         reminderDateController.text = DateFormat('dd-MM-yyyy').format(date);
//       } catch (e) {
//         reminderDateController.text = task.reminderDate!;
//       }
//     }
//
//     descriptionController.text = task.description ?? '';
//     fileController.text = task.file ?? '';
//
//     priority.value = _getDisplayValue(task.priority);
//     status.value = _getDisplayValue(task.status);
//
//     if (task.assignTo?['assignedusers']?.isNotEmpty == true) {
//       final assigneeIds = task.assignTo!['assignedusers'] as List;
//       final assigneeUsernames =
//           assigneeIds
//               .map((id) => getUsernameFromId(id.toString()))
//               .where((name) => name != null)
//               .map((name) => name!)
//               .toList();
//       assignTo.assignAll(assigneeUsernames);
//     }
//
//     if (task.taskReporter != null) {
//       taskReporter.value = getUsernameFromId(task.taskReporter!);
//     }
//   }
//
//   Future<List<TaskData>> getTasks(String userId) async {
//     try {
//       isLoading.value = true;
//       final response = await _taskService.fetchTasks(userId);
//
//       if (response != null && response.success == 'true') {
//         final responseData = jsonDecode(response.body);
//         if (responseData['message']['data'] != null) {
//           final data = responseData['message']['data'];
//           if (data is List) {
//             final tasks = data.map((e) => TaskData.fromJson(e)).toList();
//             task.assignAll(tasks);
//             return tasks;
//           }
//         }
//       }
//       return [];
//     } catch (e) {
//       CrmSnackBar.showAwesomeSnackbar(
//         title: "Error",
//         message: "Failed to fetch tasks: $e",
//         contentType: ContentType.failure,
//       );
//       return [];
//     } finally {
//       isLoading.value = false;
//     }
//   }
//   @override
//   Future<List<TaskData>> fetchItems(int page) {
//     try {
//       final response = await _taskService.fetchTasks(,page: page);
//       print("Response: ${response!.toJson()}");
//       if (response != null && response.success == true) {
//         totalPages.value = response.message?.pagination?.totalPages ?? 1;
//         return response.message?.data ?? [];
//       } else {
//         errorMessage.value = "Failed to fetch revenues";
//         return [];
//       }
//     } catch (e) {
//       errorMessage.value = "Exception in fetchItems: $e";
//       return [];
//     }
//   }
//
//   Future<void> refreshData() async {
//     final userData = await SecureStorage.getUserData();
//     if (userData?.id != null) {
//       await getTasks(userData!.id!);
//     }
//   }
//
//   String? parseDDMMYYYYtoISO(String? dateStr) {
//     if (dateStr == null || dateStr.isEmpty) return null;
//     try {
//       final date = DateFormat('dd-MM-yyyy').parse(dateStr);
//       return date.toIso8601String();
//     } catch (_) {
//       return dateStr;
//     }
//   }
//
//   Future<void> addTask({required String userId}) async {
//     try {
//       final assigneeIds =
//           assignTo
//               .map((username) => _getIdFromUsername(username))
//               .where((id) => id != null)
//               .toList();
//       final reporterId = _getIdFromUsername(taskReporter.value ?? '');
//
//       final task = TaskData(
//         id: null,
//         relatedId: userId,
//         taskName: taskNameController.text,
//         file: fileController.text.isEmpty ? null : fileController.text,
//         startDate: parseDDMMYYYYtoISO(startDateController.text),
//         dueDate: parseDDMMYYYYtoISO(dueDateController.text),
//         assignTo: {'assignedusers': assigneeIds},
//         status: _getStorageValue(status.value),
//         priority: _getStorageValue(priority.value),
//         description: descriptionController.text,
//         reminderDate: parseDDMMYYYYtoISO(reminderDateController.text),
//         clientId: userId,
//         taskReporter: reporterId,
//         createdBy: userId,
//         updatedBy: null,
//       );
//
//       final response = await _taskService.createTask(task, userId);
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Get.back();
//         CrmSnackBar.showAwesomeSnackbar(
//           title: "Success",
//           message: "Task created successfully",
//           contentType: ContentType.success,
//         );
//         await refreshData();
//       } else {
//         CrmSnackBar.showAwesomeSnackbar(
//           title: "Error",
//           message: "Failed to create task",
//           contentType: ContentType.failure,
//         );
//       }
//     } catch (e) {
//       CrmSnackBar.showAwesomeSnackbar(
//         title: "Error",
//         message: "An error occurred while creating the task",
//         contentType: ContentType.failure,
//       );
//     }
//   }
//
//   Future<void> editTask(TaskData model) async {
//     try {
//       if (model.id == null) {
//         CrmSnackBar.showAwesomeSnackbar(
//           title: "Error",
//           message: "Task ID is missing",
//           contentType: ContentType.failure,
//         );
//         return;
//       }
//
//       final assigneeIds =
//           assignTo
//               .map((username) => _getIdFromUsername(username))
//               .where((id) => id != null)
//               .toList();
//       final reporterId = _getIdFromUsername(taskReporter.value ?? '');
//
//       final updatedTask = TaskData(
//         id: model.id,
//         relatedId: model.relatedId,
//         taskName: taskNameController.text,
//         file: fileController.text.isEmpty ? null : fileController.text,
//         startDate: parseDDMMYYYYtoISO(startDateController.text),
//         dueDate: parseDDMMYYYYtoISO(dueDateController.text),
//         assignTo: {'assignedusers': assigneeIds},
//         status: _getStorageValue(status.value),
//         priority: _getStorageValue(priority.value),
//         description: descriptionController.text,
//         reminderDate: parseDDMMYYYYtoISO(reminderDateController.text),
//         clientId: model.clientId,
//         taskReporter: reporterId,
//         createdBy: model.createdBy,
//         updatedBy: model.updatedBy,
//       );
//
//       final response = await _taskService.updateTask(
//         model.id!,
//         updatedTask.toJson(),
//       );
//
//       if (response.statusCode == 200) {
//         CrmSnackBar.showAwesomeSnackbar(
//           title: "Updated",
//           message: "Task updated successfully",
//           contentType: ContentType.success,
//         );
//         await refreshData();
//         Get.back();
//       } else {
//         CrmSnackBar.showAwesomeSnackbar(
//           title: "Error",
//           message: "Failed to edit task",
//           contentType: ContentType.failure,
//         );
//       }
//     } catch (e) {
//       CrmSnackBar.showAwesomeSnackbar(
//         title: "Error",
//         message: "Failed to edit task: $e",
//         contentType: ContentType.failure,
//       );
//     }
//   }
//
//   Future<void> deleteTask(String id) async {
//     try {
//       final response = await _taskService.deleteTask(id);
//
//       if (response.statusCode == 200 || response.statusCode == 204) {
//         task.removeWhere((t) => t.id == id);
//         CrmSnackBar.showAwesomeSnackbar(
//           title: "Deleted",
//           message: "Task deleted successfully",
//           contentType: ContentType.success,
//         );
//       } else {
//         CrmSnackBar.showAwesomeSnackbar(
//           title: "Error",
//           message: "Failed to delete task",
//           contentType: ContentType.failure,
//         );
//       }
//     } catch (e) {
//       CrmSnackBar.showAwesomeSnackbar(
//         title: "Error",
//         message: "Failed to delete task: $e",
//         contentType: ContentType.failure,
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     taskNameController.dispose();
//     fileController.dispose();
//     descriptionController.dispose();
//     startDateController.dispose();
//     dueDateController.dispose();
//     reminderDateController.dispose();
//     super.dispose();
//   }
//
//
// }

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

import '../../../../care/pagination/controller/pagination_controller.dart';

class TaskController extends PaginatedController<TaskData> {
  final TaskService _taskService = TaskService();
  final AllUsersService _allUsersService = AllUsersService();

  final RxnString priority = RxnString();
  final RxnString status = RxnString();
  final RxList<String> assignTo = <String>[].obs;
  final RxnString taskReporter = RxnString();
  final RxList<Map<String, dynamic>> teamMembers = <Map<String, dynamic>>[].obs;

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController fileController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController reminderDateController = TextEditingController();

  static const List<String> priorities = ['Low', 'Medium', 'High', 'Highest'];
  static const List<String> statuses = [
    'Not Started',
    'In Progress',
    'Completed',
    'On Hold',
    'Cancelled',
  ];

  var errorMessage = ''.obs;
  String? userId;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      final userData = await SecureStorage.getUserData();
      userId = userData?.id;
      if (userId != null) {
        await Future.wait([fetchUsers(), loadInitial()]);
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

  String _getStorageValue(String? displayValue) =>
      displayValue?.toLowerCase().replaceAll(' ', '_') ?? '';

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

  String? getUsernameFromId(String id) =>
      teamMembers.firstWhereOrNull((member) => member['id'] == id)?['username'];

  String? _getIdFromUsername(String username) =>
      teamMembers.firstWhereOrNull(
        (member) => member['username'] == username,
      )?['id'];

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

  void initializeTaskData(TaskData task) {
    clearFormData();
    taskNameController.text = task.taskName ?? '';
    startDateController.text = _formatDate(task.startDate);
    dueDateController.text = _formatDate(task.dueDate);
    reminderDateController.text = _formatDate(task.reminderDate);
    descriptionController.text = task.description ?? '';
    fileController.text = task.file ?? '';
    priority.value = _getDisplayValue(task.priority);
    status.value = _getDisplayValue(task.status);

    if (task.assignTo?['assignedusers']?.isNotEmpty == true) {
      final assigneeIds = task.assignTo!['assignedusers'] as List;
      final assigneeUsernames =
          assigneeIds
              .map((id) => getUsernameFromId(id.toString()))
              .whereType<String>()
              .toList();
      assignTo.assignAll(assigneeUsernames);
    }

    if (task.taskReporter != null) {
      taskReporter.value = getUsernameFromId(task.taskReporter!);
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Future<List<TaskData>> fetchItems(int page) async {
    if (userId == null) return [];
    try {
      final response = await _taskService.fetchTasks(userId!, page: page);
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = 'Failed to fetch tasks';
        return [];
      }
    } catch (e) {
      errorMessage.value = 'Exception in fetchItems: $e';
      return [];
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

  // --- CRUD METHODS ---
  Future<bool> addTask() async {
    if (userId == null) return false;
    try {
      final assigneeIds =
          assignTo
              .map((username) => _getIdFromUsername(username))
              .whereType<String>()
              .toList();
      final reporterId = _getIdFromUsername(taskReporter.value ?? '');

      final task = TaskData(
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
      );

      final response = await _taskService.createTask(task, userId!);

      if (response) {
        items.insert(0, task); // Add to top of list
        items.refresh();
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Task created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to create task",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Error creating task: $e",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  Future<bool> editTask(TaskData model) async {
    if (model.id == null) return false;
    try {
      final assigneeIds =
          assignTo
              .map((username) => _getIdFromUsername(username))
              .whereType<String>()
              .toList();
      final reporterId = _getIdFromUsername(taskReporter.value ?? '');

      final updatedTask = TaskData(
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
        updatedBy: userId,
      );

      final response = await _taskService.updateTask(
        model.id!,
        updatedTask.toJson(),
      );

      if (response) {
        final index = items.indexWhere((t) => t.id == model.id);
        if (index != -1) {
          items[index] = updatedTask;
          items.refresh();
        }
        CrmSnackBar.showAwesomeSnackbar(
          title: "Updated",
          message: "Task updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to update task",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Error updating task: $e",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  Future<bool> deleteTask(String id) async {
    try {
      final response = await _taskService.deleteTask(id);
      if (response) {
        items.removeWhere((t) => t.id == id);
        items.refresh();
        CrmSnackBar.showAwesomeSnackbar(
          title: "Deleted",
          message: "Task deleted successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to delete task",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Error deleting task: $e",
        contentType: ContentType.failure,
      );
      return false;
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
