import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/job/interview_schedule/interview_schedule_model.dart';
import '../../../../../data/network/job/job_applications/job_application_model.dart';
import '../../../../../data/network/job/job_list/job_list_model.dart';
import '../../../../../data/network/user/all_users/model/all_users_model.dart';
import '../controllers/interview_schedule_controller.dart';
import '../../../../../widgets/button/crm_button.dart';
import '../../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';

class AddInterviewScheduleScreen extends StatelessWidget {
  final DateTime? selectedDate;
  final bool isFromEdit;
  final InterviewScheduleData? interviewSchedule;
  final InterviewScheduleController controller = Get.find();

  AddInterviewScheduleScreen({
    super.key,
    this.selectedDate,
    this.isFromEdit = false,
    this.interviewSchedule,
  });

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  /// Pick date
  Future<void> pickDate({
    required BuildContext context,
    required TextEditingController controllerField,
    required Rxn<DateTime?> target,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      controllerField.text = DateFormat('yyyy-MM-dd').format(picked);
      target.value = picked;
    }
  }

  /// Pick time
  Future<void> pickTime({
    required BuildContext context,
    required TextEditingController controllerField,
    required Rxn<TimeOfDay?> target,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      controllerField.text = picked.format(context);
      target.value = picked;
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm:ss').format(dt);
  }


  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;

    print("[DEBUG]=> startTime : ${controller.selectedStartTime.value}");

    String startTimeString = controller.selectedStartTime.value != null
        ? _formatTimeOfDay(controller.selectedStartTime.value!)
        : '';

    final newSchedule = InterviewScheduleData(
      job: controller.selectedJobPosition.value?.id,
      candidate: controller.selectedJobApplication.value?.id,
      interviewer: controller.selectedManager.value?.id,
      round: controller.selectedInterviewRound.value,
      interviewType: controller.selectedInterviewType.value,
      startOn: controller.selectedDay.value!.toIso8601String(),
      startTime: startTimeString,
      commentForInterviewer: controller.commentForInterviewerController.text,
      commentForCandidate: controller.commentForCandidateController.text,
    );

    controller.isLoading.value = true;
    final success = await controller.createInterviewSchedule(newSchedule);
    controller.isLoading.value = false;

    if (success) Get.back();
  }

