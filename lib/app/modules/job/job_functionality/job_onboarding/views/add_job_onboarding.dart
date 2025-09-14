import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../data/network/job/job_onboarding/job_onboarding_model.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../controller/job_onboarding_controller.dart';

import '../../../../../care/constants/size_manager.dart';


class AddJobOnboardingScreen extends StatelessWidget {
  final JobOnboardingData? job;
  final bool isFromEdit;
  final JobOnboardingController controller = Get.find();

  AddJobOnboardingScreen({super.key, this.job, this.isFromEdit = false});

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  Future<void> pickDate({
    required BuildContext context,
    required TextEditingController controller,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
      // Update GetX observable directly
      this.controller.selectedJoiningDate.value = picked;

    }
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;
    print('Date : ${controller.selectedJoiningDate.value}');
    final jobData = JobOnboardingData(
      interviewer: controller.interviewerController.text,
      joiningDate: controller.selectedJoiningDate.value!.toIso8601String(),
      daysOfWeek: controller.daysOfWeekController.text,
      salary: controller.salaryController.text,
      currency: controller.currency.value,
      salaryType:  controller.selectedSalaryType.value,
      salaryDuration:  controller.selectedSalaryDuration.value,
      jobType:  controller.selectedJobType.value,
      status:  controller.selectedStatus.value,
    );

    controller.isLoading.value = true;
    final success = await controller.createJobOnboarding(jobData);
    controller.isLoading.value = false;

    if (success) Get.back();
  }

  void _update() async {
    if (!controller.formKey.currentState!.validate() || job == null) return;

    final jobData = JobOnboardingData(
      interviewer: controller.interviewerController.text,
      joiningDate: controller.selectedJoiningDate.value.toString(),
      daysOfWeek: controller.daysOfWeekController.text,
      salary: controller.salaryController.text,
      currency: controller.currency.value,
      salaryType:  controller.selectedSalaryType.value,
      salaryDuration:  controller.selectedSalaryDuration.value,
      jobType:  controller.selectedJobType.value,
      status:  controller.selectedStatus.value,
    );

    controller.isLoading.value = true;
    final success =
    await controller.updateJobOnboarding(job!.id!, jobData);
    controller.isLoading.value = false;

    if (success) Get.back();
  }

  String? _getCurrencyValue(JobOnboardingController controller) {
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

  @override
  Widget build(BuildContext context) {
    if (isFromEdit && job != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.interviewerController.text = job!.interviewer ?? '';
        if (job!.joiningDate != null) {
          final date = DateTime.tryParse(job!.joiningDate!);
          if (date != null) {
            controller.joiningDateController.text =
                DateFormat('yyyy-MM-dd').format(date);
            controller.selectedJoiningDate.value = date;
          }
        }
        // controller.joiningDateController.text = job!.joiningDate ?? '';
        controller.daysOfWeekController.text = job!.daysOfWeek ?? '';
        controller.salaryController.text = job!.salary ?? '';
        controller.currency.value = job!.currency ?? '';
       if(job!.salaryType != null){
         controller.selectedSalaryType.value = controller.salaryTypeList.firstWhereOrNull((element) => element == job!.salaryType)!;
       }
       if(job!.salaryDuration != null){
         controller.selectedSalaryDuration.value = controller.salaryDurationList.firstWhereOrNull((element) => element == job!.salaryDuration)!;
       }
       if(job!.jobType != null){
         controller.selectedJobType.value = controller.jobTypeList.firstWhereOrNull((element) => element == job!.jobType)!;
       }
       if(job!.status != null){
         controller.selectedStatus.value = controller.statusList.firstWhereOrNull((element) => element == job!.status)!;
       }
      });
    }

    return Scaffold(
      appBar: AppBar(title: Text(isFromEdit ? 'Edit Job Onboarding' : 'Add Job Onboarding')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              CrmTextField(
                controller: controller.interviewerController,
                title: "Interviewer",
                hintText: "Enter Interviewer Name",
                isRequired: true,
                validator: (v) => requiredValidator(v, "Interviewer is required"),
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                controller: controller.joiningDateController,
                title: "Joining Date",
                hintText: "YYYY-MM-DD",
                isRequired: true,
                readOnly: true,
                suffixIcon: const Icon(Icons.calendar_today),
                onTap: () => pickDate(
                    context: context,
                    controller: controller.joiningDateController,),
              ),
              SizedBox(height: AppSpacing.medium),

              CrmTextField(
                controller: controller.daysOfWeekController,
                title: "Days of Week",
                isRequired: true,
                hintText: "Enter Days of Week",
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: AppSpacing.medium),

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
                      controller: controller.salaryController,
                      hintText: 'Enter Salary',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.medium),

              Row(
                children: [
                  Expanded(
                    child:Obx(
                          ()=> CrmDropdownField<String>(
                        title: "Salary Type",
                        value: controller.selectedSalaryType.value,

                        items: controller.salaryTypeList
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) => controller.selectedSalaryType.value = val ?? '',
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.small),

                  Expanded(
                    child: Obx(
                          ()=> CrmDropdownField<String>(
                        title: "Salary Duration",
                        value: controller.selectedSalaryDuration.value,

                        items:controller.salaryDurationList
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) => controller.selectedSalaryDuration.value= val ?? '',
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.medium),

              Row(
                children: [
                  Expanded(
                    child:Obx(
                          ()=> CrmDropdownField<String>(
                        title: "Job Type",
                        value: controller.selectedJobType.value,

                        items:controller.jobTypeList
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) => controller.selectedJobType.value = val ?? '',
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.small),

                  Expanded(
                    child: Obx(
                      ()=> CrmDropdownField<String>(
                        title: "Status",
                        value: controller.selectedStatus.value,
                        items:controller.statusList
                            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (val) => controller.selectedStatus.value = val ?? '',
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Obx(() => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : CrmButton(
                width: double.infinity,
                onTap: isFromEdit ? _update : _submit,
                title: isFromEdit ? "Update Job Onboarding" : "Create Job Onboarding",
              )),
            ],
          ),
        ),
      ),
    );
  }
}
