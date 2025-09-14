import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../widgets/common/messages/crm_snack_bar.dart';
import 'job_onboarding_model.dart';

class JobOnboardingService {
  final String baseUrl = UrlRes.jobOnboarding; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch job onboardings with optional pagination & search
  Future<JobOnboardingModel?> fetchJobOnboardings({
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
        print("Job Onboardings: $data");
        return JobOnboardingModel.fromJson(data);
      } else {
        print("Failed to load job onboardings: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchJobOnboardings: $e");
    }
    return null;
  }

  /// Get single job onboarding by ID
  Future<JobOnboardingData?> getJobOnboardingById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return JobOnboardingData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get job onboarding by ID exception: $e");
    }
    return null;
  }

  /// Create job onboarding
  Future<bool> createJobOnboarding(JobOnboardingData job) async {
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
          message: responseData["message"] ?? "Job onboarding created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to create job onboarding",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Create job onboarding exception: $e");
      return false;
    }
  }

  /// Update job onboarding
  Future<bool> updateJobOnboarding(String id, JobOnboardingData job) async {
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
          message: responseData["message"] ?? "Job onboarding updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update job onboarding",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update job onboarding exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating the job onboarding",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete job onboarding
  Future<bool> deleteJobOnboarding(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete job onboarding exception: $e");
      return false;
    }
  }
}
