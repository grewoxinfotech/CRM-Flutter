import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/hrm/payroll/salary/salary_model.dart';
import 'package:http/http.dart' as http;

class PayslipService {
  final String baseUrl = UrlRes.salary; // Define this in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch payslips with optional pagination & search
  Future<PayslipModel?> fetchPayslips({
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

        return PayslipModel.fromJson(data);
      } else {
        print("Failed to load payslips: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchPayslips: $e");
    }
    return null;
  }

  /// Get single payslip by ID
  Future<PayslipData?> getPayslipById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PayslipData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get payslip by ID exception: $e");
    }
    return null;
  }

  /// Create new payslip
  Future<bool> createPayslip(PayslipData payslip) async {
    try {
      print("=> $baseUrl ---- ${payslip.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(payslip.toJson()),
      );
      print("=> $baseUrl ---- ${response.body}");
      print("=> $baseUrl ---- ${response.statusCode}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create payslip exception: $e");
      return false;
    }
  }

  /// Update payslip
  Future<bool> updatePayslip(String id, PayslipData payslip) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(payslip.toJson()),
      );

      print("=> $baseUrl ---- ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      print("Update payslip exception: $e");
      return false;
    }
  }

  /// Delete payslip
  Future<bool> deletePayslip(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete payslip exception: $e");
      return false;
    }
  }
}
