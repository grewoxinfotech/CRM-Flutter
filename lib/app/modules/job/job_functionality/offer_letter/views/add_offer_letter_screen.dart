import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/job/job_applications/job_application_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../../../../../data/network/job/job_list/job_list_model.dart';
import '../../../../../data/network/job/offer_letter/offer_letter_model.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/offer_letter_controller.dart';

class AddOfferLetterScreen extends StatelessWidget {
  final OfferLetterData? offerLetter;
  final bool isFromEdit;
  final OfferLetterController controller = Get.find();

  AddOfferLetterScreen({super.key, this.offerLetter, this.isFromEdit = false});

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;

    if(controller.selectedFile.value == null){
      CrmSnackBar.showAwesomeSnackbar(
        title: "Validation Error",
        message: "Please upload a file",
        contentType: ContentType.warning,
      );
      return;
    }

    final newOffer = OfferLetterData(
      job: controller.selectedJobPosition.value?.id,
      jobApplicant: controller.selectedJobApplication.value?.id,
      offerExpiry: controller.offerExpiry.value!.toIso8601String(),
      expectedJoiningDate: controller.expectedJoiningDate.value!.toIso8601String(),
      salary: controller.salaryController.text,
      currency: controller.currency.value,
      description: controller.descriptionController.text,
    );

    controller.isLoading.value = true;
    final success = await controller.createOfferLetter(newOffer);
    controller.isLoading.value = false;

