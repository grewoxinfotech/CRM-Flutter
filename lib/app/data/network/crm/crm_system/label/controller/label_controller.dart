import 'package:crm_flutter/app/data/network/crm/crm_system/label/model/label_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/service/label_service.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:get/get.dart';

class LabelController extends GetxController {
  final LabelService labelService = LabelService();
  final RxList<LabelModel> labels = <LabelModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Defer initialization to avoid build-time errors
    Future.microtask(() {
      try {
        getLabels();
      } catch (e) {
        // Silently handle initialization errors
        isLoading.value = false;
      }
    });
  }

  Future<void> getLabels() async {
    try {
      isLoading.value = true;
      final fetchedLabels = await labelService.getLabels();
      labels.assignAll(fetchedLabels);
    } catch (e) {
      // Defer showing snackbar to avoid build-time errors
      Future.microtask(() {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to fetch labels: ${e.toString()}',
          contentType: ContentType.failure,
        );
      });
    } finally {
      isLoading.value = false;
    }
  }

  /// Get sources
  List<LabelModel> getSources() {
    return labelService.getSources(labels);
  }

  /// Get categories
  List<LabelModel> getCategories() {
    return labelService.getCategories(labels);
  }

  /// Get statuses
  List<LabelModel> getStatuses() {
    return labelService.getStatuses(labels);
  }

  /// Get label name by ID or name
  String getLabelName(String labelIdOrName) {
    try {
      if (labelIdOrName.isEmpty) return '';
      if (labels.isEmpty) return '';
      
      // First try to find by ID
      final labelById = labels.firstWhereOrNull((label) => label.id == labelIdOrName);
      if (labelById != null) {
        return labelById.name;
      }
      
      // If not found by ID, try to find by name
      final labelByName = labels.firstWhereOrNull((label) => label.name == labelIdOrName);
      if (labelByName != null) {
        return labelByName.name;
      }
      
      return ''; // Return empty string if not found
    } catch (e) {
      return ''; // Return empty string on error
    }
  }
} 