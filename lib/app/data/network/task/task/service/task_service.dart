import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/data/network/task/task/model/task_model.dart';
import 'package:get/get.dart';

class TaskService {
  final String url = UrlRes.task;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// 1. Get all tasks by ID
  Future<Response<dynamic>> getTasks(String userId) async {
    try {
      final cleanUserId = userId.startsWith('/') ? userId.substring(1) : userId;
      final response = await http.get(
        Uri.parse("$url/$cleanUserId"),
        headers: await headers(),
      );
      
      return Response(
        statusCode: response.statusCode,
        body: response.body,
        headers: response.headers,
      );
    } catch (e) {
      return Response(
        statusCode: 500,
        body: jsonEncode({'message': 'Failed to fetch tasks: $e'}),
      );
    }
  }

  /// 2. Get single task by ID
  Future<Response<dynamic>> getTaskById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$url/$id"),
        headers: await headers(),
      );
      
      return Response(
        statusCode: response.statusCode,
        body: response.body,
        headers: response.headers,
      );
    } catch (e) {
      return Response(
        statusCode: 500,
        body: jsonEncode({'message': 'Failed to fetch task: $e'}),
      );
    }
  }

  /// 3. Create Task
  Future<Response<dynamic>> createTask(TaskModel task, String userId) async {
    try {
      final data = {
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
        Uri.parse("$url/$userId"),
        headers: await headers(),
        body: jsonEncode(data),
      );
      
      return Response(
        statusCode: response.statusCode,
        body: response.body,
        headers: response.headers,
      );
    } catch (e) {
      return Response(
        statusCode: 500,
        body: jsonEncode({'message': 'Failed to create task: $e'}),
      );
    }
  }

  /// 4. Update Task by ID
  /// 4. Update Task by ID
  Future<Response<dynamic>> updateTask(String id, Map<String, dynamic> data) async {
    try {
      final cleanData = <String, dynamic>{};
      data.forEach((key, value) {
        if (value != null && value != '') {
          cleanData[key] = value;
        }
      });
      
      final response = await http.put(
        Uri.parse("$url/$id"),
        headers: await headers(),
        body: jsonEncode(cleanData),
      );
      
      return Response(
        statusCode: response.statusCode,
        body: response.body,
        headers: response.headers,
      );
    } catch (e) {
      return Response(
        statusCode: 500,
        body: jsonEncode({'message': 'Failed to update task: $e'}),
      );
    }
  }
  /// 5. Delete Task by ID
  Future<Response<dynamic>> deleteTask(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$url/$id"),
        headers: await headers(),
      );
      
      return Response(
        statusCode: response.statusCode,
        body: response.body,
        headers: response.headers,
      );
    } catch (e) {
      return Response(
        statusCode: 500,
        body: jsonEncode({'message': 'Failed to delete task: $e'}),
      );
    }
  }
}
