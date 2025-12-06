import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/utils/validation.dart';
import 'package:crm_flutter/app/data/network/job/job_list/job_list_model.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/job/job_applications/job_application_model.dart';
import '../../../../../data/network/system/country/model/country_model.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/job_application_controller.dart';


class AddJobApplicationScreen extends StatelessWidget {
  final JobApplicationController controller = Get.find();
  final bool isFromEdit;
  final JobApplicationData? application;

  AddJobApplicationScreen(
      {Key? key, this.application, this.isFromEdit = false})
      : super(key: key);





  String? requiredValidator(String? value, String message) {
    if (value == null || value
        .trim()
        .isEmpty) return message;
    return null;
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      controller.selectedFile.value = File(result.files.single.path!);
    }
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;

    if (controller.selectedFile.value == null && !isFromEdit) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Please select a CV file",
        contentType: ContentType.failure,
      );
      return;
    }

    controller.isLoading.value = true;

    final application = JobApplicationData(
      phoneCode: controller.selectedCountryCode.value?.id,
      phone: controller.phoneController.text,
      job: controller.selectedJobPosition.value?.id ?? '', // job id from dropdown
      name: controller.nameController.text,
      email: controller.emailController.text,
      location: controller.locationController.text,
      totalExperience: controller.selectedExperience.value,
      currentLocation: controller.currentLocationController.text,
      noticePeriod: controller.noticePeriodController.text,
      appliedSource: controller.appliedSourceController.text,
      status: controller.selectedApplicationStatus.value,
    );

    final success = await controller.createJobApplication(application);

    controller.isLoading.value = false;

    if (success) {
      Get.back();
      CrmSnackBar.showAwesomeSnackbar(
        title: "Success",
        message: "Job application submitted successfully",
        contentType: ContentType.success,
      );
    }
  }

  void _update() async {
    if (!controller.formKey.currentState!.validate()) return;

    if (controller.selectedFile.value == null && !isFromEdit) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Please select a CV file",
        contentType: ContentType.failure,
      );
      return;
    }

    controller.isLoading.value = true;

    final updatedApplication = JobApplicationData(
      phoneCode: controller.selectedCountryCode.value?.id,
      phone: controller.phoneController.text,
      job: controller.selectedJobPosition.value?.id ?? '',
      name: controller.nameController.text,
      email: controller.emailController.text,
      location: controller.locationController.text,
      totalExperience: controller.selectedExperience.value,
      currentLocation: controller.currentLocationController.text,
      noticePeriod: controller.noticePeriodController.text,
      appliedSource: controller.appliedSourceController.text,
      status: controller.selectedApplicationStatus.value,
    );

    final success = await controller.updateJobApplication(
      application!.id!,
      updatedApplication,
    );

    controller.isLoading.value = false;

    if (success) {
      Get.back();
      CrmSnackBar.showAwesomeSnackbar(
        title: "Success",
        message: "Job application updated successfully",
        contentType: ContentType.success,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    if (isFromEdit && application != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.nameController.text = application!.name ?? '';
       controller.selectedJobPosition.value = controller.jobPositions.firstWhereOrNull((element) => element.id == application!.job);
        controller.emailController.text = application!.email ?? '';
        controller.phoneController.text = application!.phone ?? '';
        controller.locationController.text = application!.location ?? '';
        controller.currentLocationController.text = application!.currentLocation ?? '';
        controller.noticePeriodController.text = application!.noticePeriod ?? '';
        controller.appliedSourceController.text = application!.appliedSource ?? '';
        if(controller.applicationStatus.contains(application!.status)) {
          controller.selectedApplicationStatus.value = controller.applicationStatus.firstWhereOrNull((element) => element == application!.status)!;
        }else{
          controller.selectedApplicationStatus.value = '';
        }
        if(controller.experienceList.contains(application!.totalExperience)){
          controller.selectedExperience.value = controller.experienceList.firstWhereOrNull((element) => element == application!.totalExperience)!;

        }else{
          controller.selectedExperience.value = '';
        }
        controller.selectedCountryCode.value = controller.countryCodes.firstWhereOrNull((element) => element.id == application!.phoneCode);
        controller.selectedFile.value = File(application!.cvPath ?? '');
      });
    }
    return Scaffold(
      appBar: AppBar(title: Text(
          isFromEdit ? 'Edit Job Application' : 'Add Job Application')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [

              /// Name

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

              /// Email
              CrmTextField(
                controller: controller.nameController,
                title: 'Name',
                isRequired: true,
                validator: (value) =>
                    requiredValidator(value, 'Name is required'),
                hintText: 'Enter Name',
              ),
              SizedBox(height: AppSpacing.medium),

              /// Email
              CrmTextField(
                controller: controller.emailController,
                title: 'Email',
                isRequired: true,
                validator: (value) => emailValidation(value),
                hintText: 'Enter Email',
              ),
              SizedBox(height: AppSpacing.medium),

              Row(
                children: [
                  Obx(
                        () =>
                        Expanded(
                          flex: 2,
                          child: CrmDropdownField<CountryModel>(
                            title: 'Code',
                            isRequired: true,
                            value: controller.selectedCountryCode.value,
                            items:
                            controller.countryCodes
                                .map(
                                  (country) =>
                                  DropdownMenuItem<CountryModel>(
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
                      controller: controller.phoneController,
                      title: 'Contact',
                      hintText: 'Enter Contact',
                      isRequired: true,
                      keyboardType: TextInputType.phone,
                      validator: (value) => phoneValidation(value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.medium),

              /// Location
              CrmTextField(
                controller: controller.locationController,
                title: 'Location',
                hintText: 'Enter Location',
                isRequired: true,
                validator: (value) =>
                    requiredValidator(value, 'Location is required'),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Total Experience
              Row(
                children: [
                  Obx(
                      ()=> Expanded(
                        child: CrmDropdownField<String>(
                          title: "Total Experience",
                          isRequired: true,
                          value: controller.selectedExperience.value,
                          items: controller.experienceList.map((e) =>
                              DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
                          onChanged: (value) {
                            controller.selectedExperience.value = value;
                          }),
                      ),
                  ),
                  SizedBox(width: AppSpacing.small),
                  Obx(
                        ()=> Expanded(
                          child: CrmDropdownField<String>(
                          title: "Status",
                          isRequired: true,
                          value: controller.selectedApplicationStatus.value,
                          items: controller.applicationStatus.map((e) =>
                              DropdownMenuItem<String>(value: e, child: Text(e.capitalize.toString()))).toList(),
                          onChanged: (value) {
                            controller.selectedApplicationStatus.value = value;
                          }),
                        ),
                  ),
                ],
              ),


              SizedBox(height: AppSpacing.medium),

              /// Current Location
              CrmTextField(
                controller: controller.currentLocationController,
                title: 'Current Location',
                hintText: 'Enter Current Location',
                isRequired: true,
                validator: (value) =>
                    requiredValidator(value, 'Current location is required'),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Notice Period
              CrmTextField(
                controller: controller.noticePeriodController,
                keyboardType: TextInputType.number,
                title: 'Notice Period',
                hintText: 'Enter Notice Period (in months)',
                isRequired: true,
                validator: (value) =>
                    requiredValidator(value, 'Notice period is required'),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Applied Source
              CrmTextField(
                isRequired: true,
                hintText: 'Enter Applied Source',
                controller: controller.appliedSourceController,
                title: 'Applied Source',
              ),
              SizedBox(height: AppSpacing.medium),

              /// Status



              /// File Upload
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

              Obx(
                    () =>
                controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CrmButton(
                  width: double.infinity,
                  onTap: isFromEdit ?_update:_submit,
                  title: isFromEdit
                      ? 'Update Application'
                      : 'Create Application',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
