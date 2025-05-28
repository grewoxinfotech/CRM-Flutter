import 'package:crm_flutter/app/care/constants/color_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/screens/crm/screens/leads/controllers/pipeline_controller.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_ic.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LeaveRequestDialog extends StatelessWidget {
  final TextEditingController? leaveType;
  final TextEditingController? starDate;
  final TextEditingController? endDate;
  final TextEditingController? reason;
  final bool? halfDay;

  LeaveRequestDialog({
    super.key,
    this.leaveType,
    this.starDate,
    this.endDate,
    this.reason,
    this.halfDay = false,
  });

  @override
  Widget build(BuildContext context) {
    final pipelineController = Get.put(PipelineController());
    final items = <Widget>[
      Obx(
        () => CrmDropdownField<String>(
          value:
              pipelineController.selectedPipeline.value.isEmpty
                  ? null
                  : pipelineController.selectedPipeline.value,
          items:
              pipelineController.pipelines.map((pipeline) {
                return DropdownMenuItem(
                  value: pipeline.pipelineName ?? '',
                  child: Text(pipeline.pipelineName ?? ''),
                );
              }).toList(),
          onChanged: (value) {
            final selectedPipeline = pipelineController.pipelines
                .firstWhereOrNull((p) => p.pipelineName == value);
            if (selectedPipeline != null) {
              // leadController.updatePipeline(value, selectedPipeline.id);
            }
          },
          isRequired: true,
          hintText: "Leave Type",
          suffixIcon: CrmIc(
            icon: LucideIcons.download,
            color: Get.theme.colorScheme.primary,
          ),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Obx(
              () => CrmDropdownField<String>(
                value:
                    pipelineController.selectedPipeline.value.isEmpty
                        ? null
                        : pipelineController.selectedPipeline.value,
                items:
                    pipelineController.pipelines.map((pipeline) {
                      return DropdownMenuItem(
                        value: pipeline.pipelineName ?? '',
                        child: Text(pipeline.pipelineName ?? ''),
                      );
                    }).toList(),
                onChanged: (value) {
                  final selectedPipeline = pipelineController.pipelines
                      .firstWhereOrNull((p) => p.pipelineName == value);
                  if (selectedPipeline != null) {
                    // leadController.updatePipeline(value, selectedPipeline.id);
                  }
                },
                isRequired: true,
                hintText: "Start",
                suffixIcon: CrmIc(
                  icon: LucideIcons.calendar,
                  size: 16,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          AppSpacing.horizontalSmall,
          Expanded(
            child: Obx(
              () => CrmDropdownField<String>(
                value:
                    pipelineController.selectedPipeline.value.isEmpty
                        ? null
                        : pipelineController.selectedPipeline.value,
                items:
                    pipelineController.pipelines.map((pipeline) {
                      return DropdownMenuItem(
                        value: pipeline.pipelineName ?? '',
                        child: Text(pipeline.pipelineName ?? ''),
                      );
                    }).toList(),
                onChanged: (value) {
                  final selectedPipeline = pipelineController.pipelines
                      .firstWhereOrNull((p) => p.pipelineName == value);
                  if (selectedPipeline != null) {
                    // leadController.updatePipeline(value, selectedPipeline.id);
                  }
                },
                isRequired: true,
                hintText: "End",
                suffixIcon: CrmIc(
                  icon: LucideIcons.calendar,
                  size: 16,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      CrmTextField(maxLines: 3, hintText: "Reason", controller: reason),
      SizedBox(),
      Row(
        children: [
          AppSpacing.horizontalSmall,
          Text(
            "Half Day",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: textPrimary,
            ),
          ),
        ],
      ),
    ];

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: Get.height * 0.445),
            child: Column(
              children: [
                CrmCard(
                  width: double.infinity,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppRadius.large),
                  ),
                  boxShadow: [],
                  gradient: LinearGradient(
                    colors: [primary.withOpacity(0.8), primary],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.medium,
                    vertical: AppPadding.small * 1.5,
                  ),
                  child: Text(
                    "Leave Request",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
                  ),
                ),
                ViewScreen(
                  itemCount: items.length,
                  padding: EdgeInsets.all(AppPadding.medium),
                  itemBuilder: (context, i) => items[i],
                ),

                AppSpacing.verticalMedium,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.medium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CrmButton(
                        width: 80,
                        height: 30,
                        boxShadow: [],
                        titleTextStyle: TextStyle(
                          color: textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        backgroundColor: transparent,
                        title: "Cancel",
                        onTap: () => Navigator.pop(context),
                      ),
                      CrmButton(
                        width: 90,
                        height: 35,
                        title: "Create",
                        onTap: () {
                          // Handle create logic
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
