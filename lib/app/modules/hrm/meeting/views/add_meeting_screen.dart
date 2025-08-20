import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../care/constants/size_manager.dart';
import '../../../../data/network/hrm/meeting/meeting_model.dart';
import '../../../../widgets/button/crm_button.dart';
import '../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/meeting_controller.dart';

class AddMeetingScreen extends StatelessWidget {
  final MeetingData? meeting;
  final bool isFromEdit;
  final MeetingController controller = Get.find();

  AddMeetingScreen({super.key, this.meeting, this.isFromEdit = false});

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  Future<void> _pickDate(BuildContext context) async {
    final initialDate = controller.selectedDate.value ?? DateTime.now();

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.selectedDate.value = picked;
      controller.dateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  String? _validateTimeRange() {
    final start = controller.selectedStartTime.value;
    final end = controller.selectedEndTime.value;

    if (start == null || end == null) {
      return "Please select both start and end times";
    }

    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    if (endMinutes <= startMinutes) {
      return "End time must be later than start time";
    }
  }

  Future<void> _pickTime(
    BuildContext context,
    TextEditingController timeCtrl,
    Rxn<TimeOfDay> time,
  ) async {
    final initialTime = time.value ?? TimeOfDay.now();

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      time.value = picked;
      timeCtrl.text = picked.format(context); // e.g. 10:30 AM
    }
  }

