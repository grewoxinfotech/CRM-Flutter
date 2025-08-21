import 'dart:io';

import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/document/document_model.dart';
import '../../../../data/network/hrm/document/document_service.dart';


class DocumentController extends PaginatedController<DocumentData> {
  final DocumentService _service = DocumentService();
  final String url = UrlRes.documents;
  var error = ''.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController fileController = TextEditingController();

  Rxn<File> selectedFile = Rxn<File>();

  RxList<String> roles = ["manager", "admin", "employee","hr"].obs;
  RxString selectedRole = "".obs;

  RxString selectedClientId = "".obs;

  @override
  Future<List<DocumentData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchDocuments(page: page);
      return response;
    } catch (e) {
      print("Exception in fetchItems: $e");
      throw Exception("Exception in fetchItems: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInitial();
    selectedClientId.value = "IPoucZkvAMQ0BX1owqj5jxK"; // Default clientId
  }

  void resetForm() {
    nameController.clear();
    roleController.clear();
    descriptionController.clear();
    fileController.clear();
    selectedFile.value = null;
  }

  /// Get single document by ID
  Future<DocumentData?> getDocumentById(String id) async {
    try {
      final existingDoc = items.firstWhereOrNull((item) => item.id == id);
      if (existingDoc != null) {
        return existingDoc;
      } else {
        final document = await _service.getDocumentById(id);
        if (document != null) {
          items.add(document);
          items.refresh();
          return document;
        }
      }
    } catch (e) {
      print("Get document error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createDocument(DocumentData document,File? file) async {
    try {
      final success = await _service.createDocument(document, file);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create document error: $e");
      return false;
    }
  }

  Future<bool> updateDocument(String id, DocumentData updatedDocument,File? file) async {
    try {
      final success = await _service.updateDocument(id, updatedDocument,file);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedDocument;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update document error: $e");
      return false;
    }
  }

  Future<bool> deleteDocument(String id) async {
    try {
      final success = await _service.deleteDocument(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete document error: $e");
      return false;
    }
  }
}
