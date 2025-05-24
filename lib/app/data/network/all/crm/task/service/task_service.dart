import 'dart:convert';

import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/all/crm/task/model/task_model.dart';
import 'package:http/http.dart' as http;

class TaskService {
  final String url = UrlRes.tasks;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// 1. Get all tasks by ID
  Future<List<TaskModel>> getTasks(String id) async {
    final response = await http.get(
      Uri.parse("$url/$id"),
      headers: await headers(),
    );
    final jsonData = jsonDecode(response.body);
    final List<dynamic> data = jsonData['data'];
    if (response.statusCode == 200 && jsonData["success"] == true) {
      print("Task Service (data) : ${jsonData['data']}");
      return data.map((e) => TaskModel.fromJson(e)).toList();
    } else {
      print("Task Service (error) : ${jsonData['message']}");
      print("Task Service (status code) : ${response.statusCode}");
      throw Exception('Failed to load Task data: ${response.statusCode}');
    }
  }

  /// 2. Get single task by ID
  Future<Map<String, dynamic>?> getTaskById(String id) async {
    final response = await http.get(
      Uri.parse("$url/$id"),
      headers: await headers(),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'];
    } else {
      return null;
    }
  }

  /// 3. Create Task
  Future<http.Response> createTask(Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse(url),
      headers: await headers(),
      body: jsonEncode(data),
    );
  }

  /// 4. Update Task by ID
  Future<http.Response> updateTask(String id, Map<String, dynamic> data) async {
    return await http.put(
      Uri.parse("$url/$id"),
      headers: await headers(),
      body: jsonEncode(data),
    );
  }

  /// 5. Delete Task by ID
  Future<http.Response> deleteTask(String id) async {
    return await http.delete(Uri.parse("$url/$id"), headers: await headers());
  }
}
