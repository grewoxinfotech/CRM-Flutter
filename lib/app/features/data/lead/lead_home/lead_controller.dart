import 'package:crm_flutter/app/features/data/lead/lead_home/lead_model.dart';
import 'package:crm_flutter/app/features/data/lead/lead_home/lead_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeadController extends GetxController {
  var isLoading = true.obs;
  var leadsList = <LeadModel>[].obs;
  final LeadService leadService = LeadService();

  var lead = LeadModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeads();
  }

  void fetchLeads() async {
    try {
      isLoading(true);
      var leads = await leadService.fetchLeads();
      leadsList.assignAll(leads);
      print("object");
      print("Leads fetched successfully: ${leads.length} leads found");
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Failed to fetch leads");
    } finally {
      isLoading(false);
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
