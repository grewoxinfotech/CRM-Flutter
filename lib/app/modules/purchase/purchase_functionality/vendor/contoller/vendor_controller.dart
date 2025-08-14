import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/purchase/vendor/model/vendor_model.dart';
import 'package:crm_flutter/app/data/network/purchase/vendor/service/vendor_service.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../care/constants/url_res.dart';
import '../../../../../care/pagination/controller/pagination_controller.dart';

class VendorController extends PaginatedController<VendorData> {
  final VendorService _service = VendorService();
  var isLoading = false.obs;

  // Form controllers
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final phoneCodeController = TextEditingController();
  final clientIdController = TextEditingController();
  final taxNumberController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final zipCodeController = TextEditingController();

  // Dropdown / selection
  String? selectedClientId;

  static Future<Map<String, String>> headers() async => await UrlRes.getHeaders();

  @override
  Future<List<VendorData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchVendors(page: page);
      if (response != null) {
        totalPages.value = response.pagination?.totalPages ?? 1;
        return response.data ?? [];
      } else {
        return [];
      }
    } catch (e) {
      print("Fetch vendor items error: $e");
      return [];
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadInitial();
  }

  @override
  void onClose() {
    nameController.dispose();
    contactController.dispose();
    emailController.dispose();
    phoneCodeController.dispose();
    clientIdController.dispose();
    taxNumberController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    zipCodeController.dispose();
    super.onClose();
  }

  Future<void> refreshVendors() async {
    try {
      isLoading.value = true;
      final fetchedItems = await fetchItems(1);
      items.assignAll(fetchedItems);
    } catch (e) {
      print("Refresh vendors error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  Future<void> submitVendor() async {
    if (!formKey.currentState!.validate()) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Validation Error",
        message: "Please fill all required fields",
        contentType: ContentType.warning,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Only assign non-empty values
      final vendor = VendorData(
        name: nameController.text.trim(),
        contact: contactController.text.trim(),
        email: emailController.text.trim().isNotEmpty ? emailController.text.trim() : null,
        phonecode: phoneCodeController.text.trim().isNotEmpty ? phoneCodeController.text.trim() : null,
        taxNumber: taxNumberController.text.trim().isNotEmpty ? taxNumberController.text.trim() : null,
        address: addressController.text.trim().isNotEmpty ? addressController.text.trim() : null,
        city: cityController.text.trim().isNotEmpty ? cityController.text.trim() : null,
        state: stateController.text.trim().isNotEmpty ? stateController.text.trim() : null,
        country: countryController.text.trim().isNotEmpty ? countryController.text.trim() : null,
        zipcode: zipCodeController.text.trim().isNotEmpty ? zipCodeController.text.trim() : null,
      );

      final success = await _service.createVendor(vendor);



      if (success) {
        await refreshVendors();
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Vendor added successfully",
          contentType: ContentType.success,
        );
        Get.back(result: true);
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: "Error",
          message: "Failed to add vendor. Please try again.",
          contentType: ContentType.failure,
        );
      }
    } catch (e) {

      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "An unexpected error occurred: ${e.toString()}",
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }


  // Update vendor
  Future<bool> updateVendor(String id, VendorData updatedVendor) async {
    try {
      final success = await _service.updateVendor(id, updatedVendor);
      if (success) {
        final index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedVendor;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to update vendor: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  // Delete vendor
  Future<bool> deleteVendor(String id) async {
    try {
      final success = await _service.deleteVendor(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to delete vendor: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return false;
    }
  }
}
