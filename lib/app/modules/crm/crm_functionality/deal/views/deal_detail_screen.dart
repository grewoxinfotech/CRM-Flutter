import 'package:crm_flutter/app/care/constants/ic_res.dart';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/crm/deal/model/deal_model.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/deal/bindings.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/deal/controllers/deal_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/file/controllers/file_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/notes/controllers/note_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/sales_invoice/pages/sales_invoice_edit_page.dart';
import 'package:crm_flutter/app/modules/project/file/widget/file_card.dart';
import 'package:crm_flutter/app/modules/project/invoice/widget/invoice_card.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/model/tab_bar_model.dart';
import 'package:crm_flutter/app/widgets/bar/tab_bar/view/crm_tab_bar.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/common/dialogs/crm_delete_dialog.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/member_card.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:crm_flutter/app/data/network/crm/notes/service/note_service.dart';
import 'package:crm_flutter/app/widgets/dialog/note/note_dialog.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:crm_flutter/app/widgets/common/dialogs/upload_status_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crm_flutter/app/data/network/crm/notes/model/note_model.dart';

import 'package:crm_flutter/app/data/network/sales_invoice/controller/sales_invoice_controller.dart';
import 'package:crm_flutter/app/widgets/button/crm_icon_button.dart';
import 'package:crm_flutter/app/widgets/leads_and_deal/follow_up_card.dart';

import '../../../../project/notes/widget/note_card.dart';
import '../../activity/views/activity_card.dart';
import '../../sales_invoice/pages/sales_invoice_create_page.dart';
import '../widget/deal_overview_card.dart';
import 'deal_edit_screen.dart';

enum FollowUpType { task, meeting, call }

class FollowUpController extends GetxController {
  final Rx<FollowUpType> activeType = Rx<FollowUpType>(FollowUpType.task);

  void setActiveType(FollowUpType type) {
    activeType.value = type;
  }

  @override
  void onInit() {
    super.onInit();
    activeType.value = FollowUpType.task;
  }
}

class DealDetailScreen extends StatelessWidget {
  final String id;

  DealDetailScreen({super.key, required this.id}) {
    if (!Get.isRegistered<FollowUpController>()) {
      Get.put(FollowUpController());
    }
  }

