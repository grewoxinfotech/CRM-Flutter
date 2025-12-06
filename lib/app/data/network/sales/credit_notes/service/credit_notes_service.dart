import 'dart:convert';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import '../../../../database/storage/secure_storage_service.dart';
import '../model/credit_notes_model.dart';

class CreditNoteService {
  final String baseUrl = UrlRes.creditNotes; // Define this in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch credit notes with optional pagination & search
  Future<CreditNoteModel?> fetchCreditNotes({
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
        print("CreditNotes Response: $data");
        return CreditNoteModel.fromJson(data);
      } else {
        print("Failed to load credit notes: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchCreditNotes: $e");
    }
    return null;
  }

  /// Get single credit note by ID
  Future<CreditNoteData?> getCreditNoteById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CreditNoteData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get credit note by ID exception: $e");
    }
    return null;
  }

  /// Create new credit note
  Future<bool> createCreditNote(CreditNoteData creditNote) async {
    try {
      print("=> $baseUrl ---- ${creditNote.toJson()}");
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: await headers(),
        body: jsonEncode(creditNote.toJson()),
      );
      print("=> $baseUrl ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create credit note exception: $e");
      return false;
    }
  }

  /// Update credit note
  Future<bool> updateCreditNote(String id, CreditNoteData creditNote) async {
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
        body: jsonEncode(creditNote.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Update credit note exception: $e");
      return false;
    }
  }

  /// Delete credit note
  Future<bool> deleteCreditNote(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete credit note exception: $e");
      return false;
    }
  }
}
