import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/pagination/controller/pagination_controller.dart';
import '../../../../../data/network/crm/company/model/company_model.dart';
import '../../../../../data/network/crm/company/service/company_service.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';

class CompanyController extends PaginatedController<CompanyData> {
  final CompanyService _service = CompanyService();

  // RxList<CompanyData> companies = <CompanyData>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final TextEditingController companyName = TextEditingController();
  final TextEditingController industry = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController website = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }



  @override
  Future<List<CompanyData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchCompanies(page: page);
      print("Response: ${response!.toJson()}");
      if (response != null && response.success == true) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch revenues";
        return [];
      }
    } catch (e) {
      errorMessage.value = "Exception in fetchItems: $e";
      return [];
    }
  }

  Future<CompanyData?> getCompanyById(String id) async {
    try {
      final companyModel = await _service.getCompanyById(id);
      print("[DEBUG]=>:${companyModel}");
      return companyModel;
    } catch (e) {
      errorMessage.value = 'Failed to fetch company: ${e.toString()}';
      return null;
    }
  }


}
