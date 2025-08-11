
import 'package:crm_flutter/app/modules/crm/crm_functionality//deal/controllers/deal_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/controller/pipeline_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class DealEditScreen extends StatefulWidget {
  final String dealId;
  DealEditScreen({required this.dealId});

  @override
  State<DealEditScreen> createState() => _DealEditScreenState();
}

class _DealEditScreenState extends State<DealEditScreen> {
  @override
  void initState() {
    super.initState();
    final dealController = Get.find<DealController>();
    final pipelineController = Get.find<PipelineController>();
    
    // Load all required data first
    Future.wait([
      if (pipelineController.pipelines.isEmpty) dealController.getPipelines(),
      if (dealController.labels.isEmpty) dealController.getLabels(),
      if (dealController.stages.isEmpty) dealController.getStages(),
    ]).then((_) {
      // Then load deal data
      dealController.editDeal(widget.dealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DealController dealController = Get.find<DealController>();
    final PipelineController pipelineController = Get.find<PipelineController>();

    return WillPopScope(
      onWillPop: () async {
        // Refresh data before popping
        await dealController.refreshData();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Deal"),
          leading: CrmBackButton(),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CrmTextField(
                title: 'Deal Title',
                controller: dealController.dealTitle,
                hintText: 'Enter deal title',
              ),
              const SizedBox(height: 16),
              Obx(
                () => CrmDropdownField<String>(
                  title: "Pipeline",
                  value: dealController.selectedPipelineId.value.isEmpty ? null : dealController.selectedPipelineId.value,
                  items: pipelineController.pipelines.map((pipeline) => DropdownMenuItem(
                    value: pipeline.id,
                    child: Text(pipeline.pipelineName ?? ''),
                  )).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      final selectedPipeline = pipelineController.pipelines
                          .firstWhereOrNull((p) => p.id == value);
                      if (selectedPipeline != null) {
                        dealController.updatePipeline(selectedPipeline.pipelineName ?? '', value);
                      }
                    }
                  },
                  isRequired: true,
                  hintText: "Select pipeline",
                ),
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'Deal Value',
                controller: dealController.dealValue,
                hintText: 'Enter deal value',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'First Name',
                controller: dealController.firstName,
                hintText: 'Enter first name',
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'Last Name',
                controller: dealController.lastName,
                hintText: 'Enter last name',
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'Email',
                controller: dealController.email,
                hintText: 'Enter email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'Phone',
                controller: dealController.phoneNumber,
                hintText: 'Enter phone number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'Company',
                controller: dealController.companyName,
                hintText: 'Enter company name',
              ),
              const SizedBox(height: 16),
              CrmTextField(
                title: 'Address',
                controller: dealController.address,
                hintText: 'Enter address',
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Obx(
                () => CrmButton(
                  width: Get.width - 40,
                  title: dealController.isLoading.value ? "Updating..." : "Update Deal",
                  onTap: dealController.isLoading.value ? null : () async {
                    try {
                      await dealController.updateDeal(widget.dealId);
                    } catch (e) {
                      CrmSnackBar.showAwesomeSnackbar(
                        title: 'Error',
                        message: 'Failed to update deal: ${e.toString()}',
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