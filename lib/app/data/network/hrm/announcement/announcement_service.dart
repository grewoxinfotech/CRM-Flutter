import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import 'announcement_model.dart';

class AnnouncementService {
  final String baseUrl = UrlRes.announcements; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<AnnouncementModel?> fetchAnnouncements({
    int page = 1,
    int pageSize = 10,
    String search = '',
  }) async {
    try {
      // print("=>Announcement : ${baseUrl}");
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

        return AnnouncementModel.fromJson(data);
      } else {
        print("Failed to load announcements: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchAnnouncements: $e");
    }
    return null;
  }

  /// Get single announcement by ID
  Future<AnnouncementData?> getAnnouncementById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AnnouncementData.fromJson(data["data"]);
      }
    } catch (e) {
      print("Get announcement by ID exception: $e");
    }
    return null;
  }

  /// Create new announcement
  Future<bool> createAnnouncement(AnnouncementData announcement) async {
    try {
      print("=> $baseUrl ---- ${announcement.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(announcement.toJson()),
      );
      print("=> response ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create announcement exception: $e");
      return false;
    }
  }

  /// Update announcement
  Future<bool> updateAnnouncement(
    String id,
    AnnouncementData announcement,
  ) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(announcement.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Update announcement exception: $e");
      return false;
    }
  }

  /// Delete announcement
  Future<bool> deleteAnnouncement(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete announcement exception: $e");
      return false;
    }
  }
}
