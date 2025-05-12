import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';

class FileService {
  final String baseUrl = UrlRes.leadsFiles;


  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<http.Response> getLeadFiles(String leadId) async {
    return await http.get(
      Uri.parse("$baseUrl/$leadId"),
      headers: await headers(),
    );
  }

  Future<http.StreamedResponse> uploadFile(String leadId, List<int> fileBytes, String fileName) async {
    print('Uploading file: $fileName for lead: $leadId');
    print('Base URL: $baseUrl');
    
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/$leadId"),
    );

    final requestHeaders = await headers();
    requestHeaders.remove('Content-type');
    request.headers.addAll(requestHeaders);
    
    print('Request headers: ${request.headers}');
    
    request.files.add(
      http.MultipartFile.fromBytes(
        'lead_files',
        fileBytes,
        filename: fileName,
      ),
    );


    print('Sending upload request...');
    final response = await request.send();
    print('Upload response status: ${response.statusCode}');
    
    return response;
  }

  Future<http.Response> deleteFile(String leadId, String filename) async {
    return await http.delete(
      Uri.parse("$baseUrl/$leadId"),
      headers: await headers(),
      body: json.encode({'filename': filename}),
    );
  }
}
