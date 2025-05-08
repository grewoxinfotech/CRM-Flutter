import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/modules/crm/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadAddScreen extends StatelessWidget {
  const LeadAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeadController>();
    
    return Scaffold(
      appBar: AppBar(
        leading: const CrmBackButton(),
        title: const Text("Create New Lead", style: TextStyle(color: ColorRes.white)),
        backgroundColor: Get.theme.colorScheme.primary,
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            CrmTextField(
              title: "Lead Title",
              controller: controller.leadTitleController,
              hintText: "Enter lead title",
              isRequired: true,
              prefixIcon: Icons.title,
            ),
            const SizedBox(height: 16),
            Obx(() => CrmDropdownField<String>(
              title: "Pipeline",
              value: controller.selectedPipeline.value.isEmpty ? null : controller.selectedPipeline.value,
              items: controller.pipelines.map((pipeline) => DropdownMenuItem(
                value: pipeline.pipelineName ?? '',
                child: Text(pipeline.pipelineName ?? ''),
              )).toList(),
              onChanged: (value) {
                final selectedPipeline = controller.pipelines.firstWhereOrNull(
                  (p) => p.pipelineName == value
                );
                if (selectedPipeline != null) {
                  controller.updatePipeline(value, selectedPipeline.id);
                }
              },
              isRequired: true,
              hintText: "Select pipeline",
              prefixIcon: Icons.account_tree,
            )),
            const SizedBox(height: 16),
            CrmTextField(
              title: "Lead Value",
              controller: controller.leadValueController,
              hintText: "Enter value",
              keyboardType: TextInputType.number,
              isRequired: true,
              prefixIcon: Icons.attach_money,
            ),
            const SizedBox(height: 16),
            Obx(() => CrmDropdownField<String>(
              title: "Source",
              value: controller.selectedSource.value.isEmpty ? null : controller.selectedSource.value,
              items: controller.sourceOptions.map((id) => DropdownMenuItem(
                value: id,
                child: Text(controller.getSourceName(id)),
              )).toList(),
              onChanged: (value) => controller.selectedSource.value = value ?? '',
              isRequired: true,
              hintText: "Select source",
              prefixIcon: Icons.source,
            )),
            const SizedBox(height: 16),
            Obx(() => CrmDropdownField<String>(
              title: "Category",
              value: controller.selectedCategory.value.isEmpty ? null : controller.selectedCategory.value,
              items: controller.categoryOptions.map((id) => DropdownMenuItem(
                value: id,
                child: Text(controller.getCategoryName(id)),
              )).toList(),
              onChanged: (value) => controller.selectedCategory.value = value ?? '',
              hintText: "Select category",
              prefixIcon: Icons.category,
            )),
            const SizedBox(height: 16),
            Obx(() => CrmDropdownField<String>(
              title: "Status",
              value: controller.selectedStatus.value.isEmpty ? null : controller.selectedStatus.value,
              items: controller.statusOptions.map((id) => DropdownMenuItem(
                value: id,
                child: Text(controller.getStatusName(id)),
              )).toList(),
              onChanged: (value) => controller.selectedStatus.value = value ?? '',
              hintText: "Select status",
              prefixIcon: Icons.info,
            )),
            
            const SizedBox(height: 32),
            const CrmHeadline(title: "Basic Information"),
            const SizedBox(height: 16),
            CrmTextField(
              title: "First Name",
              controller: controller.firstNameController,
              hintText: "Enter first name",
              isRequired: false,
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 16),
            CrmTextField(
              title: "Last Name",
              controller: controller.lastNameController,
              hintText: "Enter last name",
              isRequired: false,
              prefixIcon: Icons.person,
            ),
            const SizedBox(height: 16),
            CrmTextField(
              title: "Email",
              controller: controller.emailController,
              hintText: "Enter email",
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email,
            ),
            const SizedBox(height: 16),
            CrmTextField(
              title: "Phone Number",
              controller: controller.phoneController,
              hintText: "Enter phone number",
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone,
            ),
            const SizedBox(height: 16),
            CrmTextField(
              title: "Company Name",
              controller: controller.companyController,
              hintText: "Enter company name",
              prefixIcon: Icons.business,
            ),
            const SizedBox(height: 16),
            CrmTextField(
              title: "Address",
              controller: controller.addressController,
              hintText: "Enter address",
              prefixIcon: Icons.location_on,
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: Obx(() => CrmButton(
        width: Get.width - 40,
        title: controller.isLoading.value ? "Creating..." : "Create Lead",
        onTap: controller.isLoading.value ? null : controller.addLead,
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
