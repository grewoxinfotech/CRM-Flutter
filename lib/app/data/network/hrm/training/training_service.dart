import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import 'training_model.dart';

class TrainingService {
  final String baseUrl = UrlRes.trainings; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch trainings with optional pagination & search
  Future<TrainingModel?> fetchTrainings({
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

        return TrainingModel.fromJson(data);
      } else {
        print("Failed to load trainings: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchTrainings: $e");
    }
    return null;
  }

  /// Get single training by ID
  Future<TrainingData?> getTrainingById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return TrainingData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get training by ID exception: $e");
    }
    return null;
  }

  /// Create new training
  Future<bool> createTraining(TrainingData training) async {
    try {
      print("[DEBUG]=> $baseUrl ---- ${training.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(training.toJson()),
      );
      print("[DEBUG]=> $baseUrl ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create training exception: $e");
      return false;
    }
  }

  /// Update training
  Future<bool> updateTraining(String id, TrainingData training) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(training.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Update training exception: $e");
      return false;
    }
  }

  /// Delete training
  Future<bool> deleteTraining(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete training exception: $e");
      return false;
    }
  }
}
