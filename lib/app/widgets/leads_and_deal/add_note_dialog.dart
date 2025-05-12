import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/modules/crm/notes/controllers/note_controller.dart';

class AddNoteDialog extends StatelessWidget {
  final String leadId;
  final NoteController controller;
  final VoidCallback? onSuccess;

  const AddNoteDialog({
    super.key,
    required this.leadId,
    required this.controller,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Note'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CrmTextField(
              title: "Note Title",
              controller: controller.noteTitleController,
              hintText: "Enter note title",
              isRequired: true,
            ),
            const SizedBox(height: AppPadding.medium),
            Obx(() => CrmDropdownField<String>(
              title: "Note Type",
              value: controller.selectedNoteType.value.isEmpty ? null : controller.selectedNoteType.value,
              items: controller.noteTypeOptions.map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              )).toList(),
              onChanged: (value) => controller.selectedNoteType.value = value ?? '',
              isRequired: true,
              hintText: "Select note type",
            )),
            const SizedBox(height: AppPadding.medium),
            CrmTextField(
              title: "Description",
              controller: controller.noteDescriptionController,
              hintText: "Enter note description",
              isRequired: true,
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        Obx(() => CrmButton(
          title: controller.isLoading.value ? "Creating..." : "Create Note",
          onTap: controller.isLoading.value ? null : () async {
            final success = await controller.createNoteForLead(leadId);
            if (success) {
              Get.back();
              onSuccess?.call();
            }
          },
        )),
      ],
    );
  }
} 