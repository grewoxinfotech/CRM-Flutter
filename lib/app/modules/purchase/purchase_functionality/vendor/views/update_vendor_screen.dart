import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../contoller/vendor_controller.dart';
import '../../../../../data/network/purchase/vendor/model/vendor_model.dart';

class UpdateVendorScreen extends StatelessWidget {
  final VendorData vendor;
  final VendorController controller = Get.find<VendorController>();

  UpdateVendorScreen({Key? key, required this.vendor}) : super(key: key) {
    // Pre-fill fields with vendor data
    controller.nameController.text = vendor.name ?? '';
    controller.contactController.text = vendor.contact ?? '';
    controller.phoneCodeController.text = vendor.phonecode ?? '';
    controller.emailController.text = vendor.email ?? '';
    controller.taxNumberController.text = vendor.taxNumber ?? '';
    controller.addressController.text = vendor.address ?? '';
    controller.cityController.text = vendor.city ?? '';
    controller.stateController.text = vendor.state ?? '';
    controller.countryController.text = vendor.country ?? '';
    controller.zipCodeController.text = vendor.zipcode ?? '';
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return null; // optional
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }

  String? numberValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'^\d+$').hasMatch(value)) return '$fieldName must be numeric';
    return null;
  }

  String? taxNumberValidator(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'^[A-Za-z0-9]{6,15}$').hasMatch(value)) return 'Invalid Tax Number format';
    return null;
  }

  void _updateVendor() async {
    if (controller.formKey.currentState?.validate() ?? false) {
      controller.isLoading.value = true;

      final updatedVendor = VendorData(
        id: vendor.id,
        name: controller.nameController.text,
        contact: controller.contactController.text,
        phonecode: controller.phoneCodeController.text,
        email: controller.emailController.text,
        taxNumber: controller.taxNumberController.text,
        address: controller.addressController.text,
        city: controller.cityController.text,
        state: controller.stateController.text,
        country: controller.countryController.text,
        zipcode: controller.zipCodeController.text,
        createdBy: vendor.createdBy,
        createdAt: vendor.createdAt,
      );

      final success = await controller.updateVendor(vendor.id!, updatedVendor);

      controller.isLoading.value = false;

      if (success) {
        Get.back(result: updatedVendor); // pass updated vendor back
        CrmSnackBar.showAwesomeSnackbar(
          title: "Success",
          message: "Vendor updated successfully",
          contentType: ContentType.success,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Vendor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CrmTextField(
                  controller: controller.nameController,
                  title: 'Vendor Name',
                  isRequired: true,
                  validator: (v) => controller.requiredValidator(v, 'Please enter name'),
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
                        validator: (v) => controller.requiredValidator(v, 'Please enter contact name'),
                        hintText: 'Enter Contact person',
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
                      () => controller.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : CrmButton(
                    width: Get.width - 40,
                    title: 'Update Vendor',
                    onTap: _updateVendor,
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
