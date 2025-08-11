import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';

class FileService {
  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  String _getBaseUrl(bool isDeal) {
    return isDeal ? UrlRes.dealsFiles : UrlRes.leadsFiles;
  }

  Future<http.Response> getFiles(String id, {bool isDeal = false}) async {
    final baseUrl = _getBaseUrl(isDeal);
    return await http.get(
      Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      );
  }

  Future<http.StreamedResponse> uploadFile(String id, List<int> fileBytes, String fileName, {bool isDeal = false}) async {
    final baseUrl = _getBaseUrl(isDeal);
      final request = http.MultipartRequest(
        'POST',
      Uri.parse("$baseUrl/$id"),
      );

      final requestHeaders = await headers();
      requestHeaders.remove('Content-type');
      request.headers.addAll(requestHeaders);
      
      request.files.add(
        http.MultipartFile.fromBytes(
        isDeal ? 'deal_files' : 'lead_files',
          fileBytes,
          filename: fileName,
        ),
      );

    return await request.send();
  }

  Future<http.Response> deleteFile(String id, String filename, {bool isDeal = false}) async {
    final baseUrl = _getBaseUrl(isDeal);
    return await http.delete(
      Uri.parse("$baseUrl/$id"),
        headers: await headers(),
      body: json.encode({'filename': filename}),
      );
  }
}
