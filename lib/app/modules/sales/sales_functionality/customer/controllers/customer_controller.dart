import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/url_res.dart';
import '../../../../../data/network/sales/customer/model/customer_model.dart';
import '../../../../../data/network/sales/customer/service/customer_service.dart';
import '../../../../../data/network/system/country/controller/country_controller.dart';
import '../../../../../data/network/system/country/model/country_model.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../../../../../care/utils/validation.dart';

class CustomerController extends PaginatedController<CustomerData> {
  final CustomerService _service = CustomerService();
  final String url = UrlRes.customers;
  var errorMessage = ''.obs;

  /// Text controllers (Form Fields)
  final customerNumberController = TextEditingController();
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final taxNumberController = TextEditingController();
  final alternateNumberController = TextEditingController();
  final textNumberController = TextEditingController();
  final companyController = TextEditingController();
  final phoneCodeController = TextEditingController();
  final notesController = TextEditingController();

  // Billing
  final billingStreetController = TextEditingController();
  final billingCityController = TextEditingController();
  final billingStateController = TextEditingController();
  final billingCountryController = TextEditingController();
  final billingPostalController = TextEditingController();

  // Shipping
  final shippingStreetController = TextEditingController();
  final shippingCityController = TextEditingController();
  final shippingStateController = TextEditingController();
  final shippingCountryController = TextEditingController();
  final shippingPostalController = TextEditingController();

  // --- Form State ---
  final formKey = GlobalKey<FormState>();
  var sameAsBilling = false.obs;
  var isLoading = false.obs;

  // --- Country ---
  Rxn<CountryModel> selectedCountryCode = Rxn();
  RxList<CountryModel> countryCodes = <CountryModel>[].obs;
  final CountryController countryController = Get.put(CountryController());

  static Future<Map<String, String>> headers() async {
    return await UrlRes.getHeaders();
  }

  @override
  Future<List<CustomerData>> fetchItems(int page) async {


    try {
      final response = await _service.fetchCustomers(page: page);
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

  @override
  void onInit() {
    super.onInit();
    loadInitial();
    loadCountries();
  }

  // -----------------------------
  // 🔹 Country Helpers
  // -----------------------------
  Future<void> loadCountries() async {
    await countryController.getCountries();
    countryCodes.assignAll(countryController.countryModel);
    if (countryCodes.isNotEmpty) {
      selectedCountryCode.value = countryCodes.firstWhereOrNull(
        (element) => (element.countryName).toLowerCase() == "india",
      );
    }
  }

  Future<CountryModel> getCountryById(String id) async {
    try {
      final existingCountry = countryCodes.firstWhereOrNull(
        (item) => item.id == id,
      );
      if (existingCountry != null) {
        return existingCountry;
      } else {
        final country = await countryController.getCountryById(id);
        if (country != null) {
          countryCodes.add(country);
        }
        return country!;
      }
    } catch (e) {
      print("Create customer error: $e");
      return CountryModel(
        id: "",
        countryName: "",
        countryCode: "",
        phoneCode: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
  }

  // -----------------------------
  // 🔹 Customer Helpers
  // -----------------------------
  Future<CustomerData?> getCustomerById(String id) async {
    try {
      final existingCustomer = items.firstWhereOrNull((item) => item.id == id);
      if (existingCustomer != null) {
        return existingCustomer;
      } else {
        final customer = await _service.getCustomerById(id);
        if (customer != null) {
          items.refresh();
        }
      }
    } catch (e) {
      print("Create customer error: $e");
    }
  }

  // -----------------------------
  // 🔹 CRUD METHODS
  // -----------------------------
  Future<bool> createCustomer(CustomerData customer) async {
    try {
      final success = await _service.createCustomer(customer);
      if (success) {
        await loadInitial();
      }
      return success;
    } catch (e) {
      print("Create customer error: $e");
      return false;
    }
  }

  Future<bool> updateCustomer(String id, CustomerData updatedCustomer) async {
    try {
      final success = await _service.updateCustomer(id, updatedCustomer);
      if (success) {
        int index = items.indexWhere((item) => item.id == id);
        if (index != -1) {
          items[index] = updatedCustomer;
          items.refresh();
        }
      }
      return success;
    } catch (e) {
      print("Update customer error: $e");
      return false;
    }
  }

  Future<bool> deleteCustomer(String id) async {
    try {
      final success = await _service.deleteCustomer(id);
      if (success) {
        items.removeWhere((item) => item.id == id);
      }
      return success;
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to delete debit note: ${e.toString()}",
        contentType: ContentType.failure,
      );
      return false;
    }
  }

  // -----------------------------
  // 🔹 FORM METHODS
  // -----------------------------
  String? requiredFieldValidator(
    String? value, {
    String fieldName = "This field",
  }) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  CustomerData _buildCustomer({String? id}) {
    return CustomerData(
      id: id,
      name: nameController.text.trim(),
      contact: contactController.text.trim(),
      email: emailController.text.trim(),
      taxNumber: taxNumberController.text.trim(),
      phonecode: selectedCountryCode.value?.id.toString(),
      billingAddress: Address(
        street: billingStreetController.text.trim(),
        city: billingCityController.text.trim(),
        state: billingStateController.text.trim(),
        country: billingCountryController.text.trim(),
        postalCode: billingPostalController.text.trim(),
      ),
      shippingAddress: Address(
        street: shippingStreetController.text.trim(),
        city: shippingCityController.text.trim(),
        state: shippingStateController.text.trim(),
        country: shippingCountryController.text.trim(),
        postalCode: shippingPostalController.text.trim(),
      ),
      notes: notesController.text.trim(),
    );
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final customer = _buildCustomer();
    bool success = await createCustomer(customer);

    isLoading.value = false;

    if (success) {
      Get.back();

      CrmSnackBar.showAwesomeSnackbar(
        title: "Success",
        message: "Customer added successfully",
        contentType: ContentType.success,
      );
    } else {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to add customer",
        contentType: ContentType.failure,
      );
    }
  }

  Future<void> edit(String id) async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    final customer = _buildCustomer(id: id);
    bool success = await updateCustomer(id, customer);

    isLoading.value = false;

    if (success) {
      Get.back();
      Get.back();
      CrmSnackBar.showAwesomeSnackbar(
        title: "Success",
        message: "Customer updated successfully",
        contentType: ContentType.success,
      );
    } else {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Failed to update customer",
        contentType: ContentType.failure,
      );
    }
  }

