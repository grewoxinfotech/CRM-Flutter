import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/training/training_model.dart';
import '../../../../data/network/hrm/training/training_service.dart';

class TrainingController extends PaginatedController<TrainingData> {
  final TrainingService _service = TrainingService();
  final String url = UrlRes.trainings;
  var errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();

  /// Inputs
  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  /// Links: titles + urls
  RxList<TextEditingController> linkTitleControllers =
      <TextEditingController>[].obs;
  RxList<TextEditingController> linkUrlControllers =
      <TextEditingController>[].obs;

  /// for links (urls + titles)
  RxList<String> urls = <String>[].obs;
  RxList<String> linkTitles = <String>[].obs;

  @override
  Future<List<TrainingData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchTrainings(page: page);
      print("Response: ${response!.toJson()}");
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch Training";
        return [];
      }
    } catch (e) {
      errorMessage.value = "Exception in fetchItems: $e";
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }

  void resetForm() {
    titleController.clear();
    categoryController.clear();
    linkTitleControllers.clear();
    linkUrlControllers.clear();
    urls.clear();
    linkTitles.clear();
  }

  void setLinks(TrainingLinks? links) {
    linkTitleControllers.clear();
    linkUrlControllers.clear();

    if (links != null) {
      for (int i = 0; i < links.titles!.length; i++) {
        final title = links.titles![i];
        final url = (i < links.urls!.length) ? links.urls![i] : "";
        addLinkField(title: title, url: url);
      }
    }
  }

  /// Simple aliases for UI
  void addLink() => addLinkField();

  void removeLink(int index) => removeLinkField(index);

  /// Add a new link field
  void addLinkField({String? title, String? url}) {
    linkTitleControllers.add(TextEditingController(text: title ?? ""));
    linkUrlControllers.add(TextEditingController(text: url ?? ""));
  }

  /// Remove a link field
  void removeLinkField(int index) {
    if (index < linkTitleControllers.length &&
        index < linkUrlControllers.length) {
      linkTitleControllers.removeAt(index);
      linkUrlControllers.removeAt(index);
    }
  }

  /// Get single training by ID
  Future<TrainingData?> getTrainingById(String id) async {
    try {
      final existingTraining = items.firstWhereOrNull((item) => item.id == id);
      if (existingTraining != null) {
        return existingTraining;
      } else {
        final training = await _service.getTrainingById(id);
        if (training != null) {
          items.add(training);
          items.refresh();
          return training;
        }
      }
    } catch (e) {
      print("Get training error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createTraining(TrainingData training) async {
    try {
      final success = await _service.createTraining(training);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create training error: $e");
      return false;
    }
  }

  Future<bool> updateTraining(String id, TrainingData updatedTraining) async {
    try {
      final success = await _service.updateTraining(id, updatedTraining);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedTraining;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update training error: $e");
      return false;
    }
  }

  Future<bool> deleteTraining(String id) async {
    try {
      final success = await _service.deleteTraining(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete training error: $e");
      return false;
    }
  }
}
