import 'package:crm_flutter/app/care/utils/validation.dart';
import 'package:crm_flutter/app/data/network/sales/customer/model/customer_model.dart';
import 'package:crm_flutter/app/data/network/system/country/model/country_model.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../controllers/customer_controller.dart';

class AddCustomerScreen extends StatelessWidget {
  final CustomerData? customerData;
  final bool isFromEdit;

  AddCustomerScreen({super.key, this.customerData, this.isFromEdit = false});

  final CustomerController controller = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    // Prefill form if editing
    if (isFromEdit && customerData != null) {
      controller.initCustomerData(customerData);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isFromEdit ? 'Edit Customer' : 'Add Customer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: controller.nameController,
                      title: 'Name',
                      isRequired: true,
                      hintText: 'Enter Customer Name',
                      validator:
                          (value) => controller.requiredFieldValidator(
                            value,
                            fieldName: 'Name',
                          ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CrmTextField(
                      controller: controller.taxNumberController,
                      title: 'Tax Number',
                      hintText: 'Enter Tax Number',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Obx(
                    () => Expanded(
                      flex: 2,
                      child: CrmDropdownField<CountryModel>(
                        title: 'Code',
                        isRequired: true,
                        value: controller.selectedCountryCode.value,
                        items:
                            controller.countryCodes
                                .map(
                                  (country) => DropdownMenuItem<CountryModel>(
                                    value: country,
                                    child: Text(country.phoneCode),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          controller.selectedCountryCode.value = value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 5,
                    child: CrmTextField(
                      controller: controller.contactController,
                      title: 'Contact',
                      hintText: 'Enter Contact',
                      isRequired: true,
                      keyboardType: TextInputType.phone,
                      validator: (value) => phoneValidation(value),
                    ),
                  ),
                ],
              ),
              CrmTextField(
                controller: controller.emailController,
                title: 'Email',
                hintText: 'Enter Email',
                isRequired: true,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => emailValidation(value),
              ),
              const SizedBox(height: 16),
              const Text(
                "Billing Address",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CrmTextField(
                controller: controller.billingStreetController,
                title: 'Street',
                hintText: 'Enter Street',
              ),
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: controller.billingCityController,
                      title: 'City',
                      hintText: 'Enter City',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CrmTextField(
                      controller: controller.billingStateController,
                      title: 'State',
                      hintText: 'Enter State',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: controller.billingCountryController,
                      title: 'Country',
                      hintText: 'Enter Country',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CrmTextField(
                      controller: controller.billingPostalController,
                      title: 'Postal Code',
                      hintText: 'Enter Postal Code',
                    ),
                  ),
                ],
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      value: controller.sameAsBilling.value,
                      onChanged: (value) {
                        controller.sameAsBilling.value = value ?? false;
                        if (controller.sameAsBilling.value) {
                          controller.shippingStreetController.text =
                              controller.billingStreetController.text;
                          controller.shippingCityController.text =
                              controller.billingCityController.text;
                          controller.shippingStateController.text =
                              controller.billingStateController.text;
                          controller.shippingCountryController.text =
                              controller.billingCountryController.text;
                          controller.shippingPostalController.text =
                              controller.billingPostalController.text;
                        } else {
                          controller.shippingStreetController.clear();
                          controller.shippingCityController.clear();
                          controller.shippingStateController.clear();
                          controller.shippingCountryController.clear();
                          controller.shippingPostalController.clear();
                        }
                      },
                    ),
                    const Text("Same as Billing Address"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Shipping Address",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CrmTextField(
                controller: controller.shippingStreetController,
                title: 'Street',
                hintText: 'Enter Street',
              ),
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: controller.shippingCityController,
                      title: 'City',
                      hintText: 'Enter City',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CrmTextField(
                      controller: controller.shippingStateController,
                      title: 'State',
                      hintText: 'Enter State',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: controller.shippingCountryController,
                      title: 'Country',
                      hintText: 'Enter Country',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CrmTextField(
                      controller: controller.shippingPostalController,
                      title: 'Postal Code',
                      hintText: 'Enter Postal Code',
                    ),
                  ),
                ],
              ),
              CrmTextField(
                controller: controller.notesController,
                title: 'Notes',
                hintText: 'Enter Notes',
                maxLines: 3,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 24),
              Obx(
                () =>
                    controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CrmButton(
                          onTap: () {
                            isFromEdit
                                ? controller.edit(customerData!.id!)
                                : controller.submit();
                          },
                          title:
                              isFromEdit ? "Update Customer" : "Add Customer",
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
