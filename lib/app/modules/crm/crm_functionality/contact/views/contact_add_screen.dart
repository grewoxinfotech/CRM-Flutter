import 'package:crm_flutter/app/care/utils/validation.dart';
import 'package:crm_flutter/app/data/network/crm/contact/medel/contact_medel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/network/system/country/controller/country_controller.dart';
import '../../../../../data/network/system/country/model/country_model.dart';
import '../../../../../widgets/button/crm_back_button.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/indicators/crm_loading_circle.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../controller/contact_controller.dart';

class ContactAddScreen extends StatelessWidget {
  ContactModel? contactModel;
  final bool isFromEdit;

  ContactAddScreen({super.key, this.contactModel, this.isFromEdit = false});

  // ✅ Form key for validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ContactController>(() => ContactController());
    final ContactController contactController = Get.find();
    Get.lazyPut(() => CountryController());
    final CountryController countryController = Get.find();

    if (isFromEdit && contactModel != null) {
      // Pre-fill form fields with existing contact data
      contactController.firstName.text = contactModel?.firstName ?? '';
      contactController.lastName.text = contactModel?.lastName ?? '';
      contactController.email.text = contactModel?.email ?? '';
      contactController.phone.text = contactModel?.phone ?? '';
      contactController.website.text = contactModel?.website ?? '';
      contactController.address.text = contactModel?.address ?? '';
      contactController.city.text = contactModel?.city ?? '';
      contactController.state.text = contactModel?.state ?? '';
      contactController.country.text = contactModel?.country ?? '';
      contactController.description.text = contactModel?.description ?? '';
      contactController.selectedCompanyId.value = contactModel?.companyId ?? '';
      contactController.selectedSource.value =
          contactModel?.contactSource ?? '';

      // Set selected country code if available
      if (contactModel?.phoneCode != null &&
          countryController.countryModel.isNotEmpty) {
        final matchedCountry = countryController.countryModel.firstWhereOrNull(
          (country) => country.id == contactModel!.phoneCode,
        );
        if (matchedCountry != null) {
          contactController.selectedCountryCode.value = matchedCountry;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: const CrmBackButton(),
        title: Text(isFromEdit ? "Edit Contact" : "Create Contact"),
      ),
      body: Obx(
        () =>
            (contactController.isLoading.value)
                ? const CrmLoadingCircle()
                : SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Form(
                    key: _formKey, // ✅ Wrap inside Form
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CrmTextField(
                                isRequired: true,
                                title: "First Name",
                                hintText: "Enter First Name",
                                controller: contactController.firstName,
                                validator:
                                    (val) =>
                                        val == null || val.isEmpty
                                            ? "Required"
                                            : null,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CrmTextField(
                                title: "Last Name",
                                hintText: "Enter Last Name",
                                isRequired: true,
                                controller: contactController.lastName,
                                validator:
                                    (val) =>
                                        val == null || val.isEmpty
                                            ? "Required"
                                            : null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CrmTextField(
                          title: "Email",
                          hintText: "Enter Email",
                          isRequired: true,
                          controller: contactController.email,
                          validator: (email) => emailValidation(email),
                        ),
                        const SizedBox(height: 10),

                        // CrmTextField(
                        //   title: "Phone Number",
                        //   isRequired: true,
                        //   controller: contactController.phone,
                        //   validator: (phone) => phoneValidation(phone),
                        // ),
                        Row(
                          children: [
                            Obx(
                              () => Expanded(
                                flex: 2, // smaller space for dropdown
                                child: CrmDropdownField<CountryModel>(
                                  title: 'Code',
                                  isRequired: true,
                                  value:
                                      contactController
                                          .selectedCountryCode
                                          .value,
                                  items:
                                      countryController.countryModel
                                          .map(
                                            (country) =>
                                                DropdownMenuItem<CountryModel>(
                                                  value: country,
                                                  child: Text(
                                                    country.phoneCode,
                                                  ),
                                                ),
                                          )
                                          .toList(),
                                  onChanged: (value) {
                                    contactController
                                        .selectedCountryCode
                                        .value = value;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 5,
                              child: CrmTextField(
                                controller: contactController.phone,
                                title: 'Contact',
                                hintText: 'Enter Contact',
                                isRequired: true,
                                keyboardType: TextInputType.phone,
                                validator: (value) => phoneValidation(value),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        CrmTextField(
                          title: "Website",
                          controller: contactController.website,
                          validator: (value) => urlValidation(value),
                          hintText: "Enter website URL",
                        ),
                        const SizedBox(height: 10),

                        // CrmTextField(
                        //   title: "Company Name",
                        //   controller: contactController.companyName,
                        // ),
                        Obx(
                          () => CrmDropdownField<String>(
                            title: "Company Name",
                            hintText: "Select company",
                            value: contactController.selectedCompanyId.value,
                            items:
                                contactController.companies.map((company) {
                                  return DropdownMenuItem(
                                    value: company.id,
                                    child: Text(company.companyName ?? ''),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                contactController.selectedCompanyId.value =
                                    value;

                                // Check selected contact
                                final selectedContact = contactController
                                    .contacts
                                    .firstWhereOrNull(
                                      (c) =>
                                          c.id ==
                                          contactController
                                              .selectedCompanyId
                                              .value,
                                    );
                                // If selected contact's company is different, clear contact
                                if (selectedContact != null &&
                                    selectedContact.companyId != value) {
                                  contactController.selectedCompanyId.value =
                                      '';
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        // CrmTextField(
                        //   title: "Company Source",
                        //   controller: contactController.contactSource,
                        // ),

                        // Source
                        Obx(
                          () => CrmDropdownField<String>(
                            title: "Source",
                            value: contactController.selectedSource.value,
                            items:
                                contactController.sourceOptions.isEmpty
                                    ? [
                                      DropdownMenuItem(
                                        value: '',
                                        child: Text('No sources available'),
                                      ),
                                    ]
                                    : contactController.sourceOptions.map((
                                      source,
                                    ) {
                                      return DropdownMenuItem(
                                        value: source['id'],
                                        child: Text(source['name'] ?? ''),
                                      );
                                    }).toList(),
                            onChanged:
                                contactController.sourceOptions.isEmpty
                                    ? (_) {}
                                    : (value) {
                                      if (value != null) {
                                        contactController.selectedSource.value =
                                            value;
                                      }
                                    },
                            hintText: "Select source",
                          ),
                        ),
                        const SizedBox(height: 10),
                        CrmTextField(
                          title: "Address",
                          controller: contactController.address,
                          hintText: "Enter address",
                          maxLines: 2,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: CrmTextField(
                                title: "City",
                                controller: contactController.city,
                                hintText: "Enter City",
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CrmTextField(
                                title: "State",
                                controller: contactController.state,
                                hintText: "Enter State",
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        CrmTextField(
                          title: "Country",
                          controller: contactController.country,
                          hintText: "Enter Country",
                        ),
                        const SizedBox(height: 10),
                        CrmTextField(
                          title: "Description",
                          controller: contactController.description,
                          hintText: "Enter Description",
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () =>
                              (contactController.isLoading.value)
                                  ? const SizedBox()
                                  : CrmButton(
                                    width: Get.width - 30,
                                    title:
                                        isFromEdit
                                            ? "Edit Contact"
                                            : "Add Contact",
                                    onTap: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        isFromEdit
                                            ? contactController.editContact(
                                              contactModel!.id!,
                                            )
                                            : contactController.createContact();
                                      }
                                    },
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
