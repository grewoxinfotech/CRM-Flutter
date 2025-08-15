import 'package:crm_flutter/app/care/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../contoller/vendor_controller.dart';

class AddVendorScreen extends StatelessWidget {
  final VendorController controller = Get.find<VendorController>();

  AddVendorScreen({Key? key}) : super(key: key);

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return null; // optional
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? numberValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) return null; // optional
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return '$fieldName must be numeric';
    }
    return null;
  }

  String? taxNumberValidator(String? value) {
    if (value == null || value.isEmpty) return null; // optional
    if (!RegExp(r'^[A-Za-z0-9]{6,15}$').hasMatch(value)) {
      return 'Invalid Tax Number format';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Vendor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CrmTextField(
                  controller: controller.nameController,
                  title: 'Vendor Name',
                  isRequired: true,
                  validator:
                      (v) =>
                          controller.requiredValidator(v, 'Please enter name'),
                  hintText: 'Enter Vendor Name',
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CrmTextField(
                        controller: controller.contactController,
                        title: 'Contact Person',
                        isRequired: true,
                        validator:
                            (v) => controller.requiredValidator(
                              v,
                              'Please enter contact name',
                            ),
                        hintText: 'Emter Contact person',

                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CrmTextField(
                        controller: controller.phoneCodeController,
                        title: 'Phone Code',
                        keyboardType: TextInputType.number,
                        validator: (v) => numberValidator(v, 'Phone Code'),
                        hintText: 'Enter Phone Code',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CrmTextField(
                  controller: controller.emailController,
                  title: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter email',
                  validator: emailValidator,
                ),
                const SizedBox(height: 20),
                CrmTextField(
                  controller: controller.taxNumberController,
                  title: 'Tax Number',
                  hintText: 'Enter Tax Number',
                  validator: taxNumberValidator,

                ),
                const SizedBox(height: 20),
                CrmTextField(
                  controller: controller.addressController,
                  title: 'Address',
                  maxLines: 2,
                  hintText: 'Enter Address',
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CrmTextField(
                        controller: controller.cityController,
                        title: 'City',
                        hintText: 'Enter City',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CrmTextField(
                        controller: controller.stateController,
                        title: 'State',
                        hintText: 'Enter State',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CrmTextField(
                        controller: controller.countryController,
                        title: 'Country',
                        hintText: 'Enter Country',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CrmTextField(
                        controller: controller.zipCodeController,
                        title: 'Zip Code',
                        keyboardType: TextInputType.number,
                        validator: (v) => numberValidator(v, 'Zip Code'),
                        hintText: 'Enter Zip Code',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Obx(
                  () =>
                      controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CrmButton(
                            width: Get.width - 40,
                            title: 'Add Vendor',
                            onTap: controller.submitVendor,
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
