import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/network/hrm/announcement/announcement_model.dart';
import '../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../controllers/announcement_controller.dart';

class AddAnnouncementScreen extends StatelessWidget {
  final AnnouncementData? announcement;
  final bool isFromEdit;
  final AnnouncementController controller = Get.find();

  AddAnnouncementScreen({
    super.key,
    this.announcement,
    this.isFromEdit = false,
  });

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  ///  New validator to check date logic
  // String? dateRangeValidator() {
  //   final start = controller.selectedDate.value;
  //
  //   if (start != null) {
  //     if (start.isBefore(DateTime.now())) {
  //       return "Date cannot be in the past";
  //     }
  //   }
  //   return null;
  // }

  /// Date cannot be before today
  String? dateRangeValidator() {
    final selected = controller.selectedDate.value;
    if (selected != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day); // midnight today
      final selectedDate = DateTime(
        selected.year,
        selected.month,
        selected.day,
      );

      if (selectedDate.isBefore(today)) {
        return "Date cannot be in the past";
      }
    }
    return null;
  }

  String? timeRangeValidator() {
    final time = controller.selectedTime.value;
    final date = controller.selectedDate.value;

    if (time != null && date != null) {
      final now = DateTime.now();

      // Check if selected date is today
      final isToday =
          date.year == now.year &&
          date.month == now.month &&
          date.day == now.day;

      if (isToday) {
        // Convert TimeOfDay to DateTime for comparison
        final selectedDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          time.hour,
          time.minute,
        );

        if (selectedDateTime.isBefore(now)) {
          return "Time cannot be in the past";
        }
      }
    }
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

  Future<void> _pickTime(BuildContext context) async {
    final initialTime = controller.selectedTime.value ?? TimeOfDay.now();

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      controller.selectedTime.value = picked;
      controller.timeController.text = picked.format(context); // e.g. 10:30 AM
    }
  }

  String? formatTimeOfDay(TimeOfDay? tod) {
    if (tod == null) return null;
    final hour = tod.hour.toString().padLeft(2, '0');
    final minute = tod.minute.toString().padLeft(2, '0');
    return "$hour:$minute:00"; // returns HH:mm:ss
  }

  /// Create
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

    final announcementData = AnnouncementData(
      branch: Branch(branch: controller.selectedBranch),
      title: controller.titleController.text,
      description: controller.descriptionController.text,
      date: controller.selectedDate.value?.toIso8601String(),
      time: formatTimeOfDay(controller.selectedTime.value),
      section: "announcement",
    );

    controller.isLoading.value = true;
    final success = await controller.createAnnouncement(announcementData);
    controller.isLoading.value = false;

    if (success) Get.back();
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message:
          success
              ? "Announcement added successfully"
              : "Failed to add announcement",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  /// Update
  void _update() async {
    if (!controller.formKey.currentState!.validate()) return;

    final announcementData = AnnouncementData(
      branch: Branch(branch: controller.selectedBranch),
      title: controller.titleController.text,
      description: controller.descriptionController.text,
      date: controller.selectedDate.value?.toIso8601String(),
      time: formatTimeOfDay(controller.selectedTime.value),
      section: "announcement",
    );

    controller.isLoading.value = true;
    final success = await controller.updateAnnouncement(
      announcement!.id!,
      announcementData,
    );
    controller.isLoading.value = false;

    if (success) {
      Get.back();
      controller.loadInitial();
    }

    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message:
          success
              ? "Announcement updated successfully"
              : "Failed to update announcement",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isFromEdit && announcement != null) {
      controller.titleController.text = announcement!.title ?? '';
      controller.descriptionController.text = announcement!.description ?? '';
      controller.selectedDate.value = DateTime.tryParse(announcement!.date!);
      if (announcement!.date != null) {
        final date = DateTime.tryParse(announcement!.date!);
        controller.selectedDate.value = date;
        controller.dateController.text = DateFormat('yyyy-MM-dd').format(date!);
      }
      // Time
      if (announcement!.time != null) {
        try {
          final parsedTime = DateFormat("HH:mm:ss").parse(announcement!.time!);
          controller.selectedTime.value = TimeOfDay(
            hour: parsedTime.hour,
            minute: parsedTime.minute,
          );
          controller.timeController.text = DateFormat(
            'HH:mm',
          ).format(parsedTime);
        } catch (e) {
          print("Time parsing failed: $e");
        }
      }

      if (announcement!.branch != null &&
          announcement!.branch!.branch != null &&
          announcement!.branch!.branch!.isNotEmpty) {
        // announcement.branch!.branch is a list of branch IDs
        controller.selectedBranch.value = announcement!.branch!.branch!;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isFromEdit ? 'Edit Announcement' : 'Add Announcement'),
      ),
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
                title: 'Title',
                isRequired: true,
                validator:
                    (value) => requiredValidator(value, 'Title is required'),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Branch Dropdown
              Obx(
                () => CrmDropdownField<String>(
                  title: 'Branch',
                  value: controller.selectedBranch,
                  isMultiSelect: true,
                  items:
                      controller.branches
                          .map(
                            (branch) => DropdownMenuItem<String>(
                              value: branch.id!,
                              child: Text(branch.branchName ?? ''),
                            ),
                          )
                          .toList(),
                  onChanged: (branchId) {
                    controller.selectedBranch.value = branchId!;
                  },
                  isRequired: true,
                ),
              ),

              const SizedBox(height: 24),

              /// Description
              CrmTextField(
                controller: controller.descriptionController,
                title: 'Description',
                maxLines: 4,
                isRequired: true,
                validator:
                    (value) =>
                        requiredValidator(value, 'Description is required'),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Date Picker
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pickDate(context),
                      child: AbsorbPointer(
                        child: CrmTextField(
                          controller: controller.dateController,
                          title: 'Date',
                          isRequired: true,
                          suffixIcon: const Icon(Icons.calendar_today),
                          validator:
                              (value) =>
                                  requiredValidator(value, 'Date is required'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.medium),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _pickTime(context),
                      child: AbsorbPointer(
                        child: CrmTextField(
                          controller: controller.timeController,
                          title: 'Time',
                          isRequired: true,
                          suffixIcon: const Icon(Icons.access_time),
                          validator:
                              (value) =>
                                  requiredValidator(value, 'Date is required'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Obx(
              //   () => ListTile(
              //     title: Text(
              //       controller.selectedDate.value != null
              //           ? "Date: ${DateFormat('yyyy-MM-dd').format(controller.selectedDate.value!)}"
              //           : "Select Date",
              //     ),
              //     trailing: const Icon(Icons.calendar_today),
              //     onTap: () async {
              //       final picked = await showDatePicker(
              //         context: context,
              //         initialDate:
              //             controller.selectedDate.value ?? DateTime.now(),
              //         firstDate: DateTime(2000),
              //         lastDate: DateTime(2100),
              //       );
              //       if (picked != null) {
              //         controller.selectedDate.value = picked;
              //       }
              //     },
              //   ),
              // ),
              const SizedBox(height: 24),

              /// Button
              Obx(
                () =>
                    controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CrmButton(
                          width: double.infinity,
                          onTap: isFromEdit ? _update : _submit,
                          title:
                              isFromEdit
                                  ? 'Update Announcement'
                                  : 'Create Announcement',
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
