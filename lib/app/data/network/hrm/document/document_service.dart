import 'dart:convert';
import 'dart:io';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:http/http.dart' as http;

import 'document_model.dart';

class DocumentService {
  final String baseUrl = UrlRes.documents; // Define in UrlRes

  /// Common headers
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  /// Fetch documents with optional pagination & search
  Future<List<DocumentData>> fetchDocuments({
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
        final List<dynamic> documents = data["message"]["data"];
        return documents.map((json) => DocumentData.fromJson(json)).toList();
      } else {
        print("Failed to load documents: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception in fetchDocuments: $e");
    }
    return [];
  }

  /// Get single document by ID
  Future<DocumentData?> getDocumentById(String id) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return DocumentData.fromJson(data["message"]["data"]);
      }
    } catch (e) {
      print("Get document by ID exception: $e");
    }
    return null;
  }

  /// Create new document
  Future<bool> createDocument(DocumentData document,File? file) async {
    try {
      print("[DEBUG]=> $baseUrl ---- ${document.toJson()}");
      final uri = Uri.parse(baseUrl);
      final request = http.MultipartRequest("POST",uri);

      // Add headers
      final headerData = await headers();
      request.headers.addAll(headerData);

      // Add text fields
      request.fields['name'] = document.name ?? '';
      request.fields['role'] = document.role ?? '';
      request.fields['description'] = document.description ?? '';

      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'file', // 👈 your API file field name
            file.path,
          ),
        );
      }


      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // final response = await http.post(
      //   Uri.parse(baseUrl),
      //   headers: await headers(),
      //   body: jsonEncode(document.toJson()),
      // );
      print("[DEBUG]=> $baseUrl ---- ${response.body}");
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create document exception: $e");
      return false;
    }
  }

  /// Update document
  Future<bool> updateDocument(String id, DocumentData document,File? file) async {
    try {
      final uri = Uri.parse("$baseUrl/$id");
      final request = http.MultipartRequest("PUT",uri);
      final headerData = await headers();
      request.headers.addAll(headerData);
      request.fields['name'] = document.name ?? '';
      request.fields['role'] = document.role ?? '';
      request.fields['description'] = document.description ?? '';
      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'file', // 👈 your API file field name
            file.path,
          ),
        );
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return response.statusCode == 200;



      return response.statusCode == 200;
    } catch (e) {
      print("Update document exception: $e");
      return false;
    }
  }

  /// Delete document
  Future<bool> deleteDocument(String id) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      print("Delete document exception: $e");
      return false;
    }
  }
}
