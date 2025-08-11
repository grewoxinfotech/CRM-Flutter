import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/crm/contact/services/contact_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../data/network/crm/company/model/company_model.dart';
import '../../../../../data/network/crm/company/service/company_service.dart';
import '../../../../../data/network/crm/contact/medel/contact_medel.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';



class ContactController extends GetxController {
  final ContactService _service = ContactService();
  final companyService = CompanyService();

  var contacts = <ContactModel>[].obs;
  var isLoading = false.obs;
  var error = ''.obs;
  var companies = <Data>[].obs;

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController contactOwner = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController website = TextEditingController();
  final TextEditingController companyId = TextEditingController();
  final TextEditingController companyName = TextEditingController();
  final TextEditingController contactSource = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    refreshData();
    fetchContacts();
  }

  Future<void> refreshData() async {
    try {
      isLoading.value = true;
      await fetchContacts();
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

  Future<void> fetchContacts() async {
    isLoading.value = true;
    try {
      // Fetch contacts and companies in parallel
      final results = await Future.wait([
        ContactService().getAllContacts(),
        companyService.getAllCompanies(),
      ]);
      contacts.value = results[0] as List<ContactModel>;
      companies.value = results[1] as List<Data>;
      error.value = '';
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  String? getCompanyNameById(String? companyId) {
    if (companyId == null) return null;
    return companies
        .firstWhereOrNull((company) => company.id == companyId)
        ?.companyName;
  }

  Future<ContactModel?> getContactById(String id) async {
    try {
      final existingContact = contacts.firstWhereOrNull(
        (c) => c.id == id.trim(),
      );
      if (existingContact != null) return existingContact;

      final fetchedContact = await _service.getContactById(id);
      if (fetchedContact != null) {
        contacts.add(fetchedContact);
      }
      return fetchedContact;
    } catch (e) {
      error.value = 'Failed to load contact: ${e.toString()}';
      return null;
    }
  }

  final _company = new CompanyService();

  Future<Data?> getCompanyById(String id) async {
    try {
      return await _company.getCompanyById(id);
    } catch (e) {
      print("[DEBUG] => ${e.toString()}");
    }
  }

  List<ContactModel> getContactsByCompanyId(String companyId) {
    return contacts
        .where(
          (contact) => (contact.companyId ?? '').trim() == companyId.trim(),
        )
        .toList();
  }

  Future<void> createContact() async {
    try {
      // Create the contact model from form fields
      final newContact = ContactModel(
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        contactOwner: contactOwner.toString(),
        email: email.text.trim().isNotEmpty ? email.text.trim() : null,
        phone: phone.text.trim().isNotEmpty ? phone.text.trim() : null,
        website: website.text.trim().isNotEmpty ? website.text.trim() : null,
        companyId:
            companyId.text.trim().isNotEmpty ? companyId.text.trim() : null,
        contactSource:
            contactSource.text.trim().isNotEmpty
                ? contactSource.text.trim()
                : null,
        address: address.text.trim().isNotEmpty ? address.text.trim() : null,
        city: city.text.trim().isNotEmpty ? city.text.trim() : null,
        state: state.text.trim().isNotEmpty ? state.text.trim() : null,
        country: country.text.trim().isNotEmpty ? country.text.trim() : null,
        description:
            description.text.trim().isNotEmpty ? description.text.trim() : null,
      );

      isLoading.value = true;

      // Call the updated addContact() which returns a boolean
      final success = await _service.addContact(newContact);

      if (success) {
        await fetchContacts(); // Refresh the list
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

  Future<void> editContact(String id, ContactModel updatedContact) async {
    try {
      final success = await _service.updateContact(id, updatedContact);
      if (success) {
        final index = contacts.indexWhere((c) => c.id == id);
        if (index != -1) contacts[index] = updatedContact;

        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Contact updated successfully',
          contentType: ContentType.success,
        );
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to update contact',
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to update contact  ${e.toString()}',
        contentType: ContentType.success,
      );
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      final success = await _service.deleteContact(id);
      if (success) {
        contacts.removeWhere((c) => c.id == id);
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Success',
          message: 'Contact deleted successfully',
          contentType: ContentType.success,
        );
      } else {
        CrmSnackBar.showAwesomeSnackbar(
          title: 'Error',
          message: 'Failed to delete contact',
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to delete contact  ${e.toString()}',
        contentType: ContentType.success,
      );
    }
  }
}
