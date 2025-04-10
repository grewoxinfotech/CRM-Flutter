import 'package:crm_flutter/app/features/data/deal/deal_model.dart';
import 'package:crm_flutter/app/features/data/deal/deal_service.dart';
import 'package:get/get.dart';

class DealController extends GetxController {
  final RxBool isLoading = false.obs;
  final List<DealModel> dealsList = <DealModel>[].obs;
  final DealService dealService = DealService();

  @override
  void onInit() {
    super.onInit();
    fetchDeals();
  }

  Future<void> fetchDeals() async {
    isLoading(true);
    try {
      final deals = await dealService.fetchDeals();
      dealsList.assignAll(deals);
      print("Deals fetched successfully: ${deals.length} deals found");
      isLoading(false);
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "Failed to lead deals");
      isLoading(false);
    }
    isLoading(false);
  }

  Future<bool> deleteDeal(String dealId) async {
    isLoading(true);
    try {
      bool success = await dealService.deleteDeal(dealId);
      if (success) {
        dealsList.removeWhere((deal) => deal.id == dealId);
        Get.back();
        Get.snackbar("Success", "Deal deleted successfully");
        isLoading(false);
        return true;
      } else {
        Get.snackbar("Error", "Failed to delete deal");
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
    dealService.dispose();
    super.onClose();
  }
}
