import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

  Future<void> _pickDate(
    BuildContext context,
    TextEditingController dateCtrl,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dateCtrl.text = DateFormat("yyyy-MM-dd").format(picked);
    }
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;

    final leaveData = LeaveData(
      // employeeId: controller.selectedEmployeeId.value,
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

    final leaveData = LeaveData(
      // employeeId: controller.selectedEmployeeId.value,
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
      controller.startDateController.text = leave!.startDate ?? '';
      controller.endDateController.text = leave!.endDate ?? '';
      controller.selectedLeaveType.value = leave!.leaveType ?? '';
      controller.reasonController.text = leave!.reason ?? '';
      controller.isHalfDay.value = leave!.isHalfDay ?? false;
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
              /// Start Date
              CrmTextField(
                controller: controller.startDateController,
                title: "Start Date",
                isRequired: true,
                readOnly: true,
                onTap: () => _pickDate(context, controller.startDateController),
                validator:
                    (value) => requiredValidator(value, "Start date required"),
              ),
              SizedBox(height: AppSpacing.medium),

              /// End Date
              CrmTextField(
                controller: controller.endDateController,
                title: "End Date",
                isRequired: true,
                readOnly: true,
                onTap: () => _pickDate(context, controller.endDateController),
                validator:
                    (value) => requiredValidator(value, "End date required"),
              ),
              SizedBox(height: AppSpacing.medium),

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
              Obx(
                () => SwitchListTile(
                  title: const Text("Is Half Day"),
                  value: controller.isHalfDay.value,
                  activeColor: Colors.deepPurple,
                  onChanged: (val) => controller.isHalfDay.value = val,
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
