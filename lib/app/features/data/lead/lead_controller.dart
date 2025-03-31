import 'package:crm_flutter/app/features/data/lead/lead_model.dart';
import 'package:crm_flutter/app/features/data/lead/lead_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeadController extends GetxController {
  var isLoading = true.obs;
  var leadsList = <LeadModel>[].obs;
  final LeadService leadService = LeadService();

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
      print("Leads fetched successfully: ${leads.length} leads found"); // Improved log
    } catch (e) {
      print("Error: $e");  // Debugging the error
      Get.snackbar("Error", "Failed to fetch leads");
    } finally {
      isLoading(false);
    }
  }
}
