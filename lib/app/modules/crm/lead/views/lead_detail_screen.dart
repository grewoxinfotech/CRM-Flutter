import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/data/network/crm/notes/model/note_model.dart';
import 'package:crm_flutter/app/data/network/file/model/file_model.dart';
import 'package:crm_flutter/app/modules/crm/file/controllers/file_controller.dart';
import 'package:crm_flutter/app/modules/crm/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/crm/lead/widgets/lead_overview_card.dart';
import 'package:crm_flutter/app/modules/project/file/widget/file_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/model/tab_bar_model.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/view/crm_tab_bar.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_dropdown_field.dart';
import 'package:crm_flutter/app/widgets/common/inputs/crm_text_field.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/member_card.dart';
import 'package:crm_flutter/app/modules/crm/notes/views/note_card.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/payment_card.dart';
import 'dart:typed_data';
import 'package:crm_flutter/app/widgets/dialog/note/note_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:crm_flutter/app/data/network/file/service/file_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/data/network/role/service/roles_service.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:crm_flutter/app/modules/crm/notes/controllers/note_controller.dart';
import 'package:crm_flutter/app/data/network/crm/notes/service/note_service.dart';
import 'dart:io';
import 'package:crm_flutter/app/widgets/common/dialogs/upload_status_dialog.dart';
import 'package:crm_flutter/app/modules/crm/file/bindings/file_binding.dart';
import 'package:crm_flutter/app/modules/crm/lead/views/lead_edit_screen.dart';
import 'package:crm_flutter/app/modules/crm/activity/controller/activity_controller.dart';
import 'package:crm_flutter/app/data/network/activity/model/activity_model.dart';
import 'package:crm_flutter/app/modules/crm/activity/views/activity_card.dart';

class LeadDetailScreen extends StatelessWidget {
  final String id;

