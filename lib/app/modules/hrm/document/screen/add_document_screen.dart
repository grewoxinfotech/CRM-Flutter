import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/data/network/hrm/document/document_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../widgets/button/crm_button.dart';
import '../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/document_controller.dart';

class AddDocumentScreen extends StatelessWidget {
  DocumentData? document;
  final bool isFromEdit;
  final DocumentController controller = Get.find();

  AddDocumentScreen({super.key, this.isFromEdit = false,this.document});

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      controller.selectedFile.value = File(result.files.single.path!);
    }
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;
    if (controller.selectedRole.value.isEmpty) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Role is required",
        contentType: ContentType.failure,
      );
      return;
    }
    if (controller.selectedFile.value == null) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Please upload a file",
        contentType: ContentType.failure,
      );
      return;
    }

    final docData = DocumentData(
      name: controller.nameController.text,
      role: controller.selectedRole.value,
      description: controller.descriptionController.text, // Binary file
    );
    print("[DEBUG]=> $docData");

    controller.isLoading.value = true;
    final success = await controller.createDocument(docData,controller.selectedFile.value);
    controller.isLoading.value = false;

    if (success) Get.back();
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message: success ? "Document uploaded successfully" : "Failed to upload document",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  void _update() async {
    if (!controller.formKey.currentState!.validate()) return;
    if (controller.selectedRole.value.isEmpty) {
      CrmSnackBar.showAwesomeSnackbar(
        title: "Error",
        message: "Role is required",
        contentType: ContentType.failure,
      );
      return;
    }


    final docData = DocumentData(
      name: controller.nameController.text,
      role: controller.selectedRole.value,
      description: controller.descriptionController.text,
    );
    print("[DEBUG][UPDATE] => $docData");


    controller.isLoading.value = true;
    final success = await controller.updateDocument(
      document!.id!,
      docData,
      controller.selectedFile.value,
    );
    controller.isLoading.value = false;

    if (success) {
      Get.back();
      controller.loadInitial();
    }
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message: success ? "Document updated successfully" : "Failed to update document",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }


  @override
  Widget build(BuildContext context) {
    if(isFromEdit && document != null){
      controller.nameController.text = document!.name!;
      controller.selectedRole.value = document!.role!;
      controller.descriptionController.text = document!.description!;
    }
    return Scaffold(
      appBar: AppBar(title: Text(isFromEdit ? 'Edit Document' : 'Add Document')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              /// Name
              CrmTextField(
                controller: controller.nameController,
                title: 'Document Name',
                isRequired: true,
                validator: (value) =>
                    requiredValidator(value, 'Document Name is required'),
              ),
              const SizedBox(height: 16),

              /// Role (Dropdown)
              Obx(
                    () => CrmDropdownField<String>(
                  title: 'Role',
                  value: controller.selectedRole.value.isNotEmpty
                      ? controller.selectedRole.value
                      : null,
                  items: const [
                    DropdownMenuItem(value: "manager", child: Text("Manager")),
                    DropdownMenuItem(value: "employee", child: Text("Employee")),
                    DropdownMenuItem(value: "admin", child: Text("Admin")),
                    DropdownMenuItem(value: "hr", child: Text("HR")),
                  ],
                  onChanged: (role) => controller.selectedRole.value = role ?? "",
                  isRequired: true,
                ),
              ),
              const SizedBox(height: 16),

              /// Description
              CrmTextField(
                controller: controller.descriptionController,
                title: 'Description',
                maxLines: 3,
                isRequired: true,
                validator: (value) =>
                    requiredValidator(value, 'Description is required'),
              ),
              const SizedBox(height: 16),

              /// File Upload
              Obx(
                    () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Upload File *",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickFile,
                          icon: const Icon(Icons.upload_file),
                          label: const Text("Choose File"),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            controller.selectedFile.value != null
                                ? controller.selectedFile.value!.path.split('/').last
                                : "No file chosen",
                            style: const TextStyle(color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// Submit Button
              Obx(
                    () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CrmButton(
                  width: double.infinity,
                  onTap: isFromEdit? _update:_submit,
                  title: isFromEdit ? 'Update Document' : 'Create Document',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
