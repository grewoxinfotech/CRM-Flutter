import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/model/label_model.dart';
import 'package:crm_flutter/app/data/network/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/modules/crm/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/controller/pipeline_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class LeadEditScreen extends StatefulWidget {
  final String leadId;
  LeadEditScreen({required this.leadId});

  @override
  State<LeadEditScreen> createState() => _LeadEditScreenState();
}

class _LeadEditScreenState extends State<LeadEditScreen> {
  @override
  void initState() {
    super.initState();
    final leadController = Get.find<LeadController>();
    final pipelineController = Get.find<PipelineController>();
    
    // Load all required data first
    Future.wait([
      if (pipelineController.pipelines.isEmpty) leadController.getPipelines(),
      if (leadController.labels.isEmpty) leadController.getLabels(),
      if (leadController.stages.isEmpty) leadController.getStages(),
    ]).then((_) {
      // Then load lead data
      leadController.editLead(widget.leadId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final LeadController leadController = Get.find<LeadController>();
    final PipelineController pipelineController = Get.find<PipelineController>();

    return WillPopScope(
      onWillPop: () async {
        // Refresh data before popping
        await leadController.refreshData();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Lead"),
          leading: CrmBackButton(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CrmTextField(
                title: 'Lead Title',
                controller: leadController.leadTitleController,
                hintText: 'Enter lead title',
              ),
              const SizedBox(height: 16),
              Obx(
                () => CrmDropdownField<String>(
                  title: "Pipeline",
                  value: leadController.selectedPipelineId.value.isEmpty ? null : leadController.selectedPipelineId.value,
                  items: pipelineController.pipelines.map((pipeline) => DropdownMenuItem(
                    value: pipeline.id,
                    child: Text(pipeline.pipelineName ?? ''),
                  )).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      final selectedPipeline = pipelineController.pipelines
                          .firstWhereOrNull((p) => p.id == value);
                      if (selectedPipeline != null) {
                        leadController.updatePipeline(selectedPipeline.pipelineName ?? '', value);
                      }
                    }
                  },
                  isRequired: true,
                  hintText: "Select pipeline",
                ),
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'Lead Value',
                controller: leadController.leadValueController,
                hintText: 'Enter lead value',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'First Name',
                controller: leadController.firstNameController,
                hintText: 'Enter first name',
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'Last Name',
                controller: leadController.lastNameController,
                hintText: 'Enter last name',
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'Email',
                controller: leadController.emailController,
                hintText: 'Enter email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'Phone',
                controller: leadController.phoneController,
                hintText: 'Enter phone number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'Company',
                controller: leadController.companyController,
                hintText: 'Enter company name',
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'Address',
                controller: leadController.addressController,
                hintText: 'Enter address',
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Obx(
                () => CrmDropdownField<String>(
                  title: 'Source',
                  value: leadController.selectedSource.value.isEmpty ? null : leadController.selectedSource.value,
                  items: leadController.sourceOptions.map((id) => DropdownMenuItem(
                    value: id,
                    child: Text(leadController.getSourceName(id)),
                  )).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      leadController.selectedSource.value = value;
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => CrmDropdownField<String>(
                  title: 'Category',
                  value: leadController.selectedCategory.value.isEmpty ? null : leadController.selectedCategory.value,
                  items: leadController.categoryOptions.map((id) => DropdownMenuItem(
                    value: id,
                    child: Text(leadController.getCategoryName(id)),
                  )).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      leadController.selectedCategory.value = value;
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => CrmDropdownField<String>(
                  title: 'Status',
                  value: leadController.selectedStatus.value.isEmpty ? null : leadController.selectedStatus.value,
                  items: leadController.statusOptions.map((id) => DropdownMenuItem(
                    value: id,
                    child: Text(leadController.getStatusName(id)),
                  )).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      leadController.selectedStatus.value = value;
                    }
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => CrmDropdownField<String>(
                  title: 'Interest Level',
                  value: leadController.selectedInterestLevel.value.isEmpty ? null : leadController.selectedInterestLevel.value,
                  items: leadController.interestLevelOptions.map((level) => DropdownMenuItem(
                    value: level,
                    child: Text(level),
                  )).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      leadController.selectedInterestLevel.value = value;
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              Obx(
                () => CrmButton(
                  width: Get.width - 40,
                  title: leadController.isLoading.value ? "Updating..." : "Update Lead",
                  onTap: leadController.isLoading.value ? null : () async {
                    try {
                      await leadController.updateLead(widget.leadId);
                    } catch (e) {
                      CrmSnackBar.showAwesomeSnackbar(
                        title: 'Error',
                        message: 'Failed to update lead: ${e.toString()}',
                        contentType: ContentType.failure,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
