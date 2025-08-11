import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/data/network/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/data/network/crm/notes/model/note_model.dart';
import 'package:crm_flutter/app/data/network/file/model/file_model.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/activity/controller/activity_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/contact/controller/contact_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/file/controllers/file_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/views/lead_edit_screen.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/notes/controllers/note_controller.dart';
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
import 'package:crm_flutter/app/widgets/leads_and_deal/payment_card.dart';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:crm_flutter/app/widgets/dialog/note/note_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:crm_flutter/app/data/network/file/service/file_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/modules/users/controllers/users_controller.dart';
import 'package:crm_flutter/app/modules/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:crm_flutter/app/data/network/crm/notes/service/note_service.dart';
import 'dart:io';
import 'package:crm_flutter/app/widgets/common/dialogs/upload_status_dialog.dart';
import 'package:crm_flutter/app/data/network/activity/model/activity_model.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/pipeline/controller/pipeline_controller.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/stage/controller/stage_controller.dart';
import 'package:crm_flutter/app/widgets/common/messages/crm_snack_bar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../../../../data/network/crm/contact/medel/contact_medel.dart';
import '../../../../project/notes/widget/note_card.dart';
import '../../activity/views/activity_card.dart';
import '../../company/view/company_detail_screen.dart';
import '../../contact/views/contact_detail_screen.dart';
import '../widgets/lead_overview_card.dart';

class LeadDetailScreen extends StatelessWidget {
  final String id;
  final String? fromScreen;
  final bool isContactScreen;
  final bool isCompanyScreen;

