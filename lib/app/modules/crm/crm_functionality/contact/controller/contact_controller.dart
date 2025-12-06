
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/pagination/controller/pagination_controller.dart';
import 'package:crm_flutter/app/data/database/storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/url_res.dart';
import '../../../../../data/network/crm/contact/medel/contact_medel.dart';
import '../../../../../data/network/crm/contact/services/contact_services.dart';
import '../../../../../data/network/crm/company/model/company_model.dart';
import '../../../../../data/network/crm/company/service/company_service.dart';
import '../../../../../data/network/system/country/model/country_model.dart';
import '../../../../../data/network/system/country/controller/country_controller.dart';
import '../../../../../data/network/crm/crm_system/label/controller/label_controller.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';

class ContactController extends PaginatedController<ContactData> {
  final ContactService _service = ContactService();
  final CompanyService _companyService = CompanyService();

  var errorMessage = ''.obs;
  var companies = <CompanyData>[].obs;
  // var contacts = <ContactData>[].obs;

  final formKey = GlobalKey<FormState>();

  // Form fields
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController contactOwner = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController website = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController description = TextEditingController();

  // Controllers
  final LabelController labelController = Get.put(LabelController());
  final countryController = Get.put(CountryController());

  // Reactive selections
  RxString selectedCompanyId = ''.obs;
  RxString selectedSource = ''.obs;
  Rxn<CountryModel> selectedCountryCode = Rxn<CountryModel>();

  @override
  void onInit() {
    super.onInit();
    loadInitial();
    fetchCompanies();
  }

  void resetForm() {
    firstName.clear();
    lastName.clear();
    contactOwner.clear();
    email.clear();
    phone.clear();
    website.clear();
    address.clear();
    city.clear();
    state.clear();
    country.clear();
    description.clear();

    selectedCompanyId.value = companies.isNotEmpty ? companies.first.id! : '';
    selectedSource.value =
        sourceOptions.isNotEmpty ? sourceOptions.first['id']! : '';
    selectedCountryCode.value =
        countryController.countryModel.isNotEmpty
            ? countryController.countryModel.firstWhereOrNull(
              (element) => element.countryName.toLowerCase() == 'india',
            )
            : null;
  }

  List<Map<String, String>> get sourceOptions {
    try {
      final sources = labelController.getSources();
      return sources
          .map((label) => {'id': label.id, 'name': label.name})
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> fetchCompanies() async {
    try {
      final fetchedCompanies = await _companyService.fetchCompanies();
      companies.assignAll(fetchedCompanies?.message?.data?.toList() ?? []);
    } catch (e) {
      print("Error fetching companies: $e");
    }
  }

  /// Fetch paginated contacts
  @override
  Future<List<ContactData>> fetchItems(int page) async {
    try {
      final response = await _service.fetchContacts(page: page);
      print("Response: ${response?.toJson()}");
      if (response != null) {
        totalPages.value = response.message?.pagination?.totalPages ?? 1;
        return response.message?.data ?? [];
      } else {
        errorMessage.value = "Failed to fetch contacts";
        return [];
      }
    } catch (e) {
      errorMessage.value = "Exception in fetchItems: $e";
      return [];
    }
  }

  /// Get contact by ID
  Future<ContactData?> getContactById(String id) async {
    try {
      final existing = items.firstWhereOrNull((c) => c.id == id);
      if (existing != null) return existing;

      final fetched = await _service.getContactById(id);
      if (fetched != null) items.add(fetched);
      return fetched;
    } catch (e) {
      print("Get contact error: $e");
      return null;
    }
  }

  /// Get company name by ID
  String? getCompanyNameById(String? companyId) {
    if (companyId == null) return null;
    return companies.firstWhereOrNull((c) => c.id == companyId)?.companyName;
  }

  List<ContactData> getContactsByCompanyId(String companyId) {
    return items
        .where(
          (contact) => (contact.companyId ?? '').trim() == companyId.trim(),
        )
        .toList();
  }

  /// Create contact
  Future<void> createContact() async {
    try {
      final user = await SecureStorage.getUserData();
      final userId = user?.id;
      // Create the contact model from form fields
      final newContact = ContactData(
        address: address.text.trim().isNotEmpty ? address.text.trim() : null,
        city: city.text.trim().isNotEmpty ? city.text.trim() : null,
        clientId: userId ?? '',
        companyId:
            selectedCompanyId.value.isNotEmpty ? selectedCompanyId.value : null,
        contactOwner: userId ?? '',
        contactSource:
            selectedSource.value.trim().isNotEmpty
                ? selectedSource.value.trim()
                : null,
        country: country.text.trim().isNotEmpty ? country.text.trim() : null,
        description:
            description.text.trim().isNotEmpty ? description.text.trim() : null,
        email: email.text.trim().isNotEmpty ? email.text.trim() : null,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        phone: phone.text.trim().isNotEmpty ? phone.text.trim() : null,
        phoneCode: selectedCountryCode.value?.id,
        state: state.text.trim().isNotEmpty ? state.text.trim() : null,
        website: website.text.trim().isNotEmpty ? website.text.trim() : null,
      );

      isLoading.value = true;

      // Call the updated addContact() which returns a boolean
      final success = await _service.addContact(newContact);

      if (success != null) {
        await loadInitial(); // Refresh the list
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Contact created successfully',
          contentType: ContentType.success,
        );
        Get.back(); // Return to previous screen
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to create contact',
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'An unexpected error occurred: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> editContact(String id) async {
    try {
      final user = await SecureStorage.getUserData();
      final userId = user?.id ?? '';

      // ✅ Build updated contact from form fields
      final updatedContact = ContactData(
        clientId: userId,
        contactOwner: userId,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        email: email.text.trim().isNotEmpty ? email.text.trim() : null,
        phone: phone.text.trim().isNotEmpty ? phone.text.trim() : null,
        phoneCode: selectedCountryCode.value?.id,
        website: website.text.trim().isNotEmpty ? website.text.trim() : null,
        address: address.text.trim().isNotEmpty ? address.text.trim() : null,
        city: city.text.trim().isNotEmpty ? city.text.trim() : null,
        state: state.text.trim().isNotEmpty ? state.text.trim() : null,
        country: country.text.trim().isNotEmpty ? country.text.trim() : null,
        description:
            description.text.trim().isNotEmpty ? description.text.trim() : null,
        companyId:
            selectedCompanyId.value.isNotEmpty ? selectedCompanyId.value : null,
        contactSource:
            selectedSource.value.isNotEmpty ? selectedSource.value : null,
      );

      isLoading.value = true;

      final success = await _service.updateContact(id, updatedContact);

      if (success) {
        final index = items.indexWhere((c) => c.id == id);
        if (index != -1) {
          items[index] = updatedContact;
          // ✅ keep the same id since you're editing an existing one
        }
        Get.back();
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Contact updated successfully',
          contentType: ContentType.success,
        );
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to update contact',
          contentType: ContentType.failure, // ✅ should be failure
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to update contact: ${e.toString()}',
        contentType: ContentType.failure, // ✅ should be failure
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete contact
  Future<bool> deleteContact(String id) async {
    try {
      final success = await _service.deleteContact(id);
      if (success) items.removeWhere((c) => c.id == id);
      return success;
    } catch (e) {
      print("Delete contact error: $e");
      return false;
    }
  }
}
