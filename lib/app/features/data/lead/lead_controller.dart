import 'package:crm_flutter/app/features/data/lead/lead_model.dart';
import 'package:crm_flutter/app/features/data/lead/lead_service.dart';
import 'package:get/get.dart';

class LeadController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<LeadModel> leadsList = <LeadModel>[].obs;
  final LeadService leadService = LeadService();

  @override
  void onInit() {
    super.onInit();
    fetchLeads();
  }

  Future<void> fetchLeads() async {
    isLoading(true);
    try {
      final leads = await leadService.fetchLeads();
      leadsList.assignAll(leads);
      print("Deals fetched successfully: ${leads.length} deals found");
      isLoading(false);
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Failed to load leads");
      isLoading(false);
    }
    isLoading(false);
  }

  Future<bool> deleteLead(String leadId) async {
    isLoading(true);
    try {
      bool success = await leadService.deleteLead(leadId);
      if (success) {
        leadsList.removeWhere((lead) => lead.id == leadId);
        Get.back();
        Get.snackbar("Success", "Lead deleted successfully");
        isLoading(false);
        return true;
      } else {
        Get.snackbar("Error", "Failed to delete lead");
        isLoading(false);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      isLoading(false);
      return false;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    isLoading(false);
    leadService.dispose();
    super.onClose();
  }
}