  void _update() async {
    if (!controller.formKey.currentState!.validate()) return;
    if (interviewSchedule == null) return;

    final updatedSchedule = InterviewScheduleData(
      id: interviewSchedule!.id,
      job: controller.selectedJobPosition.value?.id,
      candidate: controller.selectedJobApplication.value?.id,
      interviewer: controller.selectedManager.value?.id,
      round: controller.selectedInterviewRound.value,
      interviewType: controller.selectedInterviewType.value,
      startOn: controller.selectedDay.value!.toIso8601String(),
      startTime: controller.selectedStartTime.value.toString(),
      commentForInterviewer: controller.commentForInterviewerController.text,
      commentForCandidate: controller.commentForCandidateController.text,
    );

    controller.isLoading.value = true;
    final success = await controller.updateInterviewSchedule(
      interviewSchedule!.id!,
      updatedSchedule,
    );
    controller.isLoading.value = false;

    if (success) Get.back();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedDate != null) {
      controller.startOnController.text = DateFormat(
        'yyyy-MM-dd',
      ).format(selectedDate!);
      controller.selectedDay.value = selectedDate;
    }
    // Pre-fill fields if editing
    // if (isFromEdit && interviewSchedule != null) {
    //   controller.sele.text = interviewSchedule!.job ?? '';
    //   controller.candidateController.text = interviewSchedule!.candidate ?? '';
    //   controller.interviewerController.text = interviewSchedule!.interviewer ?? '';
    //   controller.roundController.text = interviewSchedule!.round ?? '';
    //   controller.interviewTypeController.text = interviewSchedule!.interviewType ?? '';
    //   controller.startOnController.text = interviewSchedule!.startOn ?? '';
    //   controller.startTimeController.text = interviewSchedule!.startTime ?? '';
    //   controller.commentForInterviewerController.text = interviewSchedule!.commentForInterviewer ?? '';
    //   controller.commentForCandidateController.text = interviewSchedule!.commentForCandidate ?? '';
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isFromEdit ? 'Edit Interview Schedule' : 'Add Interview Schedule',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              /// Job
              Obx(
                () => CrmDropdownField<JobData>(
                  title: 'Job Position',
                  isRequired: true,
                  value: controller.selectedJobPosition.value,
                  items:
                      controller.jobPositions
                          .map(
                            (e) => DropdownMenuItem<JobData>(
                              value: e,
                              child: Text(e.title ?? ''),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    controller.selectedJobPosition.value = value;
                  },
                ),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Candidate
              Obx(
                () => CrmDropdownField<JobApplicationData>(
                  title: 'Job Candidate',
                  isRequired: true,
                  value: controller.selectedJobApplication.value,
                  items:
                      controller.jobApplications
                          .map(
                            (e) => DropdownMenuItem<JobApplicationData>(
                              value: e,
                              child: Text(e.name ?? ''),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    controller.selectedJobApplication.value = value;
                  },
                ),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Interviewer
              Obx(
                () => CrmDropdownField<User>(
                  title: 'Branch Manager',
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

              /// Round
              // CrmTextField(
              //   controller: controller.roundController,
              //   title: 'Round',
              //   isRequired: true,
              //   validator: (v) => requiredValidator(v, 'Please enter round'),
              // ),
              Obx(
                () => CrmDropdownField(
                  title: 'Round',
                  isMultiSelect: true,
                  isRequired: true,

                  value: controller.selectedInterviewRound.value,
                  items:
                      controller.interviewRoundList
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.capitalize.toString()),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    controller.selectedInterviewRound.value = value!;
                  },
                ),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Interview Type
              CrmDropdownField<String>(
                title: 'Interview Type',
                isRequired: true,
                value: controller.selectedInterviewType.value,
                items:
                    controller.interviewType
                        .map(
                          (type) =>
                              DropdownMenuItem(value: type, child: Text(type)),
                        )
                        .toList(),
                onChanged: (value) {
                  if (value != null)
                    controller.selectedInterviewType.value = value;
                },
              ),
              SizedBox(height: AppSpacing.medium),

              /// Date & Time
              Row(
                children: [
                  Expanded(
                    child: CrmTextField(
                      controller: controller.startOnController,
                      title: 'Start Date',
                      readOnly: true,
                      enabled: false,
                      isRequired: true,
                      // validator:
                      //     (v) => requiredValidator(v, 'Please select date'),
                      suffixIcon: const Icon(Icons.calendar_today_rounded),
                      // onTap:
                      //     () => pickDate(
                      //       context: context,
                      //       controllerField: controller.startOnController,
                      //       target: controller.selectedDay,
                      //     ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.small),
                  Expanded(
                    child:  CrmTextField(
                        controller: controller.startTimeController,
                        title: 'Start Time',
                        readOnly: true,
                        isRequired: true,
                        validator:
                            (v) => requiredValidator(v, 'Please select time'),
                        suffixIcon: const Icon(Icons.access_time_rounded),
                        onTap:
                            () => pickTime(
                              context: context,
                              controllerField: controller.startTimeController,
                              target: controller.selectedStartTime,
                            ),
                      ),
                    ),

                ],
              ),
              SizedBox(height: AppSpacing.medium),

              /// Comments for Interviewer
              CrmTextField(
                controller: controller.commentForInterviewerController,
                title: 'Comment for Interviewer',
                hintText: 'Optional',
                maxLines: 3,
              ),
              SizedBox(height: AppSpacing.medium),

              /// Comments for Candidate
              CrmTextField(
                controller: controller.commentForCandidateController,
                title: 'Comment for Candidate',
                hintText: 'Optional',
                maxLines: 3,
              ),
              SizedBox(height: AppSpacing.large),

              /// Submit Button
              Obx(
                () =>
                    controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CrmButton(
                          width: double.infinity,
                          onTap: isFromEdit ? _update : _submit,
                          title:
                              isFromEdit
                                  ? 'Update Interview'
                                  : 'Create Interview',
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
