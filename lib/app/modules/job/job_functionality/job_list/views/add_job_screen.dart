import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/job/job_functionality/job_list/controllers/job_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../data/network/job/job_list/job_list_model.dart';
import '../../../../../data/network/user/all_users/model/all_users_model.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';

class AddJobScreen extends StatelessWidget {
  final JobData? job;
  final bool isFromEdit;
  final JobListController controller = Get.find();

  AddJobScreen({super.key, this.job, this.isFromEdit = false});

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;

    final jobData = JobData(
      title: controller.titleController.text,
      category: controller.categoryController.text,
      skills: JobSkills(skills: controller.skillsList.value),
      location: controller.locationController.text,
      interviewRounds: JobInterviewRounds(
        interviewRounds: controller.interviewRoundsList.value,
      ),
      startDate: controller.startDateController.text,
      endDate: controller.endDateController.text,
      totalOpenings: int.tryParse(controller.totalOpeningsController.text) ?? 0,
      status: controller.selectedStatus.value ?? "inactive",
      recruiter: controller.selectedManager.value?.id,
      jobType: controller.selectedJobType.value ?? "Full-time",
      workExperience: controller.selectedWorkExperience.value,
      currency: controller.currency.value ?? "",
      expectedSalary: controller.expectedSalaryController.text,
      description: controller.descriptionController.text,
    );

    controller.isLoading.value = true;
    final success = await controller.createJob(jobData);
    controller.isLoading.value = false;

