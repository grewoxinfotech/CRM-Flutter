import 'dart:convert';
import 'package:crm_flutter/app/data/network/file/model/file_model.dart';
import 'package:crm_flutter/app/data/network/file/service/file_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FileController extends GetxController {
  final RxList<FileModel> files = <FileModel>[].obs;
  final FileService fileService = FileService();

  void setFilesFromLeadData(List<dynamic> filesData) {
    try {
      files.clear();
      files.addAll(filesData.map((file) {
        if (file is Map<String, dynamic>) {
          return FileModel(
            url: file['url'],
            filename: file['filename'],
          );
        } else if (file is FileModel) {
          return file;
        }
        throw Exception('Invalid file data format');
      }));
    } catch (e) {
      files.clear();
    }
  }

  Future<bool> deleteFile(String leadId, String filename) async {
    try {
      final response = await fileService.deleteFile(leadId, filename);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        // Create a new list without the deleted file
        final updatedFiles = files.where((file) => file.filename != filename).toList();
        files.clear();
        files.addAll(updatedFiles);
        
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

  Future<void> refreshFiles(String leadId) async {
    try {
      final response = await fileService.getLeadFiles(leadId);
      final data = jsonDecode(response.body);
      
      if (response.statusCode == 200 && data['success'] == true) {
        final filesData = data['data']['files'] ?? [];
        setFilesFromLeadData(filesData);
      }
    } catch (e) {
      files.clear();
    }
  }

  Future<Map<String, dynamic>?> uploadFile(String leadId, List<int> fileBytes, String fileName) async {
    try {
      final streamedResponse = await fileService.uploadFile(leadId, fileBytes, fileName);
      final response = await http.Response.fromStream(streamedResponse);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        
        if (data['success'] == true) {
          await refreshFiles(leadId);
          return data['data'];
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}