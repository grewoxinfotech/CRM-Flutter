import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/hrm/employee/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/network/hrm/hrm_system/branch/branch_model.dart';
import '../../../../widgets/button/crm_button.dart';
import '../../../../widgets/common/inputs/crm_dropdown_field.dart';
import '../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/branch_controller.dart';

// assuming managers are employees

class AddBranchScreen extends StatelessWidget {
  final BranchData? branch;
  final bool isFromEdit;
  final BranchController controller = Get.find();

  AddBranchScreen({super.key, this.branch, this.isFromEdit = false});

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;
    // if (!_formKey.currentState!.validate() || selectedManager == null) return;

    final branch = BranchData(
      branchName: controller.branchNameController.text,
      branchAddress: controller.branchAddressController.text,
      branchManager: "7dzE4fFaAfNtBUNDxW0xmci",
      // branchManager: selectedManager!.id,
    );
    print("[DEBUG]=> ${branch.toJson()}");
    controller.isLoading.value = true;
    final success = await controller.createBranch(branch);

    controller.isLoading.value = false;
    if (success) Get.back();
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message: success ? "Branch added successfully" : "Failed to add branch",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  void _update() async {
    if (!controller.formKey.currentState!.validate()) return;
    // if (!_formKey.currentState!.validate() || selectedManager == null) return;

    final branchData = BranchData(
      branchName: controller.branchNameController.text,
      branchAddress: controller.branchAddressController.text,
      branchManager: "7dzE4fFaAfNtBUNDxW0xmci",
      // branchManager: selectedManager!.id,
    );
    print("[DEBUG]=> ${branchData.toJson()}");
    controller.isLoading.value = true;
    final success = await controller.updateBranch(branch!.id!, branchData);

    controller.isLoading.value = false;
    if (success) Get.back();
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message: success ? "Branch Updated successfully" : "Failed to add branch",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isFromEdit) {
      controller.selectedManager.value = branch!.branchManager!;
      controller.branchNameController.text = branch!.branchName!;
      controller.branchAddressController.text = branch!.branchAddress!;
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Add Branch')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              /// Branch Name
              CrmTextField(
                controller: controller.branchNameController,
                title: 'Branch Name',
                isRequired: true,
                validator:
                    (value) =>
                        requiredValidator(value, 'Branch Name is required'),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Branch Manager (Dropdown)
              Obx(
                () => CrmDropdownField<String>(
                  title: 'Branch Manager',
                  value: controller.selectedManager.value,
                  items: const [
                    DropdownMenuItem<String>(
                      value: "7dzE4fFaAfNtBUNDxW0xmci",
                      child: Text("Manager A"),
                    ),
                    DropdownMenuItem<String>(
                      value: "8aaE5fFaZxNtBUNDyW9xyzi",
                      child: Text("Manager B"),
                    ),
                  ],
                  onChanged: (manager) {
                    controller.selectedManager.value = manager;
                  },
                  isRequired: true,
                ),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Branch Address
              CrmTextField(
                controller: controller.branchAddressController,
                title: 'Branch Address',
                maxLines: 3,
                isRequired: true,
                validator:
                    (value) =>
                        requiredValidator(value, 'Branch Address is required'),
              ),

              const SizedBox(height: 24),

              Obx(
                () =>
                    controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CrmButton(
                          width: double.infinity,
                          onTap: isFromEdit ? _update : _submit,
                          title: isFromEdit ? 'Update Branch' : 'Create Branch',
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
