import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/crm/follow_Ups/follow_ups_task/controller/followup_task_controller.dart';
import 'package:crm_flutter/app/data/network/crm/follow_Ups/follow_ups_task/model/followup_task_model.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_text_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_date_picker.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_time_picker.dart';

class FollowUpAddScreen extends StatelessWidget {
  final String dealId;
  final String section;

  FollowUpAddScreen({
    Key? key,
    required this.dealId,
    this.section = 'deal',
  }) : super(key: key);

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FollowUpTaskController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Follow-up Task'),
        leading: const CrmBackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppPadding.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CrmTextField(
              title: 'Subject',
              controller: subjectController,
              hintText: 'Enter task subject',
            ),
            const SizedBox(height: AppPadding.medium),
            
            CrmDropdownField<String>(
              title: 'Priority',
              items: const ['highest', 'high', 'medium', 'low'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              value: controller.selectedPriority.value,
              onChanged: (value) => controller.selectedPriority.value = value ?? 'medium',
            ),
            const SizedBox(height: AppPadding.medium),

            CrmDatePicker(
              label: 'Due Date',
              selectedDate: controller.dueDate.value,
              onDateSelected: (date) => controller.dueDate.value = date,
            ),
            const SizedBox(height: AppPadding.medium),

            // Reminder Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reminder',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppPadding.small),
                    CrmDatePicker(
                      label: 'Reminder Date',
                      selectedDate: controller.reminderDate.value,
                      onDateSelected: (date) => controller.reminderDate.value = date,
                    ),
                    const SizedBox(height: AppPadding.small),
                    CrmTimePicker(
                      label: 'Reminder Time',
                      selectedTime: controller.reminderTime.value,
                      onTimeSelected: (time) => controller.reminderTime.value = time,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppPadding.medium),

            // Repeat Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Repeat',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppPadding.small),
                    CrmDropdownField<String>(
                      title: 'Repeat Type',
                      items: const ['none', 'daily', 'weekly', 'monthly', 'yearly'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      value: controller.repeatType.value,
                      onChanged: (value) => controller.repeatType.value = value ?? 'none',
                    ),
                    if (controller.repeatType.value != 'none') ...[
                      const SizedBox(height: AppPadding.small),
                      CrmDropdownField<String>(
                        title: 'End Type',
                        items: const ['never', 'after', 'on_date'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        value: controller.repeatEndType.value,
                        onChanged: (value) => controller.repeatEndType.value = value ?? 'never',
                      ),
                      if (controller.repeatEndType.value == 'after')
                        CrmTextField(
                          title: 'Number of Times',
                          controller: controller.repeatTimesController,
                          keyboardType: TextInputType.number,
                        ),
                      if (controller.repeatEndType.value == 'on_date')
                        CrmDatePicker(
                          label: 'End Date',
                          selectedDate: controller.repeatEndDate.value,
                          onDateSelected: (date) => controller.repeatEndDate.value = date,
                        ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppPadding.medium),

            CrmTextField(
              title: 'Description',
              controller: descriptionController,
              hintText: 'Enter task description',
              maxLines: 4,
            ),
            const SizedBox(height: AppPadding.large),

            CrmTextButton(
              text: 'Create Task',
              onPressed: () async {
                final task = FollowUpTaskModel(
                  subject: subjectController.text,
                  description: descriptionController.text,
                  dueDate: controller.dueDate.value?.toIso8601String(),
                  priority: controller.selectedPriority.value,
                  status: 'in_progress',
                  reminder: Reminder(
                    reminderDate: controller.reminderDate.value?.toIso8601String(),
                    reminderTime: controller.reminderTime.value?.format(context),
                  ),
                  repeat: controller.repeatType.value != 'none'
                      ? Repeat(
                          repeatType: controller.repeatType.value,
                          repeatEndType: controller.repeatEndType.value,
                          repeatTimes: int.tryParse(controller.repeatTimesController.text),
                          repeatEndDate: controller.repeatEndDate.value?.toIso8601String(),
                          repeatStartDate: controller.dueDate.value?.toIso8601String(),
                          repeatStartTime: controller.reminderTime.value?.format(context),
                        )
                      : null,
                  relatedId: dealId,
                );

                final success = await controller.createTask(task);
                if (success) {
                  Get.back();
                  Get.snackbar(
                    'Success',
                    'Follow-up task created successfully',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
