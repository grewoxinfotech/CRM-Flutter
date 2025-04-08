import 'package:crm_flutter/app/features/data/lead/lead_home/lead_model.dart';
import 'package:crm_flutter/app/features/data/lead/lead_home/lead_service.dart';
import 'package:get/get.dart';

class LeadController extends GetxController {
  late final LeadService leadService;
  final RxList<LeadModel> leadsList = <LeadModel>[].obs;
  final RxBool isLoading = false.obs;

  var lead = LeadModel().obs;

  @override
  void onInit() {
    super.onInit();
        leadService = LeadService();

    fetchLeads();
  }

  Future<void> fetchLeads() async {
    try {
      isLoading.value = true;
      final leads = await leadService.fetchLeads();
      leadsList.assignAll(leads);
    } catch (e) {
      Get.snackbar("Error", "Failed to load leads");
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteLead(String leadId) async {
    try {
      bool success = await leadService.deleteLead(leadId);
      if (success) {
        leadsList.removeWhere((lead) => lead.id == leadId);
        Get.back();
        Get.snackbar("Success", "Lead deleted successfully");
        return true;
      } else {
        Get.snackbar("Error", "Failed to delete lead");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      return false;
    }
  }

  // Function to fetch lead data from the API
  // void fetchLeads() async {
  //   if (leadsList.isNotEmpty) return; // Prevents multiple API calls
  //
  //   try {
  //     isLoading(true);
  //     var fetchedLeads = await leadService.fetchLeads();
  //     if (fetchedLeads.isNotEmpty) {
  //       leadsList.assignAll(fetchedLeads);
  //       print("Leads fetched successfully: ${leadsList.length} leads found");
  //     }
  //   } catch (error) {
  //     print("Error fetching leads: $error");
  //   } finally {
  //     isLoading(false);
  //   }
  // }


}