    if (success) Get.back();
  }

  void _update() async {
    if (!controller.formKey.currentState!.validate()) return;

    if (controller.selectedJobPosition.value == null ||
        controller.selectedJobApplication.value == null ||
        controller.offerExpiry.value == null ||
        controller.expectedJoiningDate.value == null ||
        controller.salaryController.text.isEmpty ||
        controller.currency.value == null ||
        controller.currency.value!.isEmpty ||
        controller.descriptionController.text.isEmpty) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Validation Error",
        message: "Please fill all required fields",
        contentType: ContentType.warning,
      );
      return;
    }

    final updatedOffer = OfferLetterData(
      job: controller.selectedJobPosition.value?.id,
      jobApplicant: controller.selectedJobApplication.value?.id,
      offerExpiry: controller.offerExpiry.value?.toIso8601String(),
      expectedJoiningDate: controller.expectedJoiningDate.value?.toIso8601String(),
      salary: controller.salaryController.text,
      currency: controller.currency.value,
      description: controller.descriptionController.text,
    );

    controller.isLoading.value = true;
    final success = await controller.updateOfferLetter(
      offerLetter!.id!,
      updatedOffer,
      controller.selectedFile.value!.path == offerLetter!.file ? null : controller.selectedFile.value,
    );
    controller.isLoading.value = false;

    if (success) Get.back();
  }


  Future<void> pickDate({
    required BuildContext context,
    required TextEditingController controller,
    required Rxn<DateTime?> target,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
      target.value = picked;

    }
  }

  String? _getCurrencyValue(OfferLetterController controller) {
    if (controller.isLoadingCurrencies.value) return null;

    // If using API currencies, check if current currency exists in the list
    if (controller.currencies.isNotEmpty) {
      bool currencyExists = controller.currencies.any(
            (c) => c.id == controller.currency.value,
      );
      if (currencyExists) {
        return controller.currency.value;
      } else {
        // If currency doesn't exist in API list, return first available currency
        return controller.currencies.first.id;
      }
    }
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      controller.selectedFile.value = File(result.files.single.path!);
    }
  }



  @override
  Widget build(BuildContext context) {
    if (isFromEdit && offerLetter != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.getJobById(offerLetter!.job!);
        await controller.getJobApplicationById(offerLetter!.jobApplicant!);
        // await controller.loadCurrencyById(offerLetter!.currency!);
      });

      if (offerLetter!.job != null) {
       controller.selectedJobPosition.value =  controller.jobPositions.firstWhereOrNull((item) => item.id == offerLetter!.job);
      }
      if (offerLetter!.jobApplicant != null) {
        controller.selectedJobApplication.value =  controller.jobApplications.firstWhereOrNull((item) => item.id == offerLetter!.jobApplicant);
      }
      if(offerLetter!.offerExpiry != null){
        final expiryDate = DateTime.tryParse(offerLetter!.offerExpiry!);
        if (expiryDate != null) {
          controller.offerExpiryController.text = DateFormat('yyyy-MM-dd').format(expiryDate);
          controller.offerExpiry.value = expiryDate;
        }
      }
      if(offerLetter!.expectedJoiningDate != null){
        final joiningDate = DateTime.tryParse(offerLetter!.expectedJoiningDate!);
        if (joiningDate != null) {
          controller.expectedJoiningDateController.text = DateFormat('yyyy-MM-dd').format(joiningDate);
          controller.expectedJoiningDate.value = joiningDate;
        }
      }
      controller.salaryController.text = offerLetter!.salary?.toString() ?? '';
      controller.descriptionController.text = offerLetter!.description ?? '';
     if(offerLetter!.file!=null){
       controller.selectedFile.value = File(offerLetter!.file ?? '');
     }
    }

    return Scaffold(
      appBar: AppBar(title: Text(isFromEdit ? 'Edit Offer Letter' : 'Add Offer Letter')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              /// Job Dropdown
              Obx(
                    () =>
                    CrmDropdownField<JobData>(
                      title: 'Job Position',
                      isRequired: true,
                      value: controller.selectedJobPosition.value,
                      items: controller.jobPositions.map((e) =>
                          DropdownMenuItem<JobData>(value: e, child: Text(e
                              .title ?? ''))).toList(),
                      onChanged: (value) {
                        controller.selectedJobPosition.value = value;
                      },
                    ),
              ),
              SizedBox(height: AppSpacing.medium),


              /// Applicant Dropdown
              Obx(
                    () =>
                    CrmDropdownField<JobApplicationData>(
                      title: 'Job Applicant',
                      isRequired: true,
                      value: controller.selectedJobApplication.value,
                      items: controller.jobApplications.map((e) =>
                          DropdownMenuItem<JobApplicationData>(value: e, child: Text(e
                              .name ?? ''))).toList(),
                      onChanged: (value) {
                        controller.selectedJobApplication.value = value;
                      },
                    ),
              ),
              SizedBox(height: AppSpacing.medium),

              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: controller.offerExpiryController,
                      title: "Offer Expire On",
                      validator: (value)=> requiredValidator(value, 'Please select a offer expiry date'),
                      hintText: "YYYY-MM-DD",
                      isRequired: true,
                      readOnly: true,
                      // prevent keyboard
                      suffixIcon: const Icon(Icons.calendar_today_rounded),
                      onTap:
                          () => pickDate(
                        context: context,
                        controller: controller.offerExpiryController,
                        target: controller.offerExpiry,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.small),
                  Expanded(
                    child: CrmTextField(
                      controller: controller.expectedJoiningDateController,
                      title: "Expected Joining Date",
                      validator: (value)=> requiredValidator(value, 'Please select a expected joining date'),
                      hintText: "YYYY-MM-DD",
                      isRequired: true,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.calendar_today_rounded),
                      onTap:
                          () => pickDate(
                        context: context,
                        controller: controller.expectedJoiningDateController,
                        target: controller.expectedJoiningDate,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.medium),

              /// Salary
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Obx(
                          () => CrmDropdownField<String>(
                        title: 'Currency',
                        value: _getCurrencyValue(controller),
                        items:
                        controller.isLoadingCurrencies.value &&
                            controller.currenciesLoaded.value
                            ? [
                          DropdownMenuItem(
                            value: controller.currency.value,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text('Loading currencies...'),
                              ],
                            ),
                          ),
                        ]
                            : controller.currencies.isNotEmpty
                            ? controller.currencies
                            .map(
                              (currency) => DropdownMenuItem(
                            value: currency.id,
                            child: Text(
                              '${currency.currencyCode} (${currency.currencyIcon})',
                            ),
                          ),
                        )
                            .toList()
                            : [
                          DropdownMenuItem(
                            value: 'AHNTpSNJHMypuNF6iPcMLrz',
                            child: Text('INR (₹)'),
                          ),
                          DropdownMenuItem(
                            value: 'BHNTpSNJHMypuNF6iPcMLr2',
                            child: Text('USD (\$)'),
                          ),
                          DropdownMenuItem(
                            value: 'CHNTpSNJHMypuNF6iPcMLr3',
                            child: Text('EUR (€)'),
                          ),
                        ],
                        onChanged: (value) {
                          // Don't process changes during loading
                          if (value != null &&
                              !(controller.isLoadingCurrencies.value &&
                                  controller.currenciesLoaded.value)) {
                            controller.updateCurrencyDetails(value);
                          }
                        },

                        isRequired: true,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: CrmTextField(
                      title: 'Salary',
                      isRequired: true,
                      validator: (value)=> requiredValidator(value, 'Please enter a salary'),
                      controller: controller.salaryController,
                      hintText: 'Enter Salary',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.medium),




              /// Description
              CrmTextField(
                controller: controller.descriptionController,
                isRequired: true,
                hintText: 'Enter Description',
                title: 'Description',
                validator: (value)=> requiredValidator(value, 'Please enter a description'),
                maxLines: 3,
              ),
              SizedBox(height: AppSpacing.medium),

              Obx(
                    () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Upload File *",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickFile,
                          icon: const Icon(Icons.upload_file),
                          label: const Text("Choose File"),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.selectedFile.value != null
                                ? controller.selectedFile.value!.path.split('/').last
                                : "No file chosen",
                            style: const TextStyle(color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


              const SizedBox(height: 24),

              /// Submit Button
              Obx(
                    () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CrmButton(
                  width: double.infinity,
                  onTap: isFromEdit ? _update : _submit,
                  title: isFromEdit ? 'Update Offer Letter' : 'Create Offer Letter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
