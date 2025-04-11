import 'dart:convert';

import 'package:crm_flutter/app/features/data/deal/deal_model.dart';
import 'package:crm_flutter/app/features/data/deal/deal_service.dart';
import 'package:crm_flutter/app/features/resources/url_resources.dart';
import 'package:crm_flutter/app/services/secure_storage_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DealController extends GetxController {
  final RxBool isLoading = false.obs;
  final List<DealModel> dealsList = <DealModel>[].obs;
  final DealService dealService = DealService();

  @override
  void onInit() {
    super.onInit();
    fetchDeals();
  }

  Future<void> addDeal(/*Map<String, dynamic> dealData*/) async {
    print("press : Add Deal Button");
    isLoading(true);

    final String url = UrlRes.Deal_Add;
    final String token =
        SecureStorage.getToken()
            .toString(); // Replace with secure storage or GetStorage token
    print("URL : " + url);
    print("Token : " + token);
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
            {
              "leadTitle": "Sales Opportunity for New Project",
              "dealName": "Acddme Corp Website Redesign",
              "pipeline": "Sales",
              "stage": "Proposal",
              "price": 10000,
              "currency": "USD",
              "closedDate": "2025-01-31",
              "category": "Website Development",
              "project": "Acme Corp Website"
            }
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Deal added successfully");
        final responseData = jsonDecode(response.body);
        // Handle response data if needed
      } else {
        print("Failed to add deal: ${response.statusCode}");
        print(response.body);
      }

      isLoading(false);
    } catch (e) {
      print("Error while adding deal: $e");
      isLoading(false);
    }
    isLoading(false);
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
