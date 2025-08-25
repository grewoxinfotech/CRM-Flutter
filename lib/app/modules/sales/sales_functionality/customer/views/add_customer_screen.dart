import 'package:crm_flutter/app/care/utils/validation.dart';
import 'package:crm_flutter/app/data/network/sales/customer/model/customer_model.dart';
import 'package:crm_flutter/app/data/network/system/country/controller/country_controller.dart';
import 'package:crm_flutter/app/data/network/system/country/model/country_model.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../controllers/customer_controller.dart';

class AddCustomerScreen extends StatefulWidget {
  final int? customers;
  const AddCustomerScreen({super.key, this.customers});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final CustomerController controller = Get.find();
  final CountryController countryController = Get.put(CountryController());

  final _formKey = GlobalKey<FormState>();
  bool sameAsBilling = false;

  final TextEditingController customerNumberController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController taxNumberController = TextEditingController();
  final TextEditingController alternateNumberController =
      TextEditingController();
  final TextEditingController textNumberController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController phoneCodeController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // Billing
  final TextEditingController billingStreetController = TextEditingController();
  final TextEditingController billingCityController = TextEditingController();
  final TextEditingController billingStateController = TextEditingController();
  final TextEditingController billingCountryController =
      TextEditingController();
  final TextEditingController billingPostalController = TextEditingController();

  // Shipping
  final TextEditingController shippingStreetController =
      TextEditingController();
  final TextEditingController shippingCityController = TextEditingController();
  final TextEditingController shippingStateController = TextEditingController();
  final TextEditingController shippingCountryController =
      TextEditingController();
  final TextEditingController shippingPostalController =
      TextEditingController();

  String status = "active";
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  String? requiredFieldValidator(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final customer = CustomerData(
      name: nameController.text.trim(),
      contact: contactController.text.trim(),
      email: emailController.text.trim(),
      taxNumber: taxNumberController.text.trim(),
      phonecode: controller.selectedCountryCode.value?.id.toString(),
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

    bool success = await controller.createCustomer(customer);

    setState(() => isLoading = false);

    if (success) {
      Get.back();
      Get.snackbar(
        'Success',
        'Customer added successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to add customer',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
      );
    }
  }

  @override
  void dispose() {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Customer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              // CrmTextField(
              //   controller: customerNumberController,
              //   title: 'Customer Number',
              //   isRequired: true,
              // ),
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: nameController,
                      title: 'Name',
                      isRequired: true,
                      validator:
                          (value) =>
                              requiredFieldValidator(value, fieldName: 'Name'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CrmTextField(
                      controller: taxNumberController,

                      title: 'Tax Number',
                    ),
                  ),
                ],
              ),
              // CrmTextField(
              //   controller: contactController,
              //   title: 'Contact',
              //   isRequired: true,
              //   keyboardType: TextInputType.phone,
              //   validator: (value) => phoneValidation(value),
              // ),
              Row(
                children: [
                  Obx(
                    ()=> Expanded(
                      flex: 2, // smaller space for dropdown
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
                          setState(() {
                            controller.selectedCountryCode.value = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 5,
                    child: CrmTextField(
                      controller: contactController,
                      title: 'Contact',
                      isRequired: true,
                      keyboardType: TextInputType.phone,
                      validator: (value) => phoneValidation(value),
                    ),
                  ),
                ],
              ),

              CrmTextField(
                controller: emailController,
                title: 'Email',
                keyboardType: TextInputType.emailAddress,
                isRequired: true,
                validator: (value) => emailValidation(value),
              ),

              // CrmTextField(
              //   controller: alternateNumberController,
              //   title: 'Alternate Number',
              // ),
              // CrmTextField(
              //   controller: textNumberController,
              //   title: 'Text Number',
              // ),
              // CrmTextField(controller: companyController, title: 'Company'),
              // CrmTextField(
              //   controller: phoneCodeController,
              //   title: 'Phone Code',
              // ),
              const SizedBox(height: 16),
              const Text(
                "Billing Address",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              CrmTextField(
                controller: billingStreetController,
                title: 'Street',
              ),
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: billingCityController,
                      title: 'City',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CrmTextField(
                      controller: billingStateController,
                      title: 'State',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: billingCountryController,
                      title: 'Country',
                    ),
                  ),
                  SizedBox(width: 16),

                  Expanded(
                    child: CrmTextField(
                      controller: billingPostalController,
                      title: 'Postal Code',
                    ),
                  ),
                ],
              ),

              // ✅ Checkbox to copy billing to shipping
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                    value: sameAsBilling,
                    onChanged: (value) {
                      setState(() {
                        sameAsBilling = value!;
                        if (sameAsBilling) {
                          shippingStreetController.text =
                              billingStreetController.text;
                          shippingCityController.text =
                              billingCityController.text;
                          shippingStateController.text =
                              billingStateController.text;
                          shippingCountryController.text =
                              billingCountryController.text;
                          shippingPostalController.text =
                              billingPostalController.text;
                        } else {
                          shippingStreetController.clear();
                          shippingCityController.clear();
                          shippingStateController.clear();
                          shippingCountryController.clear();
                          shippingPostalController.clear();
                        }
                      });
                    },
                  ),
                  const Text("Same as Billing Address"),
                ],
              ),

              const SizedBox(height: 16),
              const Text(
                "Shipping Address",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              CrmTextField(
                controller: shippingStreetController,
                title: 'Street',
              ),
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: shippingCityController,
                      title: 'City',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CrmTextField(
                      controller: shippingStateController,
                      title: 'State',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: shippingCountryController,
                      title: 'Country',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CrmTextField(
                      controller: shippingPostalController,
                      title: 'Postal Code',
                    ),
                  ),
                ],
              ),

              CrmTextField(
                controller: notesController,
                title: 'Notes',
                maxLines: 3,
              ),

              const SizedBox(height: 24),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CrmButton(onTap: _submit, title: 'Add Customer'),
            ],
          ),
        ),
      ),
    );
  }
}