  @override
  Widget build(BuildContext context) {
    DealBinding().dependencies();

    final tabBarController = Get.find<TabBarController>();
    final dealController = Get.find<DealController>();
    final rolesService = Get.find<RolesService>();
    Get.lazyPut<NoteService>(() => NoteService());
    Get.lazyPut<FileController>(() => FileController());
    Get.lazyPut<SalesInvoiceController>(() => SalesInvoiceController());
    final noteController = Get.find<NoteController>();
    final fileController = Get.find<FileController>();
    final salesInvoiceController = Get.find<SalesInvoiceController>();

    // Ensure users are loaded
    dealController.getAllUsers();

    return Scaffold(
      appBar: AppBar(
        title: Text("Deal"),
        leading: CrmBackButton(),
        bottom: CrmTabBar(
          items: [
            TabBarModel(iconPath: ICRes.attach, label: "Overview"),
            TabBarModel(iconPath: ICRes.attach, label: "Files"),
            TabBarModel(iconPath: ICRes.attach, label: "Members"),
            TabBarModel(iconPath: ICRes.attach, label: "Notes"),
            TabBarModel(iconPath: ICRes.attach, label: "Invoices"),
            TabBarModel(iconPath: ICRes.attach, label: "Follow-Ups"),
            TabBarModel(iconPath: ICRes.attach, label: "Activities"),
          ],
        ),
      ),
      body: Obx(() {
        if (dealController.deal.isEmpty) {
          dealController.refreshData();
          return const Center(child: CircularProgressIndicator());
        }

        final deal = dealController.deal.firstWhereOrNull(
          (deal) => deal.id == id,
        );

        if (deal == null) {
          dealController.getDealById(id);
          return const Center(child: CircularProgressIndicator());
        }
        noteController.getNotes(id);

        if (deal.files != null && deal.files!.isNotEmpty) {
          // Convert the raw file data to the format FileController expects
          final filesList =
              deal.files!
                  .map((file) => {'url': file.url, 'filename': file.filename})
                  .toList();
          fileController.setFilesFromData(filesList);
        }

        final sourceName = dealController.getSourceName(deal.source ?? '');
        final statusName = dealController.getStatusName(deal.status ?? '');
        final pipelineName = dealController.getPipelineName(
          deal.pipeline ?? '',
        );

        List<Widget> widgets = [
          _buildOverviewTab(
            deal,
            dealController,
            sourceName,
            statusName,
            pipelineName,
          ),
          _buildFilesTab(fileController, deal.id.toString(), context),
          _buildMembersTab(deal, dealController, rolesService),
          _buildNotesTab(noteController, id, context),
          _buildInvoicesTab(deal.id.toString(), context),
          _buildFollowUpsTab(deal.id.toString(), context),
          _buildActivitiesTab(deal, dealController, context),
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
    DealModel deal,
    DealController dealController,
    String sourceName,
    String statusName,
    String pipelineName,
  ) {
    // Get deal members information
    final memberIds = deal.dealMembers.map((m) => m.memberId).toList();
    final members = dealController.getDealMembers(memberIds);
    final memberNames =
        members.isNotEmpty
            ? members.map((user) => user.username).join(", ")
            : "No members";

    return DealOverviewCard(
      color: Colors.blue,
      id: deal.id.toString(),
      dealTitle: deal.dealTitle.toString(),
      currency: deal.currency.toString(),
      value: deal.value.toString(),
      pipeline: pipelineName,
      stage: dealController.getStageName(deal.stage ?? ''),
      status: statusName,
      label: deal.label.toString(),
      closedDate: deal.closedDate.toString(),
      firstName: deal.firstName.toString(),
      lastName: deal.lastName.toString(),
      email: deal.email.toString(),
      phone: deal.phone.toString(),
      source: sourceName,
      companyName: deal.companyName.toString(),
      website: deal.website.toString(),
      address: deal.address.toString(),
      products: deal.products.toString(),
      files: deal.files.toString(),
      assignedTo: memberNames,
      // Use member names instead of assignedTo
      clientId: deal.clientId.toString(),
      isWon: deal.isWon.toString(),
      companyId: deal.companyId.toString(),
      contactId: deal.contactId.toString(),
      createdBy: deal.createdBy.toString(),
      updatedBy: deal.updatedBy.toString(),
      createdAt: deal.createdAt.toString(),
      updatedAt: deal.updatedAt.toString(),
      onDelete:
          () => CrmDeleteDialog(
            entityType: deal.dealTitle.toString(),
            onConfirm: () {
              dealController.deleteDeal(deal.id.toString());
              Get.back();
            },
          ),
      onEdit: () => _handleEdit(deal, dealController),
    );
  }

  Widget _buildFilesTab(
    FileController fileController,
    String dealId,
    BuildContext context,
  ) {
    // Initial file load
    fileController.refreshFiles(dealId, isDeal: true);

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
                id: "deal_${dealId}_${file.filename}_$i",
                // Make ID unique with index
                role: "File",
                onTap: null,
                onDelete:
                    () => _showDeleteFileDialog(
                      context,
                      fileController,
                      dealId,
                      file.filename ?? '',
                    ),
              );
            },
          ),
        ),
        Positioned(
          right: AppPadding.medium,
          bottom: AppPadding.medium,
          child: FloatingActionButton(
            onPressed: () => _uploadFile(context, dealId),
            child: const Icon(Icons.upload_file, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildMembersTab(
    DealModel deal,
    DealController dealController,
    RolesService rolesService,
  ) {
    // Ensure users are loaded
    if (dealController.users.isEmpty) {
      dealController.getAllUsers();
      return const Center(child: CircularProgressIndicator());
    }

    final memberIds = deal.dealMembers.map((m) => m.memberId).toList();
    final members = dealController.getDealMembers(memberIds);

    if (members.isEmpty && memberIds.isNotEmpty) {
      // If we have member IDs but no matching users, try refreshing users data
      dealController.getAllUsers();
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Loading members data..."),
          ],
        ),
      );
    }

    return ViewScreen(
      itemCount: members.length,
      padding: const EdgeInsets.all(AppPadding.medium),
      itemBuilder: (context, index) {
        final user = members[index];
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
    String dealId,
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
                onDelete: () => noteController.deleteNote(note.id, dealId),
                onEdit:
                    () => _showNoteDialog(
                      context,
                      noteController,
                      dealId,
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
            onPressed: () => _showNoteDialog(context, noteController, dealId),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildInvoicesTab(String dealId, BuildContext context) {
    final salesInvoiceController = Get.find<SalesInvoiceController>();

    // Load invoices for this deal
    _loadInvoices(dealId);

    return Stack(
      children: [
        Obx(() {
          if (salesInvoiceController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final invoices = salesInvoiceController.invoices;

          return ViewScreen(
            itemCount: invoices.length,
            padding: const EdgeInsets.all(AppPadding.medium),
            itemBuilder: (context, index) {
              final invoice = invoices[index];

              return InvoiceCard(
                id: invoice.id,
                leadTitle: invoice.salesInvoiceNumber,
                firstName: salesInvoiceController.getCustomerName(
                  invoice.customer!,
                ),
                leadValue: invoice.total.toString(),
                currency: invoice.currency,
                status: invoice.paymentStatus,
                createdAt: invoice.issueDate.toString(),
                dueDate: invoice.dueDate.toString(),
                pendingAmount: invoice.pendingAmount?.toString(),
                onDelete:
                    () => _showDeleteInvoiceDialog(
                      context,
                      salesInvoiceController,
                      invoice.id!,
                      dealId,
                    ),
                onEdit:
                    () => Get.to(
                      () => SalesInvoiceEditPage(
                        invoice: invoice,
                        dealId: dealId,
                      ),
                    ),
                onTap:
                    () => Get.to(
                      () => SalesInvoiceEditPage(
                        invoice: invoice,
                        dealId: dealId,
                      ),
                    ),
              );
            },
          );
        }),
        Positioned(
          right: AppPadding.medium,
          bottom: AppPadding.medium,
          child: FloatingActionButton(
            onPressed:
                () => Get.to(() => SalesInvoiceCreatePage(dealId: dealId)),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildFollowUpsTab(String dealId, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Text(
                    'Create New Follow-up',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const FollowUpButtons(),
                const SizedBox(height: 6),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Follow-up Tasks',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              color: Get.theme.scaffoldBackgroundColor,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 1, // Replace with actual task list length
                separatorBuilder:
                    (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  // Example task data - replace with actual data from your API
                  return FollowUpCard(
                    id: "50ZJkIYriiIho6Qkt5BQjtB",
                    subject: "hello",
                    dueDate: "2025-05-23",
                    priority: "highest",
                    taskReporter: "27QmTY0BI4nb89DW3lXrly9",
                    status: "in_progress",
                    reminder: {
                      "reminder_date": "2025-05-22",
                      "reminder_time": "04:04:00",
                    },
                    repeat: {
                      "repeat_type": "weekly",
                      "repeat_start_date": "2025-05-23",
                      "repeat_start_time": "00:05:00",
                    },
                    createdBy: "raiser2",
                    createdAt: "2025-05-23T05:47:32.000Z",
                    onEdit: () {
                      // TODO: Implement edit
                    },
                    onDelete: () {
                      // TODO: Implement delete
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitiesTab(
    DealModel deal,
    DealController dealController,
    BuildContext context,
  ) {
    final activityController = dealController.activityController;
    activityController.getActivities(deal.id.toString());

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
              return ActivityCard(activity: activity);
            },
          );
        }),
      ],
    );
  }

  Future<void> _handleEdit(
    DealModel deal,
    DealController dealController,
  ) async {
    dealController.dealTitle.text = deal.dealTitle ?? '';
    dealController.dealValue.text = deal.value?.toString() ?? '';
    dealController.firstName.text = deal.firstName ?? '';
    dealController.lastName.text = deal.lastName ?? '';
    dealController.email.text = deal.email ?? '';
    dealController.phoneNumber.text = deal.phone ?? '';
    dealController.companyName.text = deal.companyName ?? '';
    dealController.address.text = deal.address ?? '';

    dealController.selectedPipeline.value = deal.pipeline ?? '';
    dealController.selectedSource.value = deal.source ?? '';
    dealController.selectedStatus.value = deal.status ?? '';
    dealController.selectedStage.value = deal.stage ?? '';

    await Get.to(() => DealEditScreen(dealId: deal.id.toString()));
    await dealController.getDealById(id);
    await dealController.refreshData();
  }

  void _showDeleteFileDialog(
    BuildContext context,
    FileController fileController,
    String dealId,
    String filename,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => CrmDeleteDialog(
            entityType: "file",
            onConfirm: () async {
              final success = await fileController.deleteFile(
                dealId,
                filename,
                isDeal: true,
              );
              if (success) {
                await fileController.refreshFiles(dealId, isDeal: true);
                final dealController = Get.find<DealController>();
                await dealController.refreshData();
              }
            },
          ),
    );
  }

  void _showNoteDialog(
    BuildContext context,
    NoteController controller,
    String dealId, {
    NoteModel? note,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => NoteDialog(
            leadId: dealId,
            controller: controller,
            note: note,
            onSuccess: () => controller.getNotes(dealId),
          ),
    );
  }

  Future<void> _uploadFile(BuildContext context, String dealId) async {
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
          dealId,
          fileBytes,
          file.name,
          isDeal: true,
        );

        Navigator.pop(context);

        if (responseData != null) {
          await fileController.refreshFiles(dealId, isDeal: true);
          UploadStatusDialog.showSuccess(context);

          // Refresh deal data to get updated files
          final dealController = Get.find<DealController>();
          await dealController.refreshData();
        } else {
          UploadStatusDialog.showError(
            context,
            'File upload failed. Please try again.',
          );
        }
      }
    } catch (e) {
      print('Error uploading file: $e');
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      UploadStatusDialog.showError(context, 'Error uploading file: $e');
    }
  }

  void _showDeleteInvoiceDialog(
    BuildContext context,
    SalesInvoiceController controller,
    String invoiceId,
    String dealId,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => CrmDeleteDialog(
            entityType: "invoice",
            onConfirm: () async {
              final success = await controller.deleteInvoice(invoiceId);
              if (success) {
                // Refresh the invoices list
                await controller.fetchInvoicesForDeal(dealId);
              }
              // Get.back();
            },
          ),
    );
  }

  void _loadInvoices(String dealId) {
    final salesInvoiceController = Get.find<SalesInvoiceController>();
    salesInvoiceController.fetchInvoicesForDeal(dealId);
  }
}

class FollowUpButtons extends StatefulWidget {
  const FollowUpButtons({Key? key}) : super(key: key);

  @override
  State<FollowUpButtons> createState() => _FollowUpButtonsState();
}

class _FollowUpButtonsState extends State<FollowUpButtons> {
  int activeIndex = 0; // 0 for Task, 1 for Meeting, 2 for Call

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CrmIconButton(
              icon: Icons.task_outlined,
              label: 'Task',
              color: Colors.blue[600],
              defaultActive: activeIndex == 0,
              onPressed: () {
                setState(() {
                  activeIndex = 0;
                });
                // TODO: Implement task creation
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CrmIconButton(
              icon: Icons.groups_outlined,
              label: 'Meeting',
              color: Colors.green[600],
              defaultActive: activeIndex == 1,
              onPressed: () {
                setState(() {
                  activeIndex = 1;
                });
                // TODO: Implement meeting creation
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CrmIconButton(
              icon: Icons.phone_outlined,
              label: 'Call',
              color: Colors.orange[600],
              defaultActive: activeIndex == 2,
              onPressed: () {
                setState(() {
                  activeIndex = 2;
                });
                // TODO: Implement call creation
              },
            ),
          ),
        ],
      ),
    );
  }
}
