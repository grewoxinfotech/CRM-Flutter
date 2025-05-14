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

    if (leadController.leads.isEmpty) {
      return const Center(child: Text("No Lead Data Available."));
    }

    final lead = leadController.leads.firstWhere(
      (lead) => lead.id == id,
      orElse: () => LeadModel(),
    );

    if (lead.id == null) {
      return const Center(child: Text("Lead not found"));
    }

    // Load notes when the screen is built
    noteController.getNotesForLead(id);

    // Initialize file controller and set files from lead data
    if (lead.files != null && lead.files.isNotEmpty) {
      fileController.setFilesFromLeadData(lead.files);
    }

    List widgets = [
      LeadOverviewCard(
        id: lead.id.toString(),
        color: Colors.green,
        inquiryId: lead.inquiryId.toString(),
        leadTitle: lead.leadTitle.toString(),
        leadStage: lead.leadStage.toString(),
        pipeline: lead.pipeline.toString(),
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
        source: lead.source.toString(),
        category: lead.category.toString(),
        files: lead.files.toString(),
        status: lead.status.toString(),
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
        onEdit: () {},
      ),
      Stack(
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
                  id: "${lead.id}_${file.filename}",
                  role: "File",
                  onTap: null,
                  onDelete: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => CrmDeleteDialog(
                            entityType: "file",
                            onConfirm: () async {
                              final success = await fileController.deleteFile(
                                lead.id.toString(),
                                file.filename,
                              );
                              if (success) {
                                await leadController.refreshData();
                              }
                            },
                          ),
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            right: AppPadding.medium,
            bottom: AppPadding.medium,
            child: FloatingActionButton(
              onPressed: () {
                if (lead.id != null) {
                  _uploadFile(context, lead.id!);
                }
              },
              child: const Icon(Icons.upload_file, color: Colors.white),
            ),
          ),
        ],
      ),

      ViewScreen(
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
      ),
      Stack(
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
                  onDelete: () => noteController.deleteNote(note.id, id),
                  onEdit:
                      () => _showNoteDialog(
                        context,
                        noteController,
                        id,
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
              onPressed: () => _showAddNoteDialog(context, noteController, id),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
      ViewScreen(
        itemCount: 10,
        padding: const EdgeInsets.all(AppPadding.medium),
        itemBuilder: (context, i) {
          return PaymentCard();
        },
      ),
    ];

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
          ],
        ),
      ),
      body: PageView.builder(
        itemCount: widgets.length,
        controller: tabBarController.pageController,
        onPageChanged: tabBarController.onPageChanged,
        itemBuilder: (context, i) {
          return widgets[i];
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
            onSuccess: () => controller.getNotesForLead(leadId),
          ),
    );
  }

  void _showAddNoteDialog(
    BuildContext context,
    NoteController controller,
    String leadId,
  ) {
    _showNoteDialog(context, controller, leadId);
  }

  void _showEditNoteDialog(
    BuildContext context,
    NoteController controller,
    String leadId,
    NoteModel note,
  ) {
    _showNoteDialog(context, controller, leadId, note: note);
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
}
