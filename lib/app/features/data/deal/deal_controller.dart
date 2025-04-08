import 'package:crm_flutter/app/features/data/deal/deal_model.dart';
import 'package:crm_flutter/app/features/data/deal/deal_service.dart';
import 'package:crm_flutter/app/features/data/lead/lead_home/lead_model.dart';
import 'package:crm_flutter/app/features/data/lead/lead_home/lead_service.dart';
import 'package:get/get.dart';

class DealController extends GetxController {
  var isLoading = true.obs;
  var dealsList = <DealModel>[].obs;
  final DealService dealService = DealService();

  var deal = DealModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchDeals();
  }

  void fetchDeals() async {
    try {
      isLoading(true);
      var deals = await dealService.fetchDeals();
      dealsList.assignAll(deals);
      print("object");
      print("Deals fetched successfully: ${deals.length} deals found");
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Failed to fetch deals");
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