  const LeadDetailScreen({
    super.key,
    required this.id,
    this.fromScreen,
    this.isContactScreen = false,
    this.isCompanyScreen = false,
  });
  @override
  Widget build(BuildContext context) {
    final tabBarController = Get.put(TabBarController());
    final leadController = Get.find<LeadController>();
    final usersController = Get.find<UsersController>();
    final roleController = Get.find<RoleController>();

    // Make sure LabelController is initialized
    if (!Get.isRegistered<LabelController>()) {
      Get.put(LabelController());
    }
    final labelController = Get.find<LabelController>();

    Get.lazyPut<NoteService>(() => NoteService());
    Get.lazyPut<FileController>(() => FileController());
    final noteController = Get.put(NoteController());
    final fileController = Get.find<FileController>();
    final contactController = Get.find<ContactController>();
    final activityController = Get.put(ActivityController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Lead"),
        leading: CrmBackButton(
          onTap: () {
            if (isContactScreen) {
              final matchedLead = leadController.leads.firstWhereOrNull(
                (lead) => lead.id == id,
              );
              if (matchedLead != null) {
                Get.off(() => ContactDetailScreen(id: matchedLead.contactId));
              }
            } else if (isCompanyScreen) {
              final matchedLead = leadController.leads.firstWhereOrNull(
                (lead) => lead.id == id,
              );
              if (matchedLead != null) {
                Get.off(() => CompanyDetailScreen(id: matchedLead.companyId));
              }
            } else {
              Get.back();
            }
          },
        ),
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

        // Debug contact info - print the exact format of the contact ID
        if (lead.contactId != null) {
          print("Lead contact ID: '${lead.contactId}'");
          print("Contact ID type: ${lead.contactId.runtimeType}");
        } else {
          print("Lead has no contact ID");
        }

        // Make sure contacts are loaded - force fetch if empty
        if (contactController.contacts.isEmpty) {
          print("Contacts list is empty, fetching contacts...");
          contactController.fetchContacts();
        } else {
          print("Contacts loaded: ${contactController.contacts.length}");
          // Print first few contacts for debugging
          for (
            var i = 0;
            i < math.min(3, contactController.contacts.length);
            i++
          ) {
            final c = contactController.contacts[i];
          }
        }

        // Try to load contact directly
        if (lead.contactId != null && lead.contactId!.isNotEmpty) {
          // Try to get contact by ID directly
          contactController.getContactById(lead.contactId!).then((contact) {
            if (contact != null) {
              print(
                "Contact loaded directly: ${contact.firstName} ${contact.lastName}",
              );
              print(
                "Contact phone: ${contact.phone}, email: ${contact.email}, address: ${contact.address}",
              );
            } else {
              print(
                "Failed to load contact directly for ID: '${lead.contactId}'",
              );
            }
          });
        }

        if (lead.files != null && lead.files!.isNotEmpty) {
          final filesList =
              lead.files!
                  .map((file) => {'url': file.url, 'filename': file.filename})
                  .toList();
          fileController.setFilesFromData(filesList);
        }

        List<Widget> widgets = [
          _buildOverviewTab(lead, leadController, null),
          _buildFilesTab(fileController, lead.id.toString(), context),
          _buildMembersTab(
            lead,
            leadController,
            usersController,
            roleController,
          ),
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
    ContactModel? initialContact,
  ) {
    // Get label names for display
    final labelController = Get.find<LabelController>();
    final sourceName = labelController.getLabelName(lead.source ?? '');
    final categoryName = labelController.getLabelName(lead.category ?? '');
    final statusName = labelController.getLabelName(lead.status ?? '');

    // Try to load contact directly if not available
    final contactController = Get.find<ContactController>();

    // If we have a contact ID, try to load it
    if (lead.contactId != null && lead.contactId!.isNotEmpty) {
      // Load the contact if not already loaded
      contactController.getContactById(lead.contactId!);
    }

    return Obx(() {
      // Try to find contact in the contacts list
      ContactModel? contact;

      if (lead.contactId != null && lead.contactId!.isNotEmpty) {
        // Try all possible ways to match the contact
        contact = contactController.contacts.firstWhereOrNull(
          (c) =>
              c.id == lead.contactId ||
              c.id.toString() == lead.contactId ||
              c.id == lead.contactId.toString(),
        );

        // Debug contact matching
        if (contact != null) {
          print(
            "Contact matched for display: ${contact.firstName} ${contact.lastName}",
          );
          print(
            "Contact phone: ${contact.phone}, email: ${contact.email}, address: ${contact.address}",
          );
        } else {
          print(
            "No contact match found for display with ID: '${lead.contactId}'",
          );
        }
      }

      return LeadOverviewCard(
        id: lead.id.toString(),
        color: Colors.green,
        inquiryId: lead.inquiryId.toString(),
        leadTitle: lead.leadTitle.toString(),

        leadStage: leadController.getStageName(lead.leadStage ?? ''),
        pipeline: leadController.getPipelineName(lead.pipeline ?? ''),
        source: sourceName.isEmpty ? 'Not specified' : sourceName,
        category: categoryName.isEmpty ? 'Not specified' : categoryName,

        currency: lead.currency.toString(),
        leadValue: lead.leadValue.toString(),
        telephone: contact?.phone ?? "No Phone",
        email: contact?.email ?? "No email",
        address: contact?.address ?? "No address",
        leadMembers:
            lead.leadMembers?.leadMembers == null
                ? "No Members"
                : lead.leadMembers!.leadMembers!.isEmpty
                ? "No Members"
                : lead.leadMembers!.leadMembers!.length.toString(),

        status: statusName.isEmpty ? 'Not specified' : statusName,
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
    });
  }

  Widget _buildFilesTab(
    FileController fileController,
    String leadId,
    BuildContext context,
  ) {
    // Initial file load
    fileController.refreshFiles(leadId, isDeal: true);

    return Stack(
      children: [
        Obx(() {
          if (fileController.files.isEmpty) {
            return const Center(child: Text("No files found"));
          }

          return ViewScreen(
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
          );
        }),
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
    UsersController usersController,
    RoleController roleController,
  ) {
    if (lead.leadMembers == null || lead.leadMembers!.isEmpty) {
      return const Center(
        child: Text(
          "No members assigned to this lead",
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    // First ensure users and roles are loaded
    return FutureBuilder(
      future: Future.wait([
        leadController.ensureUsersLoaded(),
        roleController.ensureRolesLoaded(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if users and roles were loaded successfully
        if (snapshot.hasData && !snapshot.data!.contains(false)) {
          return _buildMembersList(
            lead,
            leadController,
            usersController,
            roleController,
          );
        } else {
          // Handle the case where loading users or roles failed
          return const Center(
            child: Text(
              "Failed to load member information",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        }
      },
    );
  }

  Widget _buildMembersList(
    LeadModel lead,
    LeadController leadController,
    UsersController usersController,
    RoleController roleController,
  ) {
    // Get the list of member IDs
    final memberIds = lead.leadMembers?.leadMembers ?? [];

    return ViewScreen(
      itemCount: memberIds.length,
      padding: const EdgeInsets.all(AppPadding.medium),
      itemBuilder: (context, index) {
        final memberId = memberIds[index];

        // Try to find the user for this member ID
        final users = leadController.getLeadMembers([memberId]);
        final user = users.isNotEmpty ? users.first : null;

        if (user == null) {
          return MemberCard(
            title: "Member ID: $memberId",
            subTitle: "User data not available",
            role: "",
            onTap: null,
          );
        }

        // Get role name from RoleController
        final roleName = roleController.getRoleName(user.roleId);

        // Combine user information for subtitle
        final fullName =
            "${user.firstName ?? ''} ${user.lastName ?? ''}".trim();
        final designation = user.designation ?? '';
        final department = user.department ?? '';

        // Build subtitle with designation and department
        String subtitle = "";
        if (designation.isNotEmpty) {
          subtitle += designation;
        }
        if (department.isNotEmpty) {
          subtitle += subtitle.isNotEmpty ? " - $department" : department;
        }
        if (subtitle.isEmpty) {
          subtitle = roleName.isNotEmpty ? roleName : "No Role";
        }

        return MemberCard(
          title: fullName.isNotEmpty ? fullName : user.username,
          subTitle: subtitle,
          email: user.email,
          phone: user.phone,
          role: roleName,
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
        Obx(() {
          if (noteController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (noteController.notes.isEmpty) {
            return const Center(child: Text("No notes found"));
          }

          return ViewScreen(
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
          );
        }),
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
    final activityController = Get.find<ActivityController>();
    activityController.getActivities(lead.id.toString());

    return Stack(
      children: [
        Obx(() {
          if (activityController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (activityController.activities.isEmpty) {
            return const Center(child: Text("No activities found"));
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
        Positioned(
          right: AppPadding.medium,
          bottom: AppPadding.medium,
          child: FloatingActionButton(
            onPressed: () {
              // Add activity functionality
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future<void> _handleEdit(
    LeadModel lead,
    LeadController leadController,
  ) async {
    try {
      // Navigate to edit screen with current lead data
      final updatedLead = await Get.to(
        () => LeadEditScreen(leadId: lead.id ?? '', initialData: lead),
      );

      if (updatedLead != null) {
        // If we got updated data back, use it
        // No need to refresh from API as we already have the updated data
      } else {
        // If no data returned, refresh from API
        await leadController.refreshData();
      }
    } catch (e) {
      CrmSnackBar.showAwesomeSnackbar(
        title: 'Error',
        message: 'Failed to open edit screen: ${e.toString()}',
        contentType: ContentType.failure,
      );
    }
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
