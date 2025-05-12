import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/network/file/model/file_model.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class FileService {
  final String baseUrl = "https://api.raiser.in/api/v1";

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  Future<List<FileModel>> getLeadFiles(String leadId) async {
    try {
      
      final response = await http.get(
        Uri.parse("$baseUrl/leads/files/$leadId"),
        headers: await headers(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> filesJson = data['data'] ?? [];
          return filesJson.map((json) => FileModel.fromJson(json)).toList();
        }
      }
      return [];
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to fetch files: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return [];
    }
  }

  Future<Map<String, dynamic>?> uploadFile(String leadId, List<int> fileBytes, String fileName) async {
    try {
      print('=== FileService: Upload Process Started ===');
      print('FileService: Lead ID: $leadId');
      print('FileService: File Name: $fileName');
      print('FileService: File Size: ${fileBytes.length} bytes');

      print('FileService: Creating request...');
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/leads/files/$leadId"),
      );
      print('FileService: Request URL: ${request.url}');

      print('FileService: Getting headers...');
      final requestHeaders = await headers();
      requestHeaders.remove('Content-type');
      print('FileService: Headers: $requestHeaders');
      request.headers.addAll(requestHeaders);
      
      print('FileService: Adding file to request...');
      request.files.add(
        http.MultipartFile.fromBytes(
          'lead_files',
          fileBytes,
          filename: fileName,
        ),
      );
      print('FileService: File added to request');

      print('FileService: Sending request...');
      final streamedResponse = await request.send();
      print('FileService: Request sent, getting response...');
      final response = await http.Response.fromStream(streamedResponse);
      print('FileService: Response received');
      print('FileService: Status code: ${response.statusCode}');
      print('FileService: Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          print('FileService: Upload successful');
          return responseData['data'];
        }
      }
      
      print('FileService: Upload failed with status ${response.statusCode}');
      return null;
    } catch (e) {
      print('FileService: Error during upload: $e');
      return null;
    }
  }

  Future<bool> deleteFile(String leadId, String fileUrl) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/leads/files/$leadId"),
        headers: await headers(),
        body: json.encode({'url': fileUrl}),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "File deleted successfully",
          contentType: ContentType.success,
        );
        return true;
      }
      return false;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to delete file: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return false;
    }
  }
}