  String? formatTimeOfDay(TimeOfDay? tod) {
    if (tod == null) return null;
    final hour = tod.hour.toString().padLeft(2, '0');
    final minute = tod.minute.toString().padLeft(2, '0');
    return "$hour:$minute:00"; // returns HH:mm:ss
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;
    //  Extra manual check in case validator not triggered
    final timeError = _validateTimeRange();
    if (timeError != null) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Invalid Dates",
        message: timeError,
        contentType: ContentType.failure,
      );
      return;
    }

    final meetingData = MeetingData(
      title: controller.titleController.text,
      department: controller.selectedDepartment.value,
      section: "meeting",
      employee: controller.selectedEmployees,
      description: controller.descriptionController.text,
      date: controller.selectedDate.value?.toIso8601String().split("T").first,
      startTime: formatTimeOfDay(controller.selectedStartTime.value),
      endTime: formatTimeOfDay(controller.selectedEndTime.value),
      meetingLink: controller.meetingLinkController.text,
      status: controller.status.value,
    );

    print("[DEBUG]=> ${meetingData.toJson()}");

    controller.isLoading.value = true;
    final success = await controller.createMeeting(meetingData);

    controller.isLoading.value = false;
    if (success) Get.back();
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message:
          success ? "Meeting created successfully" : "Failed to create meeting",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  void _update() async {
    if (!controller.formKey.currentState!.validate()) return;

    final meetingData = MeetingData(
      title: controller.titleController.text,
      department: controller.selectedDepartment.value,
      section: "meeting",
      employee: controller.selectedEmployees,
      description: controller.descriptionController.text,
      date: controller.selectedDate.value?.toIso8601String().split("T").first,
      startTime: formatTimeOfDay(controller.selectedStartTime.value),
      endTime: formatTimeOfDay(controller.selectedEndTime.value),
      meetingLink: controller.meetingLinkController.text,
      status: controller.status.value,
    );

    print("[DEBUG]=> ${meetingData.toJson()}");

    controller.isLoading.value = true;
    final success = await controller.updateMeeting(meeting!.id!, meetingData);

    controller.isLoading.value = false;
    if (success) Get.back();
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message:
          success ? "Meeting updated successfully" : "Failed to update meeting",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isFromEdit && meeting != null) {
      controller.titleController.text = meeting!.title ?? "";
      controller.descriptionController.text = meeting!.description ?? "";
      controller.meetingLinkController.text = meeting!.meetingLink ?? "";
      controller.selectedDepartment.value = meeting!.department ?? "";
      controller.selectedEmployees.value = meeting!.employee ?? [];
      controller.status.value = meeting!.status ?? "scheduled";
      controller.selectedDate.value =
          meeting!.date != null ? DateTime.tryParse(meeting!.date!) : null;
    }

    return Scaffold(
      appBar: AppBar(title: Text(isFromEdit ? 'Edit Meeting' : 'Add Meeting')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              /// Title
              CrmTextField(
                controller: controller.titleController,
                title: 'Meeting Title',
                isRequired: true,
                validator:
                    (value) => requiredValidator(value, 'Title is required'),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Department Dropdown
              Obx(
                () => CrmDropdownField<String>(
                  title: "Department",
                  value:
                      controller.selectedDepartment.value.isNotEmpty
                          ? controller.selectedDepartment.value
                          : null,
                  items:
                      controller.departments
                          .map(
                            (d) => DropdownMenuItem<String>(
                              value: d.id!,
                              child: Text(d.departmentName ?? ""),
                            ),
                          )
                          .toList(),
                  onChanged: (val) {
                    if (val != null) controller.selectedDepartment.value = val;
                  },
                  isRequired: true,
                ),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Employees Dropdown (multi-select simulation)
              /// Branch Dropdown
              Obx(
                () => CrmDropdownField<String>(
                  title: 'Employee',
                  value: controller.selectedEmployees,
                  isMultiSelect: true,
                  items:
                      controller.employees
                          .map(
                            (employee) => DropdownMenuItem<String>(
                              value: employee.id!,
                              child: Text(employee.firstName ?? ''),
                            ),
                          )
                          .toList(),
                  onChanged: (branchId) {
                    controller.selectedEmployees.value = branchId!;
                  },
                  isRequired: true,
                ),
              ),

              SizedBox(height: AppSpacing.medium),

              /// Description
              CrmTextField(
                controller: controller.descriptionController,
                title: 'Description',
                maxLines: 3,
              ),
              SizedBox(height: AppSpacing.medium),

              /// Date Picker
              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: CrmTextField(
                    controller: controller.dateController,
                    title: 'Date',
                    isRequired: true,
                    suffixIcon: const Icon(Icons.calendar_today),
                    validator:
                        (value) => requiredValidator(value, 'Date is required'),
                  ),
                ),
              ),

              SizedBox(height: AppSpacing.medium),

              /// Start Time
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap:
                          () => _pickTime(
                            context,
                            controller.startTimeController,
                            controller.selectedStartTime,
                          ),
                      child: AbsorbPointer(
                        child: CrmTextField(
                          controller: controller.startTimeController,
                          title: 'Start Time',
                          isRequired: true,
                          suffixIcon: const Icon(Icons.access_time),
                          validator:
                              (value) =>
                                  requiredValidator(value, 'Time is required'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.medium),

                  /// End Time
                  Expanded(
                    child: GestureDetector(
                      onTap:
                          () => _pickTime(
                            context,
                            controller.endTimeController,
                            controller.selectedEndTime,
                          ),
                      child: AbsorbPointer(
                        child: CrmTextField(
                          controller: controller.endTimeController,
                          title: 'End Time',
                          isRequired: true,
                          suffixIcon: const Icon(Icons.access_time),
                          validator:
                              (value) =>
                                  requiredValidator(value, 'Time is required'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSpacing.medium),

              /// Meeting Link
              CrmTextField(
                controller: controller.meetingLinkController,
                title: 'Meeting Link',
              ),
              SizedBox(height: AppSpacing.medium),

              /// Status Dropdown
              Obx(
                () => CrmDropdownField<String>(
                  title: "Status",
                  value: controller.status.value,
                  items: const [
                    DropdownMenuItem(
                      value: "scheduled",
                      child: Text("Scheduled"),
                    ),
                    DropdownMenuItem(
                      value: "completed",
                      child: Text("Completed"),
                    ),
                    DropdownMenuItem(
                      value: "cancelled",
                      child: Text("Cancelled"),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) controller.status.value = val;
                  },
                  isRequired: true,
                ),
              ),

              const SizedBox(height: 24),

              Obx(
                () =>
                    controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CrmButton(
                          width: double.infinity,
                          onTap: isFromEdit ? _update : _submit,
                          title:
                              isFromEdit ? 'Update Meeting' : 'Create Meeting',
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
