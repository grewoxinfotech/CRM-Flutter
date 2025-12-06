import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../widgets/common/messages/crm_snack_bar.dart';
import 'employee_model.dart';

class EmployeeService {
  final String baseUrl = UrlRes.employees; // Define in UrlRes
  final String otpUrl = UrlRes.verifySignup; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch employees with optional pagination & search
  Future<EmployeeModel?> fetchEmployees({
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
        return EmployeeModel.fromJson(data);
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to load employees: ${response.statusCode}",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      print("Exception in fetchEmployees: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while fetching employees",
        contentType: ContentType.failure,
      );
    }
    return null;
  }

  /// Get single employee by ID
  Future<EmployeeData?> getEmployeeById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return EmployeeData.fromJson(data["message"]["data"]);
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to fetch employee details",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      print("Get employee by ID exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while fetching employee details",
        contentType: ContentType.failure,
      );
    }
    return null;
  }

  /// Verify OTP
  Future<bool> verifyOtp(String otp, String token) async {
    try {
      final url = Uri.parse(otpUrl);
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"otp": otp}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "OTP Verified Successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to verify OTP",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Verify OTP error: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while verifying OTP",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Create new employee
  Future<String?> createEmployee(EmployeeData employee) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(employee.toJson()),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Employee created successfully",
          contentType: ContentType.success,
        );
        return responseData["data"]?["verificationToken"] ??
            responseData["message"];
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to create employee",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      print("Create employee exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while creating employee",
        contentType: ContentType.failure,
      );
    }
    return null;
  }

  /// Update employee
  Future<bool> updateEmployee(String id, EmployeeData employee) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(employee.toJson()),
      );

      final responseData = jsonDecode(response.body);
      print("Update employee response: $responseData");

      if (response.statusCode == 200) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: responseData["message"] ?? "Employee updated successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to update employee",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Update employee exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while updating employee",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  /// Delete employee
  Future<bool> deleteEmployee(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Employee deleted successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        final responseData = jsonDecode(response.body);
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: responseData["message"] ?? "Failed to delete employee",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      print("Delete employee exception: $e");
      CrmSnackBar.showAwesomeSnackbar(
        title: "Exception",
        message: "Something went wrong while deleting employee",
        contentType: ContentType.failure,
      );
      return false;
    }
  }
}
