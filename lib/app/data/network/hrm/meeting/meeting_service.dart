import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import 'meeting_model.dart';

class MeetingService {
  final String baseUrl = UrlRes.meetings; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch meetings with optional pagination & search
  Future<MeetingModel?> fetchMeetings({
    int page = 1,
    int pageSize = 10,
    String search = '',
  }) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {
          'page': page.toString(),
          'pageSize': pageSize.toString(),
          'search': search,
        },
      );

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return MeetingModel.fromJson(data);
      } else {
        print("Failed to load meetings: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchMeetings: $e");
    }
    return null;
  }

  /// Get single meeting by ID
  Future<MeetingData?> getMeetingById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return MeetingData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get meeting by ID exception: $e");
    }
    return null;
  }

  /// Create new meeting
  Future<bool> createMeeting(MeetingData meeting) async {
    try {
      print("[DEBUG]=> $baseUrl ---- ${meeting.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(meeting.toJson()),
      );
      print("[DEBUG]=> response ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create meeting exception: $e");
      return false;
    }
  }

  /// Update meeting
  Future<bool> updateMeeting(String id, MeetingData meeting) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(meeting.toJson()),
      );
      print("[DEBUG]=> response ---- ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Update meeting exception: $e");
      return false;
    }
  }

  /// Delete meeting
  Future<bool> deleteMeeting(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete meeting exception: $e");
      return false;
    }
  }
}
