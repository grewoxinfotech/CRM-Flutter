import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/network/hrm/employee/employee_model.dart';
import '../../../../data/network/hrm/hrm_system/leave_type/leave_types_model.dart';
import '../controllers/leave_controller.dart';

class AddLeaveScreen extends StatelessWidget {
  final LeaveData? leave;
  final bool isFromEdit;
  final LeaveController controller = Get.find();

  AddLeaveScreen({super.key, this.leave, this.isFromEdit = false});

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  String? dateRangeValidator() {
    final start = controller.selectedStartDate.value;
    final end = controller.selectedEndDate.value;

    if (start != null && end != null) {
      if (start.isBefore(DateTime.now()) || end.isBefore(DateTime.now())) {
        return "Date cannot be in the past";
      }
      if(controller.isHalfDay.value){
        if (start != end) {
          return "Start Date and End Date must be same for Half Day leave";
        }
      }else{
        if (start.isAfter(end)) {
          return "Start Date cannot be after End Date";
        }
      }
    }
    return null;
  }

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController dateCtrl,
      Rxn<DateTime> selected
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dateCtrl.text = DateFormat("yyyy-MM-dd").format(picked);
      selected.value = picked;
    }
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;

    if (dateRangeValidator() != null) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: dateRangeValidator()!,
        contentType: ContentType.failure,
      );
      return;
    }

    final leaveData = LeaveData(
      employeeId: controller.selectedEmployee.value?.id,
      startDate: controller.startDateController.text,
      endDate: controller.endDateController.text,
      leaveType: controller.selectedLeaveType.value,
      reason: controller.reasonController.text,
      isHalfDay: controller.isHalfDay.value,
    );
    print("[DEBUG]=> ${leaveData.toJson()}");

    controller.isLoading.value = true;
    final success = await controller.createLeave(leaveData);
    controller.isLoading.value = false;

    if (success) Get.back();
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message: success ? "Leave request submitted" : "Failed to submit leave",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  void _update() async {
    if (!controller.formKey.currentState!.validate()) return;

    if (dateRangeValidator() != null) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: dateRangeValidator()!,
        contentType: ContentType.failure,
      );
      return;
    }

    final leaveData = LeaveData(
      employeeId: controller.selectedEmployee.value?.id,
      startDate: controller.startDateController.text,
      endDate: controller.endDateController.text,
      leaveType: controller.selectedLeaveType.value,
      reason: controller.reasonController.text,
      isHalfDay: controller.isHalfDay.value,
    );
    print("[DEBUG]=> ${leaveData.toJson()}");

    controller.isLoading.value = true;
    final success = await controller.updateLeave(leave!.id!, leaveData);
    controller.isLoading.value = false;

    if (success) {
      Get.back();
      controller.loadInitial();
    }

    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message:
          success ? "Leave updated successfully" : "Failed to update leave",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isFromEdit && leave != null) {

        controller.getEmployeeById(leave!.employeeId!);

      if(leave!.startDate != null){
        final startDate = DateTime.parse(leave!.startDate!);
        if(startDate!=null){
          controller.selectedStartDate.value = startDate;
          controller.startDateController.text = DateFormat('yyyy-MM-dd').format(startDate);
        }
      }
      if(leave!.endDate != null){
        final endDate = DateTime.parse(leave!.endDate!);
        if(endDate!=null){
          controller.selectedEndDate.value = endDate;
          controller.endDateController.text = DateFormat('yyyy-MM-dd').format(endDate);

        }
      }
      controller.selectedLeaveType.value = leave!.leaveType!;
      controller.reasonController.text = leave!.reason!;
      controller.isHalfDay.value = leave!.isHalfDay!;
    }

    return Scaffold(
      appBar: AppBar(title: Text(isFromEdit ? "Edit Leave" : "Add Leave")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              /// Employee Dropdown
              Obx(
                    () => CrmDropdownField<EmployeeData>(
                  title: 'Select Employee',
                  isRequired: true,
                  value: controller.selectedEmployee.value,
                  items:
                  controller.employeeController.items.map((element) {
                    return DropdownMenuItem<EmployeeData>(
                      value: element,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${element.firstName} ${element.lastName}"),
                          const SizedBox(width: 8),
                          Text(element.designation ?? ''),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged:
                      (value) =>
                      controller.selectedEmployee.value = value,
                ),
              ),
              /// Leave Type
              Obx(
                    () => CrmDropdownField<String>(
                  title: "Leave Type",
                  value: controller.selectedLeaveType.value,
                  items:
                  controller.leaveTypes
                      .map(
                        (type) => DropdownMenuItem<String>(
                      value: type,
                      child: Text(type.capitalizeFirst ?? ''),
                    ),
                  )
                      .toList(),
                  onChanged:
                      (val) => controller.selectedLeaveType.value = val ?? '',
                  isRequired: true,
                ),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Start Date
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: controller.startDateController,
                      title: "Start Date",
                      isRequired: true,
                      readOnly: true,
                      onTap: () => _pickDate(context, controller.startDateController,controller.selectedStartDate),
                      validator:
                          (value) => requiredValidator(value, "Start date required"),
                    ),
                  ),
                  SizedBox(width: AppSpacing.medium),

                  /// End Date
                  Expanded(
                    child: CrmTextField(
                      controller: controller.endDateController,
                      title: "End Date",
                      isRequired: true,
                      readOnly: true,
                      onTap: () => _pickDate(context, controller.endDateController,controller.selectedEndDate),
                      validator:
                          (value) => requiredValidator(value, "End date required"),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.medium),



              /// Reason
              CrmTextField(
                controller: controller.reasonController,
                title: "Reason",
                isRequired: true,
                maxLines: 3,
                validator:
                    (value) => requiredValidator(value, "Reason is required"),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Half Day Toggle
              // Obx(
              //   () => SwitchListTile(
              //     title: const Text("Is Half Day"),
              //     value: controller.isHalfDay.value,
              //     activeColor: Colors.deepPurple,
              //     onChanged: (val) => controller.isHalfDay.value = val,
              //   ),
              // ),
              Obx(
                ()=> Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Is Half Day',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Switch(
                      value: controller.isHalfDay.value,
                      onChanged: (val) => controller.isHalfDay.value = val,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              /// Submit Button
              Obx(
                () =>
                    controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CrmButton(
                          width: double.infinity,
                          onTap: isFromEdit ? _update : _submit,
                          title: isFromEdit ? "Update Leave" : "Submit Leave",
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
