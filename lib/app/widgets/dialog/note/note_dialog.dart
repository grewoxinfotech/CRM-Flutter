import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/modules/crm/notes/controllers/note_controller.dart';
import 'package:crm_flutter/app/data/network/crm/notes/model/note_model.dart';

class NoteDialog extends StatelessWidget {
  final String leadId;
  final NoteController controller;
  final VoidCallback? onSuccess;
  final NoteModel? note; 

  const NoteDialog({
    super.key,
    required this.leadId,
    required this.controller,
    this.onSuccess,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    if (note != null) {
      controller.noteTitleController.text = note!.noteTitle;
      controller.noteDescriptionController.text = note!.description;
      controller.selectedNoteType.value = note!.notetype;
    }

    return AlertDialog(
      title: Text(note == null ? 'Add Note' : 'Edit Note'),
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
              value: controller.selectedNoteType.value,
              items: controller.noteTypeOptions.map((type) => DropdownMenuItem(
                value: type,
                child: Text(type),
              )).toList(),
              onChanged: (value) => controller.selectedNoteType.value = value ?? 'normal',
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
          title: controller.isLoading.value 
              ? (note == null ? "Creating..." : "Updating...") 
              : (note == null ? "Create Note" : "Update Note"),
          onTap: controller.isLoading.value ? null : () async {
            if (note == null) {
              await controller.createNoteForLead(leadId);
            } else {
              await controller.updateNoteForLead(leadId, note!.id);
            }
            Get.back();
            onSuccess?.call();
          },
        )),
      ],
    );
  }
} 