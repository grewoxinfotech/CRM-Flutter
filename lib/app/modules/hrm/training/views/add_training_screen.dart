import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../care/constants/size_manager.dart';
import '../../../../data/network/hrm/training/training_model.dart';
import '../../../../widgets/button/crm_button.dart';
import '../../../../widgets/common/inputs/crm_text_field.dart';
import '../../../../widgets/common/messages/crm_snack_bar.dart';
import '../controllers/training_controller.dart';

class AddTrainingScreen extends StatelessWidget {
  final TrainingData? training;
  final bool isFromEdit;
  final TrainingController controller = Get.find();

  AddTrainingScreen({super.key, this.training, this.isFromEdit = false});

  String? requiredValidator(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  void _submit() async {
    if (!controller.formKey.currentState!.validate()) return;

    final trainingData = TrainingData(
      category: controller.categoryController.text,
      title: controller.titleController.text,
      links: TrainingLinks(
        titles: controller.linkTitleControllers.map((c) => c.text).toList(),
        urls:
            controller.linkUrlControllers
                .map((c) => uriPardser(c.text))
                .toList(),
      ),
    );

    print("[DEBUG]=> ${trainingData.toJson()}");
    controller.isLoading.value = true;
    final success = await controller.createTraining(trainingData);

    controller.isLoading.value = false;
    if (success) Get.back();
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message:
          success ? "Training added successfully" : "Failed to add training",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  void _update() async {
    if (!controller.formKey.currentState!.validate()) return;

    final trainingData = TrainingData(
      category: controller.categoryController.text,
      title: controller.titleController.text,
      links: TrainingLinks(
        titles: controller.linkTitleControllers.map((c) => c.text).toList(),
        urls: controller.linkUrlControllers.map((c) => c.text).toList(),
      ),
    );

    print("[DEBUG]=> ${trainingData.toJson()}");
    controller.isLoading.value = true;
    final success = await controller.updateTraining(
      training!.id!,
      trainingData,
    );

    controller.isLoading.value = false;
    if (success) Get.back();
    CrmSnackBar.showAwesomeSnackbar(
      title: success ? "Success" : "Error",
      message:
          success
              ? "Training updated successfully"
              : "Failed to update training",
      contentType: success ? ContentType.success : ContentType.failure,
    );
  }

  // String? uriValidator(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return "URL required";
  //   }
  //
  //   var input = value.trim();
  //   if (!input.startsWith("http://") && !input.startsWith("https://")) {
  //     input = "https://$input"; // auto-fix by prepending
  //   }
  //
  //   try {
  //     final uri = Uri.parse(input);
  //     if (uri.host.isEmpty) return "URL must have a valid domain";
  //   } catch (e) {
  //     return "Invalid URL format";
  //   }
  //
  //   return null;
  // }

  String uriPardser(String value) {
    var input = value.trim();
    if (!input.startsWith("http://") && !input.startsWith("https://")) {
      return "https://$input"; // auto-fix by prepending
    }
    return input;
  }

  @override
  Widget build(BuildContext context) {
    if (isFromEdit && training != null) {
      controller.categoryController.text = training!.category ?? '';
      controller.titleController.text = training!.title ?? '';
      controller.setLinks(
        TrainingLinks(
          titles: training!.links?.titles ?? [],
          urls: training!.links?.urls ?? [],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isFromEdit ? 'Edit Training' : 'Add Training'),
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
                title: 'Training Title',
                isRequired: true,
                validator:
                    (value) => requiredValidator(value, 'Title is required'),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Category
              CrmTextField(
                controller: controller.categoryController,
                title: 'Category',
                isRequired: true,
                validator:
                    (value) => requiredValidator(value, 'Category is required'),
              ),
              SizedBox(height: AppSpacing.medium),

              /// Links (Dynamic List)
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Links",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (
                      int i = 0;
                      i < controller.linkTitleControllers.length;
                      i++
                    )
                      Row(
                        children: [
                          Expanded(
                            child: CrmTextField(
                              controller: controller.linkTitleControllers[i],
                              title: 'Link Title',
                              isRequired: true,
                              validator:
                                  (value) => requiredValidator(
                                    value,
                                    'Link title required',
                                  ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: CrmTextField(
                              controller: controller.linkUrlControllers[i],
                              title: 'Link URL',
                              isRequired: true,
                              validator:
                                  (value) =>
                                      requiredValidator(value, 'URL required'),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => controller.removeLink(i),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: controller.addLink,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add, color: Colors.blue),
                          SizedBox(width: AppSpacing.small),
                          const Text("Add Link"),
                        ],
                      ),
                    ),
                  ],
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
                                  ? 'Update Training'
                                  : 'Create Training',
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
