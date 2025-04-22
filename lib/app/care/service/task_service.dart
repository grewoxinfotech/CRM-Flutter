import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

class TaskService {
  final String url = UrlRes.task;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// 1. Get all tasks by ID
  Future<List> getTasks(String id) async {
    final response = await http.get(
      Uri.parse("$url/$id"),
      headers: await headers(),
    );
    final data = jsonDecode(response.body);
    return (response.statusCode == 200) ? data['data'] ?? [] : [];
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
    return await http.delete(
      Uri.parse("$url/$id"),
      headers: await headers(),
    );
  }
}
