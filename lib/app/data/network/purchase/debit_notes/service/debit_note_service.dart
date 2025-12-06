import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/purchase/debit_notes/model/debit_node_model.dart';
import 'package:http/http.dart' as http;

class DebitNoteService {
  final String baseUrl = "https://api.raiser.in/api/v1/bill-debits";

  static Future<Map<String, String>> headers() async =>
      await UrlRes.getHeaders();

  /// Get all debit notes
  Future<DebitNoteModel?> fetchDebitNotes({
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

        // Debugging
        print("DebitNotes Response: $data");

        return DebitNoteModel.fromJson(data);
      } else {
        print("Failed to load debit notes: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchDebitNotes: $e");
    }
    return null;
  }

  /// Find a debit note by ID
  Future<DebitNoteItem?> getDebitNoteById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        // API may wrap data inside 'data' or 'message.data'
        final data = decoded['data'] ?? decoded['message']?['data'];
        if (data == null) return null;

        return DebitNoteItem.fromJson(data);
      } else {
        throw Exception("Failed to fetch debit note by ID");
      }
    } catch (e) {
      print("Error fetching debit note by ID: $e");
      return null;
    }
  }

  /// Create a new debit note
  Future<Map<String, dynamic>> createDebitNote(
    Map<String, dynamic> payload,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(payload),
      );

      final decoded = jsonDecode(response.body);

      return {
        'success': response.statusCode == 200 || response.statusCode == 201,
        'message': decoded['message'] ?? 'Unknown error occurred',
      };
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }

  /// Delete a debit note
  Future<bool> deleteDebitNote(String id) async {
    try {
      print("=> $baseUrl/$id");
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      print("=> ${response.body}");
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete debit note error: $e");
      return false;
    }
  }
}
