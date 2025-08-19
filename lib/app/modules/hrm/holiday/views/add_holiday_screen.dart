import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/holiday_controller.dart';
import '../../../../data/network/hrm/hrm_system/holiday/holiday_model.dart';

class AddHolidayScreen extends StatelessWidget {
  final HolidayData? holiday;
  final bool isFromEdit;
  final HolidayController controller = Get.find();

  AddHolidayScreen({super.key, this.holiday, this.isFromEdit = false});

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  ///  New validator to check date logic
  String? dateRangeValidator() {
    final start = controller.selectedStartDate.value;
    final end = controller.selectedEndDate.value;

    if (start != null && end != null) {
      if (start.isBefore(DateTime.now())) {
        return "Start Date cannot be in the past";
      }
      if (start.isAfter(end)) {
        return "Start Date cannot be later than End Date";
      }
      if (start == end) {
        return "Start Date and End Date cannot be same";
      }
    }
    return null;
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final initialDate =
        isStart
            ? controller.selectedStartDate.value ?? DateTime.now()
            : controller.selectedEndDate.value ?? DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (isStart) {
        controller.selectedStartDate.value = picked;
        controller.startDateController.text = DateFormat(
          'dd-MM-yyyy',
        ).format(picked);
      } else {
        controller.selectedEndDate.value = picked;
        controller.endDateController.text = DateFormat(
          'dd-MM-yyyy',
        ).format(picked);
      }
    }
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;

    //  Extra manual check in case validator not triggered
    final dateError = dateRangeValidator();
    if (dateError != null) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Invalid Dates",
        message: dateError,
        contentType: ContentType.failure,
      );
      return;
    }

    final holidayData = HolidayData(
      holidayName: controller.holidayNameController.text,
      leaveType: controller.selectedLeaveType.value,
      startDate: controller.selectedStartDate.value?.toIso8601String(),
      endDate: controller.selectedEndDate.value?.toIso8601String(),
      section: "holiday",
    );
    print("[DEBUG]=> ${holidayData.toJson()}");

    controller.isLoading.value = true;
    final success = await controller.createHoliday(holidayData);
    controller.isLoading.value = false;

    if (success) Get.back();
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message: success ? "Holiday added successfully" : "Failed to add holiday",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  void _update() async {
    if (!controller.formKey.currentState!.validate()) return;

    //  Extra manual check in case validator not triggered
    final dateError = dateRangeValidator();
    if (dateError != null) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Invalid Dates",
        message: dateError,
        contentType: ContentType.failure,
      );
      return;
    }

    final holidayData = HolidayData(
      holidayName: controller.holidayNameController.text,
      leaveType: controller.selectedLeaveType.value,
      startDate: controller.selectedStartDate.value?.toIso8601String(),
      endDate: controller.selectedEndDate.value?.toIso8601String(),
      section: "holiday",
    );
    print("[DEBUG]=> ${holidayData.toJson()}");

    controller.isLoading.value = true;
    final success = await controller.updateHoliday(holiday!.id!, holidayData);
    controller.isLoading.value = false;

    if (success) {
      Get.back();
      controller.loadInitial();
    }
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message:
          success ? "Holiday updated successfully" : "Failed to update holiday",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isFromEdit && holiday != null) {
      controller.holidayNameController.text = holiday!.holidayName ?? '';
      controller.selectedLeaveType.value = holiday!.leaveType ?? '';
      if (holiday!.startDate != null) {
        final start = DateTime.tryParse(holiday!.startDate!);
        if (start != null) {
          controller.selectedStartDate.value = start;
          controller.startDateController.text = DateFormat(
            'dd-MM-yyyy',
          ).format(start);
        }
      }
      if (holiday!.endDate != null) {
        final end = DateTime.tryParse(holiday!.endDate!);
        if (end != null) {
          controller.selectedEndDate.value = end;
          controller.endDateController.text = DateFormat(
            'dd-MM-yyyy',
          ).format(end);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(isFromEdit ? 'Edit Holiday' : 'Add Holiday')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              /// Holiday Name
              CrmTextField(
                controller: controller.holidayNameController,
                title: 'Holiday Name',
                isRequired: true,
                validator:
                    (value) =>
                        requiredValidator(value, 'Holiday Name is required'),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Leave Type Dropdown
              Obx(
                () => CrmDropdownField<String>(
                  title: 'Leave Type',
                  value: controller.selectedLeaveType.value,
                  items:
                      controller.leaveTypes
                          .map(
                            (type) => DropdownMenuItem<String>(
                              value: type,
                              child: Text(type.capitalizeFirst!),
                            ),
                          )
                          .toList(),
                  onChanged: (val) => controller.selectedLeaveType.value = val!,
                  isRequired: true,
                ),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Start Date
              GestureDetector(
                onTap: () => _pickDate(context, true),
                child: AbsorbPointer(
                  child: CrmTextField(
                    controller: controller.startDateController,
                    title: 'Start Date',
                    isRequired: true,
                    validator:
                        (value) =>
                            requiredValidator(value, 'Start Date is required'),
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.medium),

              /// End Date
              GestureDetector(
                onTap: () => _pickDate(context, false),
                child: AbsorbPointer(
                  child: CrmTextField(
                    controller: controller.endDateController,
                    title: 'End Date',
                    isRequired: true,
                    validator:
                        (value) =>
                            requiredValidator(value, 'End Date is required'),
                  ),
                ),
              ),
              SizedBox(height: 24),

              Obx(
                () =>
                    controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CrmButton(
                          width: double.infinity,
                          onTap: isFromEdit ? _update : _submit,
                          title:
                              isFromEdit ? 'Update Holiday' : 'Create Holiday',
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
