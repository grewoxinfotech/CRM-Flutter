import 'package:get/get.dart';
import 'package:crm_flutter/app/features/data/deal/deal_model.dart';
import 'package:crm_flutter/app/features/data/deal/deal_service.dart';

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
      print("Deals fetched successfully: ${deals.length} deals found");
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Failed to fetch deals");
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteDeal(String dealId) async {
    try {
      bool success = await dealService.deleteDeal(dealId);
      if (success) {
        dealsList.removeWhere((deal) => deal.id == dealId);
        Get.back();
        Get.snackbar("Success", "Deal deleted successfully");
        return true;
      } else {
        Get.snackbar("Error", "Failed to delete deal");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      return false;
    }
  }
}
