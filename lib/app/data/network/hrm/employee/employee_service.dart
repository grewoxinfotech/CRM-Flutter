import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import 'employee_model.dart';

class EmployeeService {
  final String baseUrl = UrlRes.employees; // Define in UrlRes
  final String otpUrl = UrlRes.verifySignup; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch employees with optional pagination & search
  // Future<List<EmployeeData>> fetchEmployees({
  //   int page = 1,
  //   int pageSize = 10,
  //   String search = '',
  // }) async {
  //   try {
  //     final uri = Uri.parse(baseUrl).replace(
  //       queryParameters: {
  //         'page': page.toString(),
  //         'pageSize': pageSize.toString(),
  //         'search': search,
  //       },
  //     );
  //
  //     final response = await http.get(uri, headers: await headers());
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       print("[DEBUG]=>Employee:${data}");
  //
  //       final List<dynamic> employees = data["message"]["data"];
  //       print("[DEBUG]=>Employee:${employees.toString()}");
  //       return employees.map((json) => EmployeeData.fromJson(json)).toList();
  //     } else {
  //       print("Failed to load employees: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Exception in fetchEmployees: $e");
  //   }
  //   return [];
  // }

  Future<List<EmployeeData>> fetchEmployees({
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

        final List<dynamic> employees = data["message"]["data"];
        return employees.map((json) => EmployeeData.fromJson(json)).toList();
      } else {
        print("Failed to load employees: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchEmployees: $e");
    }
    return [];
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
      }
    } catch (e) {
      print("Get employee by ID exception: $e");
    }
    return null;
  }

  Future<bool> verifyOtp(String otp, String token) async {
    try {
      print("[DEBUG]=>otop $otp");
      final url = Uri.parse("$otpUrl");
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token", // 👈 token in header
        },
        body: jsonEncode({"otp": otp}),
      );
      print("[DEBUG]=> data : ${response.body}");
      // if (response.statusCode == 200) {
      //   final data = jsonDecode(response.body);
      //   return data["success"] == true;
      // }
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Verify OTP error: $e");
      return false;
    }
  }

  /// Create new employee
  // Future<String> createEmployee(EmployeeData employee) async {
  //   try {
  //     print("[DEBUG]=> $baseUrl ---- ${employee.toJson()}");
  //     final response = await http.post(
  //       Uri.parse(baseUrl),
  //       headers: await headers(),
  //       body: jsonEncode(employee.toJson()),
  //     );
  //     print("[DEBUG]=> Response: ${response.body}");
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final decoded = jsonDecode(response.body);
  //
  //       if (decoded["success"] == true) {
  //         final token = decoded["data"]?["verificationToken"];
  //         final message = decoded["message"];
  //
  //         print("[DEBUG]=> Verification Token: $token");
  //         print("[DEBUG]=> Message: $message");
  //
  //         // Return token if exists, else return message
  //         return token ?? message;
  //       }
  //     }
  //   } catch (e) {
  //     print("Create employee exception: ${e}");
  //   }
  // }

  Future<String?> createEmployee(EmployeeData employee) async {
    try {
      print("[DEBUG]=> $baseUrl ---- ${employee.toJson()}");

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(employee.toJson()),
      );

      print("[DEBUG]=> Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);

        if (decoded["success"] == true) {
          final token = decoded["data"]?["verificationToken"];
          final message = decoded["message"];

          print("[DEBUG]=> Verification Token: $token");
          print("[DEBUG]=> Message: $message");

          return token ?? message;
        }
      }

      return null; // failure case
    } catch (e) {
      print("Create employee exception: $e");
      return null; // failure case
    }
  }

  /// Update employee
  Future<bool> updateEmployee(String id, EmployeeData employee) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(employee.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Update employee exception: $e");
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
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete employee exception: $e");
      return false;
    }
  }
}
