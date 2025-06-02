import 'dart:convert';

import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/all/crm/label/model/label_model.dart';
import 'package:http/http.dart' as http;

class LabelService {
  Future<List> getLabels() async {
    try {
      final token = await SecureStorage.getToken();
      final userData = await SecureStorage.getUserData();

      if (token == null || userData == null) {
        throw Exception('Authentication required');
      }

      final response = await http.get(
        Uri.parse('https://api.raiser.in/api/v1/labels/${userData.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true && responseData['data'] != null) {
          final List<dynamic> labelsData = responseData['data'];
          // print('Labels Data: $labelsData');
          return labelsData.map((json) => LabelModel.fromJson(json)).toList();
        }
        throw Exception('Failed to load labels');
      } else {
        throw Exception('Failed to load labels: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getLabels: $e');
      rethrow;
    }
  }

  // Helper methods to get specific types of labels
  List<LabelModel> getSources(List<LabelModel> labels) {
    return labels.where((label) => label.labelType == 'source').toList();
  }

  List<LabelModel> getCategories(List<LabelModel> labels) {
    return labels.where((label) => label.labelType == 'category').toList();
  }

  List<LabelModel> getStatuses(List<LabelModel> labels) {
    return labels.where((label) => label.labelType == 'status').toList();
  }
}