  const LeadDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final tabBarController = Get.put(TabBarController());
    final leadController = Get.find<LeadController>();
    final rolesService = Get.find<RolesService>();
    Get.lazyPut<NoteService>(() => NoteService());
    Get.lazyPut<FileController>(() => FileController());
    final noteController = Get.put(NoteController());
    final fileController = Get.find<FileController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Lead"),
        leading: CrmBackButton(),
        bottom: CrmTabBar(
          items: [
            TabBarModel(iconPath: ICRes.attach, label: "Overview"),
            TabBarModel(iconPath: ICRes.attach, label: "Files"),
            TabBarModel(iconPath: ICRes.attach, label: "Members"),
            TabBarModel(iconPath: ICRes.attach, label: "Notes"),
            TabBarModel(iconPath: ICRes.attach, label: "Activities"),
          ],
        ),
      ),
      body: Obx(() {
        if (leadController.leads.isEmpty) {
          leadController.refreshData();
          return const Center(child: CircularProgressIndicator());
        }

        final lead = leadController.leads.firstWhereOrNull(
          (lead) => lead.id == id,
        );

        if (lead == null) {
          leadController.getLeadById(id);
          return const Center(child: CircularProgressIndicator());
        }

        noteController.getNotes(id);

        if (lead.files.isNotEmpty) {
          fileController.setFilesFromLeadData(lead.files);
        }

        final sourceName = leadController.getSourceName(lead.source ?? '');
        final categoryName = leadController.getCategoryName(
          lead.category ?? '',
        );
        final statusName = leadController.getStatusName(lead.status ?? '');

        List<Widget> widgets = [
          _buildOverviewTab(
            lead,
            leadController,
            sourceName,
            categoryName,
            statusName,
          ),
          _buildFilesTab(fileController, lead.id.toString(), context),
          _buildMembersTab(lead, leadController, rolesService),
          _buildNotesTab(noteController, id, context),
          _buildActivitiesTab(lead, leadController, context),
        ];

        return PageView.builder(
          itemCount: widgets.length,
          controller: tabBarController.pageController,
          onPageChanged: tabBarController.onPageChanged,
          itemBuilder: (context, i) => widgets[i],
        );
      }),
    );
  }

  Widget _buildOverviewTab(
    LeadModel lead,
    LeadController leadController,
    String sourceName,
    String categoryName,
    String statusName,
  ) {
    return LeadOverviewCard(
      id: lead.id.toString(),
      color: Colors.green,
      inquiryId: lead.inquiryId.toString(),
      leadTitle: lead.leadTitle.toString(),
      leadStage: leadController.getStageName(lead.leadStage ?? ''),
      pipeline: leadController.getPipelineName(lead.pipeline ?? ''),
      currency: lead.currency.toString(),
      leadValue: lead.leadValue.toString(),
      companyName: lead.companyName.toString(),
      firstName: lead.firstName.toString(),
      lastName: lead.lastName.toString(),
      phoneCode: lead.phoneCode.toString(),
      telephone: lead.telephone.toString(),
      email: lead.email.toString(),
      address: lead.address.toString(),
      leadMembers: lead.leadMembers.toString(),
      source: sourceName,
      category: categoryName,
      files: lead.files.toString(),
      status: statusName,
      interestLevel: lead.interestLevel.toString(),
      leadScore: lead.leadScore.toString(),
      isConverted: lead.isConverted.toString(),
      clientId: lead.clientId.toString(),
      createdBy: lead.createdBy.toString(),
      updatedBy: lead.updatedBy.toString(),
      createdAt: lead.createdAt.toString(),
      updatedAt: lead.updatedAt.toString(),
      onDelete:
          () => CrmDeleteDialog(
            onConfirm: () {
              leadController.deleteLead(lead.id.toString());
              Get.back();
            },
          ),
      onEdit: () => _handleEdit(lead, leadController),
    );
  }

  Widget _buildFilesTab(
    FileController fileController,
    String leadId,
    BuildContext context,
  ) {
    return Stack(
      children: [
        Obx(
          () => ViewScreen(
            itemCount: fileController.files.length,
            padding: const EdgeInsets.all(AppPadding.medium),
            itemBuilder: (context, i) {
              final file = fileController.files[i];
              return FileCard(
                url: file.url,
                name: file.filename,
                id: "${leadId}_${file.filename}",
                role: "File",
                onTap: null,
                onDelete:
                    () => _showDeleteFileDialog(
                      context,
                      fileController,
                      leadId,
                      file.filename,
                    ),
              );
            },
          ),
        ),
        Positioned(
          right: AppPadding.medium,
          bottom: AppPadding.medium,
          child: FloatingActionButton(
            onPressed: () => _uploadFile(context, leadId),
            child: const Icon(Icons.upload_file, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildMembersTab(
    LeadModel lead,
    LeadController leadController,
    RolesService rolesService,
  ) {
    return ViewScreen(
      itemCount: lead.leadMembers.length,
      padding: const EdgeInsets.all(AppPadding.medium),
      itemBuilder: (context, index) {
        final member = lead.leadMembers[index];
        final user =
            leadController.getLeadMembers([member.memberId]).firstOrNull;
        if (user == null) return const SizedBox.shrink();

        final roleName = rolesService.getRoleNameById(user.roleId);
        final role = [
          if (roleName.isNotEmpty) roleName,
          if (user.designation?.isNotEmpty == true) user.designation,
          if (user.department?.isNotEmpty == true) user.department,
        ].where((s) => s != null && s.isNotEmpty).join(' - ');

        return MemberCard(
          title: user.username,
          subTitle: role.isNotEmpty ? role : 'No Role',
          role: user.email,
          onTap: null,
        );
      },
    );
  }

  Widget _buildNotesTab(
    NoteController noteController,
    String leadId,
    BuildContext context,
  ) {
    return Stack(
      children: [
        Obx(
          () => ViewScreen(
            itemCount: noteController.notes.length,
            padding: const EdgeInsets.all(AppPadding.medium),
            itemBuilder: (context, i) {
              final note = noteController.notes[i];
              return NoteCard(
                id: note.id,
                relatedId: note.relatedId,
                noteTitle: note.noteTitle,
                noteType: note.notetype,
                description: note.description,
                clientId: note.clientId,
                createdBy: note.createdBy,
                updatedBy: note.updatedBy,
                createdAt: formatDate(note.createdAt.toString()),
                updatedAt: formatDate(note.updatedAt.toString()),
                onDelete: () => noteController.deleteNote(note.id, leadId),
                onEdit:
                    () => _showNoteDialog(
                      context,
                      noteController,
                      leadId,
                      note: note,
                    ),
              );
            },
          ),
        ),
        Positioned(
          right: AppPadding.medium,
          bottom: AppPadding.medium,
          child: FloatingActionButton(
            onPressed: () => _showNoteDialog(context, noteController, leadId),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildActivitiesTab(
    LeadModel lead,
    LeadController leadController,
    BuildContext context,
  ) {
    final activityController = leadController.activityController;
    activityController.getActivities(lead.id.toString());

    return Stack(
      children: [
        Obx(() {
          if (activityController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return ViewScreen(
            itemCount: activityController.activities.length,
            padding: const EdgeInsets.all(AppPadding.medium),
            itemBuilder: (context, index) {
              final activity = activityController.activities[index];
              return ActivityCard(
                activity: activity,
                onDelete:
                    () => _showDeleteActivityDialog(
                      context,
                      activityController,
                      activity.id ?? '',
                      lead.id.toString(),
                    ),
              );
            },
          );
        }),
      ],
    );
  }

  Future<void> _handleEdit(
    LeadModel lead,
    LeadController leadController,
  ) async {
    leadController.leadTitleController.text = lead.leadTitle ?? '';
    leadController.leadValueController.text = lead.leadValue?.toString() ?? '';
    leadController.firstNameController.text = lead.firstName ?? '';
    leadController.lastNameController.text = lead.lastName ?? '';
    leadController.emailController.text = lead.email ?? '';
    leadController.phoneController.text = lead.telephone ?? '';
    leadController.companyController.text = lead.companyName ?? '';
    leadController.addressController.text = lead.address ?? '';

    leadController.selectedSource.value = lead.source ?? '';
    leadController.selectedCategory.value = lead.category ?? '';
    leadController.selectedStatus.value = lead.status ?? '';
    leadController.selectedInterestLevel.value = lead.interestLevel ?? '';

    await Get.to(() => LeadEditScreen(leadId: lead.id.toString()));
    await leadController.getLeadById(id);
    await leadController.refreshData();
  }

  void _showDeleteFileDialog(
    BuildContext context,
    FileController fileController,
    String leadId,
    String filename,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => CrmDeleteDialog(
            entityType: "file",
            onConfirm: () async {
              final success = await fileController.deleteFile(leadId, filename);
              if (success) {
                final leadController = Get.find<LeadController>();
                await leadController.refreshData();
              }
            },
          ),
    );
  }

  void _showNoteDialog(
    BuildContext context,
    NoteController controller,
    String leadId, {
    NoteModel? note,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => NoteDialog(
            leadId: leadId,
            controller: controller,
            note: note,
            onSuccess: () => controller.getNotes(leadId),
          ),
    );
  }

  Future<void> _uploadFile(BuildContext context, String leadId) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
        withData: true,
        withReadStream: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        UploadStatusDialog.showUploading(context);

        Uint8List? fileBytes;
        if (file.bytes == null) {
          if (file.path != null) {
            fileBytes = await File(file.path!).readAsBytes();
          } else {
            Navigator.pop(context);
            UploadStatusDialog.showError(context, 'Could not read file data');
            return;
          }
        } else {
          fileBytes = file.bytes!;
        }

        final fileController = Get.find<FileController>();
        final responseData = await fileController.uploadFile(
          leadId,
          fileBytes,
          file.name,
        );

        Navigator.pop(context);

        if (responseData != null) {
          await fileController.refreshFiles(leadId);
          UploadStatusDialog.showSuccess(context);
        } else {
          UploadStatusDialog.showError(
            context,
            'File upload failed. Please try again.',
          );
        }
      }
    } catch (e) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      UploadStatusDialog.showError(context, 'Error uploading file: $e');
    }
  }

  void _showDeleteActivityDialog(
    BuildContext context,
    ActivityController controller,
    String activityId,
    String leadId,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => CrmDeleteDialog(
            entityType: "activity",
            onConfirm: () async {
              await controller.getActivities(leadId);
            },
          ),
    );
  }
}