  void initCustomerData(CustomerData? data) {
    if (data == null) return;

    nameController.text = data.name ?? '';
    contactController.text = data.contact ?? '';
    emailController.text = data.email ?? '';
    taxNumberController.text = data.taxNumber ?? '';
    notesController.text = data.notes ?? '';

    billingStreetController.text = data.billingAddress?.street ?? '';
    billingCityController.text = data.billingAddress?.city ?? '';
    billingStateController.text = data.billingAddress?.state ?? '';
    billingCountryController.text = data.billingAddress?.country ?? '';
    billingPostalController.text = data.billingAddress?.postalCode ?? '';

    shippingStreetController.text = data.shippingAddress?.street ?? '';
    shippingCityController.text = data.shippingAddress?.city ?? '';
    shippingStateController.text = data.shippingAddress?.state ?? '';
    shippingCountryController.text = data.shippingAddress?.country ?? '';
    shippingPostalController.text = data.shippingAddress?.postalCode ?? '';

    if (data.phonecode != null) {
      final country = countryController.countryModel.firstWhereOrNull(
        (ct) => ct.id.toString() == data.phonecode,
      );
      if (country != null) {
        selectedCountryCode.value = country;
      }
    }
  }

  @override
  void onClose() {
    customerNumberController.dispose();
    nameController.dispose();
    contactController.dispose();
    emailController.dispose();
    taxNumberController.dispose();
    alternateNumberController.dispose();
    textNumberController.dispose();
    companyController.dispose();
    phoneCodeController.dispose();
    notesController.dispose();
    billingStreetController.dispose();
    billingCityController.dispose();
    billingStateController.dispose();
    billingCountryController.dispose();
    billingPostalController.dispose();
    shippingStreetController.dispose();
    shippingCityController.dispose();
    shippingStateController.dispose();
    shippingCountryController.dispose();
    shippingPostalController.dispose();
    super.onClose();
  }
}
