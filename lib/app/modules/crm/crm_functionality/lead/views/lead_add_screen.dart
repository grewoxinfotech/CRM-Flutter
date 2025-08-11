// import 'package:crm_flutter/app/care/constants/size_manager.dart';
// import 'package:crm_flutter/app/modules/crm/lead/controllers/lead_controller.dart';
// import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/controller/pipeline_controller.dart';
// import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
// import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
// import 'package:crm_flutter/app/widgets/button/crm_button.dart';
// import 'package:crm_flutter/app/widgets/common/display/crm_headline.dart';
// import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
// import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
//
// class LeadAddScreen extends StatelessWidget {
//   const LeadAddScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final PipelineController pipelineController = Get.put(PipelineController());
//     final leadController = Get.find<LeadController>();
//
//     List<Widget> items = [
//       CrmTextField(
//         title: "Lead Title",
//         controller: leadController.leadTitleController,
//         hintText: "Enter lead title",
//         isRequired: true,
//         prefixIcon: Icons.title,
//       ),
//       Obx(
//         ()=> CrmDropdownField<String>(
//           title: "Pipeline",
//           value:
//               leadController.selectedPipeline.value.isEmpty
//                   ? null
//                   : leadController.selectedPipeline.value,
//           items:
//               pipelineController.pipelines.map((pipeline) {
//                 return DropdownMenuItem(
//                   value: pipeline.pipelineName ?? '',
//                   child: Text(pipeline.pipelineName ?? ''),
//                 );
//               }).toList(),
//           onChanged: (value) {
//             final selectedPipeline = pipelineController.pipelines
//                 .firstWhereOrNull((p) => p.pipelineName == value);
//             // if (selectedPipeline != null) {
//             //   leadController.updatePipeline(value, selectedPipeline.id);
//             // }
//           },
//           isRequired: true,
//           hintText: "Select pipeline",
//           prefixIcon: Icons.account_tree,
//         ),
//       ),
//       CrmTextField(
//         title: "Lead Value",
//         controller: leadController.leadValueController,
//         hintText: "Enter value",
//         keyboardType: TextInputType.number,
//         isRequired: true,
//         prefixIcon: Icons.attach_money,
//       ),
//       Obx(
//         () => CrmDropdownField<String>(
//           title: "Source",
//           value:
//               leadController.selectedSource.value.isEmpty
//                   ? null
//                   : leadController.selectedSource.value,
//           items:
//               leadController.sourceOptions
//                   .map(
//                     (id) => DropdownMenuItem(
//                       value: id,
//                       child: Text(leadController.getSourceName(id)),
//                     ),
//                   )
//                   .toList(),
//           onChanged:
//               (value) => leadController.selectedSource.value = value ?? '',
//           isRequired: true,
//           hintText: "Select source",
//           prefixIcon: Icons.source,
//         ),
//       ),
//       Obx(
//         () => CrmDropdownField<String>(
//           title: "Category",
//           value:
//               leadController.selectedCategory.value.isEmpty
//                   ? null
//                   : leadController.selectedCategory.value,
//           items:
//               leadController.categoryOptions
//                   .map(
//                     (id) => DropdownMenuItem(
//                       value: id,
//                       child: Text(leadController.getCategoryName(id)),
//                     ),
//                   )
//                   .toList(),
//           onChanged:
//               (value) => leadController.selectedCategory.value = value ?? '',
//           hintText: "Select category",
//           prefixIcon: Icons.category,
//         ),
//       ),
//       Obx(
//         () => CrmDropdownField<String>(
//           title: "Status",
//           enabled: true,
//           value:
//               leadController.selectedStatus.value.isEmpty
//                   ? null
//                   : leadController.selectedStatus.value,
//           items:
//               leadController.statusOptions
//                   .map(
//                     (id) => DropdownMenuItem(
//                       enabled: true,
//                       value: id,
//                       child: Text(leadController.getStatusName(id)),
//                     ),
//                   )
//                   .toList(),
//           onChanged:
//               (value) => leadController.selectedStatus.value = value ?? '',
//           hintText: "Select status",
//           prefixIcon: FontAwesomeIcons.info,
//         ),
//       ),
//
//       AppSpacing.verticalMedium,
//       const CrmHeadline(title: "Basic Information"),
//       CrmTextField(
//         title: "First Name",
//         controller: leadController.firstNameController,
//         hintText: "Enter first name",
//         isRequired: false,
//         prefixIcon: FontAwesomeIcons.person,
//       ),
//       CrmTextField(
//         title: "Last Name",
//         controller: leadController.lastNameController,
//         hintText: "Enter last name",
//         isRequired: false,
//         prefixIcon: FontAwesomeIcons.person,
//       ),
//       CrmTextField(
//         title: "Email",
//         controller: leadController.emailController,
//         hintText: "Enter email",
//         keyboardType: TextInputType.emailAddress,
//         prefixIcon: Icons.email,
//       ),
//       CrmTextField(
//         title: "Phone Number",
//         controller: leadController.phoneController,
//         hintText: "Enter phone number",
//         keyboardType: TextInputType.phone,
//         prefixIcon: Icons.phone,
//       ),
//       CrmTextField(
//         title: "Company Name",
//         controller: leadController.companyController,
//         hintText: "Enter company name",
//         prefixIcon: Icons.business,
//       ),
//       CrmTextField(
//         title: "Address",
//         controller: leadController.addressController,
//         hintText: "Enter address",
//         prefixIcon: Icons.location_on,
//       ),
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: const CrmBackButton(),
//         title: const Text("Create New Lead"),
//       ),
//       floatingActionButton: Obx(
//         () => CrmButton(
//           width: Get.width - 40,
//           title: leadController.isLoading.value ? "Creating..." : "Create Lead",
//           onTap: leadController.isLoading.value ? null : leadController.addLead,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: ViewScreen(
//         padding: EdgeInsets.only(
//           top: AppPadding.medium,
//           left: AppPadding.medium,
//           right: AppPadding.medium,
//           bottom: 80,
//         ),
//         itemCount: items.length,
//         itemBuilder: (context, i) => items[i],
//       ),
//     );
//   }
// }
