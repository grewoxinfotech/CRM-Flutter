import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/purchase/debit_notes/model/debit_node_model.dart';
import 'package:http/http.dart' as http;

class DebitNoteService {
  final String baseUrl = "https://api.raiser.in/api/v1/bill-debits";

  static Future<Map<String, String>> headers() async =>
      await UrlRes.getHeaders();

  /// Get all debit notes
  Future<List<DebitNoteItem>> getAllDebitNotes() async {
    try {
      final response =
      await http.get(Uri.parse(baseUrl), headers: await headers());

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        // API can return `data` as null or wrapped in message
        final data = decoded['data'] ?? decoded['message']?['data'];
        if (data == null) return [];

        // If data is a list, map each item
        if (data is List) {
          return data.map((e) {
            return DebitNoteItem(
              debitNote: DebitNote.fromJson(e),
              updatedBill: UpdatedBill.fromJson(e['updatedBill'] ?? {}),
            );
          }).toList();
        }
        print('debug---${response.body}');

        // If data is a single object
        return [
          DebitNoteItem.fromJson(data),
        ];
      } else {
        throw Exception("Failed to fetch debit notes");
      }
    } catch (e) {
      print("Error fetching debit notes: $e");
      return [];
    }
  }

  /// Find a debit note by ID
  Future<DebitNoteItem?> getDebitNoteById(String id) async {
    try {
      final response =
      await http.get(Uri.parse("$baseUrl/$id"), headers: await headers());

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
  Future<Map<String, dynamic>> createDebitNote(Map<String, dynamic> payload) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(payload),
      );

      final decoded = jsonDecode(response.body);

      return {
        'success': response.statusCode == 200 || response.statusCode == 201,
        'message': decoded['message'] ?? 'Unknown error occurred'
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error: $e'
      };
    }
  }

  /// Delete a debit note
  Future<bool> deleteDebitNote(String id) async {
    try {
      final response =
      await http.delete(Uri.parse("$baseUrl/$id"), headers: await headers());
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete debit note error: $e");
      return false;
    }
  }
}
