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
      if (filesData.isEmpty) {
        files.clear();
        update();
        return;
      }

      final newFiles = filesData.map((file) {
        if (file is FileModel) {
          return file;
        } else if (file is Map<String, dynamic>) {
          return FileModel(
            url: file['url'] as String,
            filename: file['filename'] as String,
          );
        }
        throw Exception('Invalid file data format');
      }).toList();
      
      files.value = newFiles;
      update();
    } catch (e) {
      files.clear();
      update();
    }
  }

  Future<bool> deleteFile(String leadId, String filename) async {
    try {
      final response = await fileService.deleteFile(leadId, filename);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 204) {
        files.removeWhere((file) => file.filename == filename);
        update();
        
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
      update();
    }
  }

  Future<Map<String, dynamic>?> uploadFile(String leadId, List<int> fileBytes, String fileName) async {
    try {
      final streamedResponse = await fileService.uploadFile(leadId, fileBytes, fileName);
      final response = await http.Response.fromStream(streamedResponse);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        
        if (data['success'] == true) {
          // Use the files data directly from the upload response
          final filesData = data['data']['files'] ?? [];
          setFilesFromLeadData(filesData);
          return data['data'];
        }
      } else {
        final data = jsonDecode(response.body);
        final errorMessage = data['message'] ?? 'File upload failed';
        
        CrmSnackBar.showAwesomeSnackbar(
          title: "Upload Failed",
          message: errorMessage,
          contentType: ContentType.failure,
        );
      }
      return null;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to upload file: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return null;
    }
  }
}