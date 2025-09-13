import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../widgets/common/messages/crm_snack_bar.dart';
import 'job_candidate_model.dart';

class JobCandidateService {
  final String baseUrl = UrlRes.jobCandidates; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch job candidates with optional pagination & search
  Future<JobCandidateModel?> fetchCandidates({
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
        print("Job Candidates: ${data}");
        return JobCandidateModel.fromJson(data);
      } else {
        print("Failed to load job candidates: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchCandidates: $e");
    }
    return null;
  }

  /// Get single candidate by ID
  Future<JobCandidateData?> getCandidateById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return JobCandidateData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get candidate by ID exception: $e");
    }
    return null;
  }

  /// Create new candidate
  Future<bool> createCandidate(JobCandidateData candidate) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(candidate.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Candidate created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to create candidate",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Create candidate exception: $e");
      return false;
    }
  }

  /// Update candidate
  Future<bool> updateCandidate(String id, JobCandidateData candidate) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(candidate.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Candidate updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update candidate",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update candidate exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating the candidate",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete candidate
  Future<bool> deleteCandidate(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete candidate exception: $e");
      return false;
    }
  }
}
