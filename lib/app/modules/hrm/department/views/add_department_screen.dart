import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/network/hrm/hrm_system/departments/department_model.dart';
import '../controllers/department_controller.dart';

class AddDepartmentScreen extends StatelessWidget {
  final DepartmentData? department;
  final bool isFromEdit;
  final DepartmentController controller = Get.find();

  AddDepartmentScreen({super.key, this.department, this.isFromEdit = false});

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;

    final departmentData = DepartmentData(
      departmentName: controller.departmentNameController.text,
      branch: controller.selectedBranch.value,
    );
    print("=> ${departmentData.toJson()}");

    controller.isLoading.value = true;
    final success = await controller.createDepartment(departmentData);

    controller.isLoading.value = false;
    if (success) Get.back();
  }

  void _update() async {
    if (!controller.formKey.currentState!.validate()) return;

    final departmentData = DepartmentData(
      departmentName: controller.departmentNameController.text,
      branch: controller.selectedBranch.value,
    );
    print("=> ${departmentData.toJson()}");

    controller.isLoading.value = true;
    final success = await controller.updateDepartment(
      department!.id!,
      departmentData,
    );

    controller.isLoading.value = false;
    if (success) {
      Get.back();
      controller.loadInitial();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFromEdit && department != null) {
      controller.departmentNameController.text =
          department!.departmentName ?? '';
      controller.selectedBranch.value = department!.branch ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isFromEdit ? 'Edit Department' : 'Add Department'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              /// Department Name
              CrmTextField(
                controller: controller.departmentNameController,
                title: 'Department Name',
                isRequired: true,
                validator:
                    (value) =>
                        requiredValidator(value, 'Department Name is required'),
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
                                  ? 'Update Department'
                                  : 'Create Department',
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
