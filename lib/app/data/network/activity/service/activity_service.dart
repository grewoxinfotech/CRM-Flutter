import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';

class ActivityService {
  final String url = UrlRes.activities;

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Get activities by related ID (e.g., lead ID)
  Future<Map<String, dynamic>> getActivities(String relatedId) async {
    final response = await http.get(
      Uri.parse("$url/$relatedId"),
      headers: await headers(),
    );
    return json.decode(response.body);
  }

  /// Create a new activity
  Future<Map<String, dynamic>> createActivity(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(url),
      headers: await headers(),
      body: jsonEncode(data),
    );
    return json.decode(response.body);
  }

  /// Delete an activity
  Future<Map<String, dynamic>> deleteActivity(String activityId) async {
    final response = await http.delete(
      Uri.parse("$url/$activityId"),
      headers: await headers(),
    );
    return json.decode(response.body);
  }

  /// Update an activity
  Future<Map<String, dynamic>> updateActivity(String activityId, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse("$url/$activityId"),
      headers: await headers(),
      body: jsonEncode(data),
    );
    return json.decode(response.body);
  }
} 