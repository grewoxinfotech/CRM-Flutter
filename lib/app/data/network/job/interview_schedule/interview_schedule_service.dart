import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../widgets/common/messages/crm_snack_bar.dart';
import 'interview_schedule_model.dart';

class InterviewScheduleService {
  final String baseUrl = UrlRes.interviewSchedules; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch all interview schedules (with optional search/filter if needed)
  Future<InterviewScheduleModel?> fetchInterviewSchedules({String search = ''}) async {
    try {
      final uri = Uri.parse(baseUrl).replace(
        queryParameters: {
          if (search.isNotEmpty) 'search': search,
        },
      );

      final response = await http.get(uri, headers: await headers());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("InterviewSchedules: $data");
        return InterviewScheduleModel.fromJson(data);
      } else {
        print("Failed to load interview schedules: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchInterviewSchedules: $e");
    }
    return null;
  }

  /// Get single interview schedule by ID
  Future<InterviewScheduleData?> getInterviewScheduleById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return InterviewScheduleData.fromJson(data["data"]);
      }
    } catch (e) {
      print("Get interview schedule by ID exception: $e");
    }
    return null;
  }

  /// Create interview schedule
  Future<bool> createInterviewSchedule(InterviewScheduleData schedule) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(schedule.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Interview schedule created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to create interview schedule",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Create interview schedule exception: $e");
      return false;
    }
  }

  /// Update interview schedule
  Future<bool> updateInterviewSchedule(String id, InterviewScheduleData schedule) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(schedule.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Interview schedule updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update interview schedule",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update interview schedule exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating the interview schedule",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete interview schedule
  Future<bool> deleteInterviewSchedule(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete interview schedule exception: $e");
      return false;
    }
  }
}
