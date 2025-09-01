import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;


import '../../../widgets/common/messages/crm_snack_bar.dart';
import 'inquiry_model.dart';

class InquiryService {
  final String baseUrl = UrlRes.inquiry; // Define in UrlRes (like branches)

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch all inquiries (with optional pagination later if API supports)
  Future<List<InquiryData>> fetchInquiries() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> inquiries = data["data"];
        return inquiries.map((json) => InquiryData.fromJson(json)).toList();
      } else {
        print("Failed to load inquiries: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchInquiries: $e");
    }
    return [];
  }

  /// Get single inquiry by ID
  Future<InquiryData?> getInquiryById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return InquiryData.fromJson(data["data"]);
      }
    } catch (e) {
      print("Get inquiry by ID exception: $e");
    }
    return null;
  }

  /// Create new inquiry
  Future<bool> createInquiry(InquiryData inquiry) async {
    try {
      print("Creating inquiry with data: ${inquiry.toJson()}");
      print("Base URL: $baseUrl");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(inquiry.toJson()),
      );
      print("Response Status Code: ${response.statusCode}");

      final responseData = jsonDecode(response.body);
      print("Response Data: $responseData");

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Inquiry created successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to create inquiry",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Create inquiry exception: $e");
      return false;
    }
  }

  /// Update inquiry
  Future<bool> updateInquiry(String id, InquiryData inquiry) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(inquiry.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Inquiry updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update inquiry",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update inquiry exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating the inquiry",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete inquiry
  Future<bool> deleteInquiry(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete inquiry exception: $e");
      return false;
    }
  }
}
