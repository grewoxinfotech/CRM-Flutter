import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/url_res.dart';
import '../../../../data/network/hrm/announcement/announcement_model.dart';
import '../../../../data/network/hrm/announcement/announcement_service.dart';
import '../../../../data/network/hrm/hrm_system/branch/branch_model.dart';
import '../../branch/controllers/branch_controller.dart';

class AnnouncementController extends PaginatedController<AnnouncementData> {
  final AnnouncementService _service = AnnouncementService();
  final String url = UrlRes.announcements;
  var error = ''.obs;

  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final TextEditingController timeController = TextEditingController();
  Rxn<TimeOfDay> selectedTime = Rxn<TimeOfDay>();

  // --- BRANCHES ---
  final RxList<BranchData> branches = <BranchData>[].obs;
  final BranchController branchController = Get.put(BranchController());
  // RxList<String> selectedBranch = <String>[].obs;
  RxList<BranchData> selectedBranch = <BranchData>[].obs;

  @override
  Future<List<AnnouncementData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchAnnouncements(page: page);
      print("[DEBUG]=>Response Controller : ${response}");
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
    _loadBranches();
  }

  void resetForm() {
    titleController.clear();
    descriptionController.clear();
    timeController.clear();
    dateController.clear();
    selectedBranch.value = [];
  }

  void _loadBranches() async {
    try {
      await branchController.loadInitial(); // fetches branches
      branches.assignAll(branchController.items);
    } catch (e) {
      print("Load branches error: $e");
    }
  }

  Future<void> loadSelectedBranches(List<String> ids) async {
    try {
      for (final id in ids) {
        final employee = await branchController.getBranchById(id);
        if (employee != null) {
          selectedBranch.add(employee);
        }
      }
    } catch (e) {
      print("Load employees error: $e");
    }
  }

  /// Get single announcement by ID
  Future<AnnouncementData?> getAnnouncementById(String id) async {
    try {
      final existing = items.firstWhereOrNull((item) => item.id == id);
      if (existing != null) {
        return existing;
      } else {
        final announcement = await _service.getAnnouncementById(id);
        if (announcement != null) {
          items.add(announcement);
          items.refresh();
        }
        return announcement;
      }
    } catch (e) {
      print("Get announcement error: $e");
    }
    return null;
  }

  // --- CRUD METHODS ---
  Future<bool> createAnnouncement(AnnouncementData announcement) async {
    try {
      final success = await _service.createAnnouncement(announcement);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create announcement error: $e");
      return false;
    }
  }

  Future<bool> updateAnnouncement(
    String id,
    AnnouncementData updatedAnnouncement,
  ) async {
    try {
      final success = await _service.updateAnnouncement(
        id,
        updatedAnnouncement,
      );
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedAnnouncement;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update announcement error: $e");
      return false;
    }
  }

  Future<bool> deleteAnnouncement(String id) async {
    try {
      final success = await _service.deleteAnnouncement(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      print("Delete announcement error: $e");
      return false;
    }
  }
}
