import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/network/hrm/hrm_system/designation/designation_model.dart';
import '../controllers/designation_controller.dart';

class AddDesignationScreen extends StatelessWidget {
  final DesignationData? designation;
  final bool isFromEdit;
  final DesignationController controller = Get.find();

  AddDesignationScreen({super.key, this.designation, this.isFromEdit = false});

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;

    final designationData = DesignationData(
      designationName: controller.designationNameController.text,
      branch: controller.selectedBranch.value,
    );
    print("[DEBUG]=> ${designationData.toJson()}");

    controller.isLoading.value = true;
    final success = await controller.createDesignation(designationData);

    controller.isLoading.value = false;
    if (success) Get.back();
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message:
          success
              ? "Designation added successfully"
              : "Failed to add designation",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  void _update() async {
    if (!controller.formKey.currentState!.validate()) return;

    final designationData = DesignationData(
      designationName: controller.designationNameController.text,
      branch: controller.selectedBranch.value,
    );
    print("[DEBUG]=> ${designationData.toJson()}");

    controller.isLoading.value = true;
    final success = await controller.updateDesignation(
      designation!.id!,
      designationData,
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
              ? "Designation updated successfully"
              : "Failed to update designation",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isFromEdit && designation != null) {
      controller.designationNameController.text =
          designation!.designationName ?? '';
      controller.selectedBranch.value = designation!.branch ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isFromEdit ? 'Edit Designation' : 'Add Designation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              /// Designation Name
              CrmTextField(
                controller: controller.designationNameController,
                title: 'Designation Name',
                isRequired: true,
                validator:
                    (value) => requiredValidator(
                      value,
                      'Designation Name is required',
                    ),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Branch Dropdown
              Obx(
                () => CrmDropdownField<String>(
                  title: 'Branch',
                  value: controller.selectedBranch.value,
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

              Obx(
                () =>
                    controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CrmButton(
                          width: double.infinity,
                          onTap: isFromEdit ? _update : _submit,
                          title:
                              isFromEdit
                                  ? 'Update Designation'
                                  : 'Create Designation',
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
