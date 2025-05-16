import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/data/network/all/crm/deal/service/deal_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DealController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<DealModel> deal = <DealModel>[].obs;
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
    getDeals();
  }

  /// 1. Get all deal with loading state management
  Future<List> getDeals() async {
    final data = await dealService.getDeals();
    deal.assignAll(data.map((e)=> DealModel.fromJson(e)).toList());
    return data;
  }

  /// 2. Create a new deal
  Future<bool> addDeal() async {
    try {
      // Prepare the data
      Map<String, dynamic> newDeal = {
        "deal_title": dealTitle.text,
        "deal_value": dealValue.text,
        "pipeline": pipeline.text,
        "stage": stage.text,
        "close_date": closeDate.text,
        "source": source.text,
        "status": status.text,
        "products": products.text,
        "first_name": firstName.text,
        "last_name": lastName.text,
        "email": email.text,
        "phone_number": phoneNumber.text,
        "company_name": companyName.text,
        "address": address.text,
      };

      final response = await dealService.createDeal(newDeal);
      if (response.statusCode == 200) {
        await getDeals(); // Refresh list after adding deal
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error adding deal: $e");
      return false;
    }
  }

  /// 3. Update an existing deal by ID
  Future<bool> editDeal(String id) async {
    try {
      // Prepare the data for update
      Map<String, dynamic> updatedDeal = {
        "deal_title": dealTitle.text,
        "deal_value": dealValue.text,
        "pipeline": pipeline.text,
        "stage": stage.text,
        "close_date": closeDate.text,
        "source": source.text,
        "status": status.text,
        "products": products.text,
        "first_name": firstName.text,
        "last_name": lastName.text,
        "email": email.text,
        "phone_number": phoneNumber.text,
        "company_name": companyName.text,
        "address": address.text,
      };

      final response = await dealService.updateDeal(id, updatedDeal);
      if (response.statusCode == 200) {
        await getDeals(); // Refresh list after updating deal
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error editing deal: $e");
      return false;
    }
  }

  /// 4. Delete deal by ID
  Future<bool> deleteDeal(String id) async {
    try {
      bool isDelete = await dealService.deleteDeal(id);
      if (isDelete) {
        await getDeals(); // Refresh list after deletion
        return true;
      }
      return false;
    } catch (e) {
      print("Error deleting deal: $e");
      return false;
    }
  }

  @override
  void onClose() {
    // Dispose controllers
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
