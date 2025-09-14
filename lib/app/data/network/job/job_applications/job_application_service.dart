import 'dart:convert';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../widgets/common/messages/crm_snack_bar.dart';
import 'job_application_model.dart';

class JobApplicationService {
  final String baseUrl = UrlRes.jobApplications; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch job applications with optional pagination & search
  Future<JobApplicationModel?> fetchJobApplications({
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
        print("Job Applications: $data");
        return JobApplicationModel.fromJson(data);
      } else {
        print("Failed to load job applications: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchJobApplications: $e");
    }
    return null;
  }

  /// Get single job application by ID
  Future<JobApplicationData?> getJobApplicationById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return JobApplicationData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get job application by ID exception: $e");
    }
    return null;
  }

  /// Create a new job application
  // Future<bool> createJobApplication(JobApplicationData application) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(baseUrl),
  //       headers: await headers(),
  //       body: jsonEncode(application.toJson()),
  //     );
  //
  //     final responseData = jsonDecode(response.body);
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       CrmSnackBar.showAwesomeSnackbar(
  //         title: "Success",
  //         message: responseData["message"] ?? "Job application created successfully",
  //         contentType: ContentType.success,
  //       );
  //       return true;
  //     } else {
  //       CrmSnackBar.showAwesomeSnackbar(
  //         title: "Error",
  //         message: responseData["message"] ?? "Failed to create job application",
  //         contentType: ContentType.failure,
  //       );
  //       return false;
  //     }
  //   } catch (e) {
  //     print("Create job application exception: $e");
  //     return false;
  //   }
  // }

  Future<bool> createJobApplication(JobApplicationData application, File file) async {
    try {
      final uri = Uri.parse(baseUrl);

      final request = http.MultipartRequest("POST", uri);

      // Attach headers
      request.headers.addAll(await headers());

      // Add text fields from application
      request.fields.addAll({
        "phoneCode": application.phoneCode ?? "",
        "phone": application.phone ?? "",
        "job": application.job ?? "",
        "name": application.name ?? "",
        "email": application.email ?? "",
        "location": application.location ?? "",
        "total_experience": application.totalExperience ?? "",
        "current_location": application.currentLocation ?? "",
        "notice_period": application.noticePeriod ?? "",
        "applied_source": application.appliedSource ?? "",
        "status": application.status ?? "",
      });

      // Add file
      if (file.existsSync()) {
        request.files.add(
          await http.MultipartFile.fromPath("file", file.path),
        );
      }

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Job application created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to create job application",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Create job application exception: $e");
      return false;
    }
  }

  /// Update existing job application
  Future<bool> updateJobApplication(
      String id,
      JobApplicationData application,
        File? file,
      ) async {
    try {
      final uri = Uri.parse("$baseUrl/$id");

      final request = http.MultipartRequest("PUT", uri);

      // Attach headers
      request.headers.addAll(await headers());

      // Add text fields from application
      request.fields.addAll({
        "phoneCode": application.phoneCode ?? "",
        "phone": application.phone ?? "",
        "job": application.job ?? "",
        "name": application.name ?? "",
        "email": application.email ?? "",
        "location": application.location ?? "",
        "total_experience": application.totalExperience ?? "",
        "current_location": application.currentLocation ?? "",
        "notice_period": application.noticePeriod ?? "",
        "applied_source": application.appliedSource ?? "",
        "status": application.status ?? "",
      });

      // Add file only if provided
      if (file != null && file.existsSync()) {
        request.files.add(
          await http.MultipartFile.fromPath("file", file.path),
        );
      }

      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message:
          responseData["message"] ?? "Job application updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message:
          responseData["message"] ?? "Failed to update job application",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update job application exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating the job application",
        contentType: ContentType.failure,
      );
      return false;
    }
  }


  /// Delete job application
  Future<bool> deleteJobApplication(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete job application exception: $e");
      return false;
    }
  }
}
