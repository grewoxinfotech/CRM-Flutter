import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/crm/follow_Ups/follow_ups_task/model/followup_task_model.dart';
import 'package:http/http.dart' as http;

class FollowUpTaskService {
  // Create a new follow-up task
  Future<FollowUpTaskModel> createFollowUpTask(FollowUpTaskModel task) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.post(
        Uri.parse('${UrlRes.followupTasks}/${task.relatedId}'),
        headers: headers,
        body: jsonEncode(task.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        return FollowUpTaskModel.fromJson(data);
      } else {
        throw Exception('Failed to create follow-up task: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating follow-up task: $e');
    }
  }

  // Get all follow-up tasks
  Future<List<FollowUpTaskModel>> getAllFollowUpTasks(String dealId) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.get(
        Uri.parse('${UrlRes.followupTasks}/$dealId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((json) => FollowUpTaskModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch follow-up tasks: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching follow-up tasks: $e');
    }
  }

  // Get a specific follow-up task by ID
  Future<FollowUpTaskModel> getFollowUpTaskById(String taskId, String dealId) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.get(
        Uri.parse('${UrlRes.followupTasks}/$dealId/$taskId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        return FollowUpTaskModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch follow-up task: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching follow-up task: $e');
    }
  }

  // Update a follow-up task
  Future<FollowUpTaskModel> updateFollowUpTask(
      String taskId, FollowUpTaskModel task) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.put(
        Uri.parse('${UrlRes.followupTasks}/$taskId'),
        headers: headers,
        body: jsonEncode(task.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        return FollowUpTaskModel.fromJson(data);
      } else {
        throw Exception('Failed to update follow-up task: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error updating follow-up task: $e');
    }
  }

  // Delete a follow-up task
  Future<bool> deleteFollowUpTask(String taskId, String dealId) async {
    try {
      final headers = await UrlRes.getHeaders();
      final response = await http.delete(
        Uri.parse('${UrlRes.followupTasks}/$dealId/$taskId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to delete follow-up task: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error deleting follow-up task: $e');
    }
  }
}
