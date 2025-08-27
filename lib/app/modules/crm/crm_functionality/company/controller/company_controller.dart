import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/network/crm/company/model/company_model.dart';
import '../../../../../data/network/crm/company/service/company_service.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';

class CompanyController extends GetxController {
  final CompanyService _service = CompanyService();

  RxList<Data> companies = <Data>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;

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
    fetchCompanies();
  }

  Future<void> refreshData() async {
    try {
      isLoading.value = true;
      await fetchCompanies();
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to refresh data: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCompanies() async {
    try {
      isLoading.value = true;
      final result = await _service.getAllCompanies();
      companies.value = result;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to load companies: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<Data?> getCompanyById(String id) async {
    try {
      final companyModel = await _service.getCompanyById(id);
      print("[DEBUG]=>:${companyModel}");
      return companyModel;
    } catch (e) {
      error.value = 'Failed to fetch company: ${e.toString()}';
      return null;
    }
  }

  // Future<void> createCompany() async {
  //   try {
  //     final newCompany = Data(
  //       companyName: companyName.text.trim(),
  //       industry: industry.text.trim(),
  //       phone: phone.text.trim(),
  //       email: email.text.trim(),
  //       website: website.text.trim(),
  //       address: address.text.trim(),
  //       city: city.text.trim(),
  //       state: state.text.trim(),
  //       country: country.text.trim(),
  //       description: description.text.trim(),
  //     );
  //
  //     isLoading.value = true;
  //
  //     final success = await _service.createCompany(newCompany);
  //
  //     if (success) {
  //       await fetchCompanies();
  //       CrmSnackBar.showAwesomeSnackbar(
  //         title: 'Success',
  //         message: 'Company created successfully',
  //         contentType: ContentType.success,
  //       );
  //       Get.back();
  //     } else {
  //       CrmSnackBar.showAwesomeSnackbar(
  //         title: 'Error',
  //         message: 'Failed to create company',
  //         contentType: ContentType.failure,
  //       );
  //     }
  //   } catch (e) {
  //     CrmSnackBar.showAwesomeSnackbar(
  //       title: 'Error',
  //       message: 'Error creating company: ${e.toString()}',
  //       contentType: ContentType.failure,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Future<void> updateCompany(String id, Data updatedCompany) async {
  //   try {
  //     isLoading.value = true;
  //     final success = await _service.updateCompany(id, updatedCompany);
  //     if (success) {
  //       final index = companies.indexWhere((c) => c.id == id);
  //       if (index != -1) companies[index] = updatedCompany;
  //
  //       CrmSnackBar.showAwesomeSnackbar(
  //         title: 'Success',
  //         message: 'Company updated successfully',
  //         contentType: ContentType.success,
  //       );
  //     } else {
  //       CrmSnackBar.showAwesomeSnackbar(
  //         title: 'Error',
  //         message: 'Failed to update company',
  //         contentType: ContentType.failure,
  //       );
  //     }
  //   } catch (e) {
  //     CrmSnackBar.showAwesomeSnackbar(
  //       title: 'Error',
  //       message: 'Error updating company: ${e.toString()}',
  //       contentType: ContentType.failure,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Future<void> deleteCompany(String id) async {
  //   try {
  //     isLoading.value = true;
  //     final success = await _service.deleteCompany(id);
  //     if (success) {
  //       companies.removeWhere((c) => c.id == id);
  //       CrmSnackBar.showAwesomeSnackbar(
  //         title: 'Success',
  //         message: 'Company deleted successfully',
  //         contentType: ContentType.success,
  //       );
  //     } else {
  //       CrmSnackBar.showAwesomeSnackbar(
  //         title: 'Error',
  //         message: 'Failed to delete company',
  //         contentType: ContentType.failure,
  //       );
  //     }
  //   } catch (e) {
  //     CrmSnackBar.showAwesomeSnackbar(
  //       title: 'Error',
  //       message: 'Error deleting company: ${e.toString()}',
  //       contentType: ContentType.failure,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
