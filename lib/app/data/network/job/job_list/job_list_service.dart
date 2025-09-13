import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../widgets/common/messages/crm_snack_bar.dart';
import 'job_list_model.dart';

class JobListService {
  final String baseUrl = UrlRes.jobList; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch jobs with optional pagination & search
  Future<JobListModel?> fetchJobs({
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
        print("Jobs: $data");
        return JobListModel.fromJson(data);
      } else {
        print("Failed to load jobs: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchJobs: $e");
    }
    return null;
  }

  /// Get single job by ID
  Future<JobData?> getJobById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return JobData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get job by ID exception: $e");
    }
    return null;
  }

  /// Create new job
  Future<bool> createJob(JobData job) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(job.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Job created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to create job",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Create job exception: $e");
      return false;
    }
  }

  /// Update job
  Future<bool> updateJob(String id, JobData job) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(job.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Job updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update job",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update job exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating the job",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete job
  Future<bool> deleteJob(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete job exception: $e");
      return false;
    }
  }
}
