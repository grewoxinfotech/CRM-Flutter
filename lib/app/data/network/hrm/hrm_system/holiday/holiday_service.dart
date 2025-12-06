import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import 'holiday_model.dart';

class HolidayService {
  final String baseUrl = UrlRes.holidays; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch holidays with optional pagination & search
  Future<HolidayModel?> fetchHolidays({
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

        return HolidayModel.fromJson(data);
      } else {
        print("Failed to load holidays: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchHolidays: $e");
    }
    return null;
  }

  /// Get single holiday by ID
  Future<HolidayData?> getHolidayById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return HolidayData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get holiday by ID exception: $e");
    }
    return null;
  }

  /// Create new holiday
  Future<bool> createHoliday(HolidayData holiday) async {
    try {
      print("=> $baseUrl ---- ${holiday.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(holiday.toJson()),
      );
      print("=> response ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create holiday exception: $e");
      return false;
    }
  }

  /// Update holiday
  Future<bool> updateHoliday(String id, HolidayData holiday) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(holiday.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Update holiday exception: $e");
      return false;
    }
  }

  /// Delete holiday
  Future<bool> deleteHoliday(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete holiday exception: $e");
      return false;
    }
  }
}