    if (success) Get.back();
  }

  String? _getCurrencyValue(JobListController controller) {
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

  void _update() async {
    if (!controller.formKey.currentState!.validate() || job == null) return;

    final jobData = JobData(
      title: controller.titleController.text,
      category: controller.categoryController.text,
      skills: JobSkills(skills: controller.skillsList.value),
      location: controller.locationController.text,
      interviewRounds: JobInterviewRounds(
        interviewRounds: controller.interviewRoundsList.value,
      ),
      startDate: controller.startDateController.text,
      endDate: controller.endDateController.text,
      totalOpenings: int.tryParse(controller.totalOpeningsController.text) ?? 0,
      status: controller.selectedStatus.value ?? "inactive",
      recruiter: controller.selectedManager.value?.id,
      jobType: controller.selectedJobType.value ?? "Full-time",
      workExperience: controller.selectedWorkExperience.value,
      currency: controller.currency.value ?? "",
      expectedSalary: controller.expectedSalaryController.text,
      description: controller.descriptionController.text,
    );

    controller.isLoading.value = true;
    final success = await controller.updateJob(job!.id!, jobData);
    controller.isLoading.value = false;

    if (success) Get.back();
  }

  Future<void> pickDate({
    required BuildContext context,
    required TextEditingController controller,
    DateTime? selectedDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
      if (selectedDate != null) {
        selectedDate = picked;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFromEdit && job != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.getManagerById(job!.recruiter!);
        controller.selectedManager.value = controller.managers.firstWhereOrNull(
          (r) => r.id == job!.recruiter,
        );
      });

      controller.titleController.text = job!.title ?? '';
      controller.categoryController.text = job!.category ?? '';

      // ✅ Fix: assign list directly
      controller.skillsList.assignAll(job!.skills?.skills ?? []);

      controller.locationController.text = job!.location ?? '';

      // ✅ Fix: assign list directly
      controller.interviewRoundsList.assignAll(
        job!.interviewRounds?.interviewRounds ?? [],
      );

      if (job!.endDate != null) {
        final endDate = DateTime.tryParse(job!.endDate!);
        if (endDate != null) {
          controller.selectedEndDate.value = endDate;
          controller.endDateController.text = DateFormat(
            'yyyy-MM-dd',
          ).format(endDate);
        }
      }
      if (job!.startDate != null) {
        final startDate = DateTime.tryParse(job!.startDate!);
        if (startDate != null) {
          controller.selectedStartDate.value = startDate;
          controller.startDateController.text = DateFormat(
            'yyyy-MM-dd',
          ).format(startDate);
        }
      }

      controller.totalOpeningsController.text =
          job!.totalOpenings?.toString() ?? '';
      controller.selectedWorkExperience.value = job!.workExperience ?? '';
      controller.expectedSalaryController.text = job!.expectedSalary ?? '';
      controller.descriptionController.text = job!.description ?? '';
      controller.selectedStatus.value = job!.status ?? "inactive";
      controller.selectedJobType.value = job!.jobType ?? "Full-time";
      controller.currency.value = job!.currency ?? "";
    }

    return Scaffold(
      appBar: AppBar(title: Text(isFromEdit ? 'Edit Job' : 'Add Job')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              CrmTextField(
                controller: controller.titleController,
                title: "Title",
                isRequired: true,
                validator: (v) => requiredValidator(v, "Title is required"),
                hintText: "e.g. (Software Engineer)",
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                controller: controller.categoryController,
                title: "Category",
                isRequired: true,
                hintText: "e.g (IT)",
                validator: (v) => requiredValidator(v, "Category is required"),
              ),
              SizedBox(height: AppSpacing.medium),

              // CrmTextField(
              //   controller: controller.skillsController,
              //   title: "Skills",
              //   isRequired: true,
              // ),
              // SkillTagsInput(),
              TagsInputField(
                title: 'Skills',
                hintText: "Enter Skill",
                tags: controller.skillsList,
                controller: controller.skillTextController,
                focusNode: controller.skillFocusNode,
              ),

              SizedBox(height: AppSpacing.medium),

              TagsInputField(
                title: 'Interview Rounds',
                hintText: "Enter Interview Rounds",
                tags: controller.interviewRoundsList,
                controller: controller.interviewRoundsController,
                focusNode: controller.interviewRoundsFocus,
              ),

              SizedBox(height: AppSpacing.medium),

              CrmDropdownField<String>(
                value: controller.selectedWorkExperience.value,
                items:
                    controller.workExperienceList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (e) => controller.selectedWorkExperience.value = e,
                title: "Work Experience",
                isRequired: true,
              ),
              SizedBox(height: AppSpacing.medium),

              Obx(
                () => CrmDropdownField<User>(
                  title: 'Recruiter',
                  value: controller.selectedManager.value,
                  items:
                      controller.managers
                          .map(
                            (manager) => DropdownMenuItem<User>(
                              value: manager,
                              child: Text(manager.username),
                            ),
                          )
                          .toList(),
                  onChanged: (manager) {
                    controller.selectedManager.value = manager;
                  },
                  isRequired: true,
                ),
              ),
              SizedBox(height: AppSpacing.medium),

              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: controller.startDateController,
                      title: "Start Date",
                      hintText: "YYYY-MM-DD",
                      isRequired: true,
                      readOnly: true,
                      // prevent keyboard
                      suffixIcon: const Icon(Icons.calendar_today_rounded),
                      onTap:
                          () => pickDate(
                            context: context,
                            controller: controller.startDateController,
                            selectedDate: controller.selectedStartDate.value,
                          ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.small),
                  Expanded(
                    child: CrmTextField(
                      controller: controller.endDateController,
                      title: "End Date",
                      hintText: "YYYY-MM-DD",
                      isRequired: true,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.calendar_today_rounded),
                      onTap:
                          () => pickDate(
                            context: context,
                            controller: controller.endDateController,
                            selectedDate: controller.selectedEndDate.value,
                          ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.medium),

              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => CrmDropdownField<String>(
                        title: "Status",
                        value: controller.selectedStatus.value,
                        items:
                            controller.jobStatusList
                                .map(
                                  (s) => DropdownMenuItem(
                                    value: s,
                                    child: Text(s),
                                  ),
                                )
                                .toList(),
                        onChanged: (s) => controller.selectedStatus.value = s,
                        isRequired: true,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.small),

                  /// Job Type Dropdown
                  Expanded(
                    child: Obx(
                      () => CrmDropdownField<String>(
                        title: "Job Type",
                        value: controller.selectedJobType.value,
                        items:
                            controller.jobTypeList
                                .map(
                                  (j) => DropdownMenuItem(
                                    value: j,
                                    child: Text(j),
                                  ),
                                )
                                .toList(),
                        onChanged: (j) => controller.selectedJobType.value = j,
                        isRequired: true,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.medium),
              CrmTextField(
                controller: controller.locationController,
                title: "Location",
                isRequired: true,
                hintText: "Enter location",
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                controller: controller.totalOpeningsController,
                title: "Total Openings",
                keyboardType: TextInputType.number,
                isRequired: true,
              ),
              SizedBox(height: AppSpacing.medium),

              /// Status Dropdown
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
                      controller: controller.expectedSalaryController,
                      hintText: 'Enter Salary',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                controller: controller.descriptionController,
                title: "Description",
                maxLines: 3,
                isRequired: true,
              ),
              const SizedBox(height: 24),

              Obx(
                () =>
                    controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CrmButton(
                          width: double.infinity,
                          onTap: isFromEdit ? _update : _submit,
                          title: isFromEdit ? "Update Job" : "Create Job",
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TagsInputField extends StatelessWidget {
  final String title;
  final String hintText;
  final RxList<String> tags;
  final TextEditingController controller;
  final FocusNode focusNode;

  const TagsInputField({
    super.key,
    required this.title,
    required this.hintText,
    required this.tags,
    required this.controller,
    required this.focusNode,
  });

  void _addTag() {
    final value = controller.text.trim();
    if (value.isNotEmpty && !tags.contains(value)) {
      tags.add(value);
    }
    controller.clear();
  }

  void _removeTag(String tag) {
    tags.remove(tag);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Input field with add button
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: CrmTextField(
                title: title,
                isRequired: true,
                controller: controller,
                focusNode: focusNode,
                hintText: hintText,
                // onFieldSubmitted: (_) => _addTag(),
              ),
            ),
            SizedBox(width: AppSpacing.small),
            CrmButton(width: 100, title: "Add", onTap: _addTag),
          ],
        ),
        const SizedBox(height: 8),

        /// Show added tags
        Obx(
          () => Wrap(
            spacing: 6,
            runSpacing: -8,
            children:
                tags
                    .map(
                      (tag) => Chip(
                        label: Text(tag),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () => _removeTag(tag),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}
