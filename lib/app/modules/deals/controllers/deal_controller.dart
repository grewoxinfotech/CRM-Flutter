import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/url_res.dart';
import 'package:crm_flutter/app/data/models/deal_model.dart';
import 'package:crm_flutter/app/data/service/deal_service.dart';
import 'package:crm_flutter/app/data/service/secure_storage_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DealController extends GetxController {
  final RxBool isLoading = false.obs;
  final List<DealModel> dealsList = <DealModel>[].obs;
  final DealService dealService = DealService();

  final TextEditingController dealTitle = TextEditingController();
  final TextEditingController dealValue = TextEditingController();
  final TextEditingController pipeline = TextEditingController();
  final TextEditingController stage = TextEditingController();
  final TextEditingController closeDate = TextEditingController();
  final TextEditingController source = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController products = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchDeals();
  }

  Future<void> addDeal(/*Map<String, dynamic> dealData*/) async {
    isLoading(true);

    final String url = UrlRes.Deals;
    final String token =
        SecureStorage.getToken()
            .toString(); // Replace with secure storage or GetStorage token
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "leadTitle": "Sales Opportunity for New Project",
          "dealName": "Acddme Corp Website Redesign",
          "pipeline": "Sales",
          "stage": "Proposal",
          "price": 10000,
          "currency": "USD",
          "closedDate": "2025-01-31",
          "category": "Website Development",
          "project": "Acme Corp Website",
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        // Handle response data if needed
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Failed",
          message: response.statusCode.toString(),
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: e.toString(),
        contentType: ContentType.failure,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchDeals() async {
    isLoading(true);
    try {
      final deals = await dealService.fetchDeals();
      dealsList.assignAll(deals);
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to lead deals",
        contentType: ContentType.failure,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<bool> deleteDeal(String dealId) async {
    isLoading(true);
    try {
      bool success = await dealService.deleteDeal(dealId);
      if (success) {
        dealsList.removeWhere((deal) => deal.id == dealId);
        Get.back();
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Deal deleted successfully",
          contentType: ContentType.success,
        );
        return true;
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to delete deal",
          contentType: ContentType.failure,
        );
        return false;
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Something went wrong",
        contentType: ContentType.failure,
      );
      return false;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    isLoading(false);
    dealService.dispose();
    dealTitle.dispose();
    dealValue.dispose();
    pipeline.dispose();
    stage.dispose();
    closeDate.dispose();
    source.dispose();
    status.dispose();
    products.dispose();
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phoneNumber.dispose();
    companyName.dispose();
    address.dispose();
    super.onClose();
  }
}
