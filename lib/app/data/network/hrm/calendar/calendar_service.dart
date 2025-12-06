import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import 'calendar_model.dart';

class CalendarService {
  final String baseUrl = UrlRes.calendar; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch calendar events (with optional pagination & search)
  Future<List<CalendarData>> fetchCalendars({
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
        final List<dynamic> events = data["data"];
        return events.map((json) => CalendarData.fromJson(json)).toList();
      } else {
        print("Failed to load calendars: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchCalendars: $e");
    }
    return [];
  }

  /// Get single event by ID
  Future<CalendarData?> getCalendarById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CalendarData.fromJson(data["data"]);
      }
    } catch (e) {
      print("Get calendar by ID exception: $e");
    }
    return null;
  }

  /// Create new event
  Future<bool> createCalendar(CalendarData event) async {
    try {
      print("=> $baseUrl ---- ${event.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(event.toJson()),
      );
      print("=> $baseUrl ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create calendar exception: $e");
      return false;
    }
  }

  /// Update event
  Future<bool> updateCalendar(String id, CalendarData event) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(event.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Update calendar exception: $e");
      return false;
    }
  }

  /// Delete event
  Future<bool> deleteCalendar(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete calendar exception: $e");
      return false;
    }
  }
}
