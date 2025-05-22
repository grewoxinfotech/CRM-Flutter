import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/model/label_model.dart';
import 'package:http/http.dart' as http;

class LabelService {

  final String url = UrlRes.labels;

  Future<List<LabelModel>> getLabels() async {
    try {
      final token = await SecureStorage.getToken();
      final userData = await SecureStorage.getUserData();

      if (token == null || userData == null) {
        throw Exception('Authentication required');
      }

      final response = await http.get(
        Uri.parse('$url/${userData.id}'), 
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success'] == true && responseData['data'] != null) {
          final List<dynamic> labelsData = responseData['data'];
          final labels = labelsData.map((json) => LabelModel.fromJson(json)).toList();
          return labels;
        }
        throw Exception('Failed to load labels');
      } else {
        throw Exception('Failed to load labels: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Helper methods to get specific types of labels
  List<LabelModel> getSources(List<LabelModel> labels) {
    final sources = labels.where((label) => 
      label.labelType.toLowerCase().trim() == 'source' || 
      label.labelType.toLowerCase().trim() == 'sources'
    ).toList();
    return sources;
  }

  List<LabelModel> getCategories(List<LabelModel> labels) {
    final categories = labels.where((label) => 
      label.labelType.toLowerCase().trim() == 'category' || 
      label.labelType.toLowerCase().trim() == 'categories'
    ).toList();
    return categories;
  }

  List<LabelModel> getStatuses(List<LabelModel> labels) {
    final statuses = labels.where((label) => 
      label.labelType.toLowerCase().trim() == 'status' || 
      label.labelType.toLowerCase().trim() == 'statuses'
    ).toList();
    return statuses;
  }

  // Get label by ID
  LabelModel? getLabelById(List<LabelModel> labels, String id) {
    return labels.firstWhereOrNull((label) => label.id == id);
  }

  // Get label by name
  LabelModel? getLabelByName(List<LabelModel> labels, String name) {
    return labels.firstWhereOrNull((label) => label.name == name);
  }
}
