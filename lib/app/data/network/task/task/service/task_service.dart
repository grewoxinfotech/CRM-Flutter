// import 'dart:convert';
// import 'package:crm_flutter/app/care/constants/url_res.dart';
// import 'package:http/http.dart' as http;
// import 'package:crm_flutter/app/data/network/task/task/model/task_model.dart';
// import 'package:get/get.dart';
//
// class TaskService {
//   final String url = UrlRes.task;
//
//   static Future<Map<String, String>> headers() async {
//     return await UrlRes.getHeaders();
//   }
//
//   /// 1. Get all tasks by ID
//   Future<Response<dynamic>> getTasks(String userId) async {
//     try {
//       final cleanUserId = userId.startsWith('/') ? userId.substring(1) : userId;
//       final response = await http.get(
//         Uri.parse("$url/$cleanUserId"),
//         headers: await headers(),
//       );
//       return Response(
//         statusCode: response.statusCode,
//         body: response.body,
//         headers: response.headers,
//       );
//     } catch (e) {
//       return Response(
//         statusCode: 500,
//         body: jsonEncode({'message': 'Failed to fetch tasks: $e'}),
//       );
//     }
//   }
//
//   /// 2. Get single task by ID
//   Future<Response<dynamic>> getTaskById(String id) async {
//     try {
//       final response = await http.get(
//         Uri.parse("$url/$id"),
//         headers: await headers(),
//       );
//
//       return Response(
//         statusCode: response.statusCode,
//         body: response.body,
//         headers: response.headers,
//       );
//     } catch (e) {
//       return Response(
//         statusCode: 500,
//         body: jsonEncode({'message': 'Failed to fetch task: $e'}),
//       );
//     }
//   }
//
//   /// 3. Create Task
//   Future<Response<dynamic>> createTask(TaskData task, String userId) async {
//     try {
//       final data = {
//         'taskName': task.taskName,
//         'section': 'task',
//         'task_reporter': userId,
//         'startDate': task.startDate,
//         'dueDate': task.dueDate,
//         'reminder_date': task.reminderDate,
//         'priority': task.priority,
//         'status': task.status,
//         'description': task.description,
//         'assignTo': task.assignTo,
//         'file': task.file,
//       };
//
//       final response = await http.post(
//         Uri.parse("$url/$userId"),
//         headers: await headers(),
//         body: jsonEncode(data),
//       );
//
//       return Response(
//         statusCode: response.statusCode,
//         body: response.body,
//         headers: response.headers,
//       );
//     } catch (e) {
//       return Response(
//         statusCode: 500,
//         body: jsonEncode({'message': 'Failed to create task: $e'}),
//       );
//     }
//   }
//
//   /// 4. Update Task by ID
//   /// 4. Update Task by ID
//   Future<Response<dynamic>> updateTask(
//     String id,
//     Map<String, dynamic> data,
//   ) async {
//     try {
//       final cleanData = <String, dynamic>{};
//       data.forEach((key, value) {
//         if (value != null && value != '') {
//           cleanData[key] = value;
//         }
//       });
//
//       final response = await http.put(
//         Uri.parse("$url/$id"),
//         headers: await headers(),
//         body: jsonEncode(cleanData),
//       );
//
//       return Response(
//         statusCode: response.statusCode,
//         body: response.body,
//         headers: response.headers,
//       );
//     } catch (e) {
//       return Response(
//         statusCode: 500,
//         body: jsonEncode({'message': 'Failed to update task: $e'}),
//       );
//     }
//   }
//
//   /// 5. Delete Task by ID
//   Future<Response<dynamic>> deleteTask(String id) async {
//     try {
//       final response = await http.delete(
//         Uri.parse("$url/$id"),
//         headers: await headers(),
//       );
//
//       return Response(
//         statusCode: response.statusCode,
//         body: response.body,
//         headers: response.headers,
//       );
//     } catch (e) {
//       return Response(
//         statusCode: 500,
//         body: jsonEncode({'message': 'Failed to delete task: $e'}),
//       );
//     }
//   }
// }

import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../model/task_model.dart';

class TaskService {
  final String baseUrl = UrlRes.task; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch tasks with optional pagination & search
  Future<TaskModel?> fetchTasks(
    String userId, {
    int page = 1,
    int pageSize = 10,
    String search = '',
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$userId').replace(
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          'search': search,
        },
      );

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Tasks: $data");
        return TaskModel.fromJson(data);
      } else {
        print("Failed to load tasks: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchTasks: $e");
    }
    return null;
  }

  /// Get single task by ID
  Future<TaskData?> getTaskById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return TaskData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get task by ID exception: $e");
    }
    return null;
  }

  /// Create Task
  Future<bool> createTask(TaskData task, String userId) async {
    try {
      final payload = {
        'taskName': task.taskName,
        'section': 'task',
        'task_reporter': userId,
        'startDate': task.startDate,
        'dueDate': task.dueDate,
        'reminder_date': task.reminderDate,
        'priority': task.priority,
        'status': task.status,
        'description': task.description,
        'assignTo': task.assignTo,
        'file': task.file,
      };

      final response = await http.post(
        Uri.parse("$baseUrl/$userId"),
        headers: await headers(),
        body: jsonEncode(payload),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Task created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to create task",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Create task exception: $e");
      return false;
    }
  }

  /// Update Task
  Future<bool> updateTask(String id, Map<String, dynamic> data) async {
    try {
      final cleanData = <String, dynamic>{};
      data.forEach((key, value) {
        if (value != null && value != '') {
          cleanData[key] = value;
        }
      });

      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(cleanData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Task updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update task",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update task exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating the task",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete Task
  Future<bool> deleteTask(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete task exception: $e");
      return false;
    }
  }
}
