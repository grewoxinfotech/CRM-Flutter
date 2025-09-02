import 'package:crm_flutter/app/data/network/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/contact/views/contact_add_screen.dart';

import 'package:crm_flutter/app/modules/users/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/ic_res.dart';
import '../../../../../data/network/crm/contact/medel/contact_medel.dart';
import '../../../../../widgets/_screen/view_screen.dart';
import '../../../../../widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import '../../../../../widgets/bar/tab_bar/model/tab_bar_model.dart';
import '../../../../../widgets/bar/tab_bar/view/crm_tab_bar.dart';
import '../../../../../widgets/button/crm_back_button.dart';
import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../../widgets/date_time/format_date.dart';
import '../../company/view/company_detail_screen.dart';
import '../../deal/bindings.dart';
import '../../deal/controllers/deal_controller.dart';
import '../../deal/views/deal_detail_screen.dart';
import '../../deal/views/deal_edit_screen.dart';
import '../../deal/widget/deal_card.dart';
import '../../deal/widget/deal_overview_card.dart';
import '../../lead/bindings/lead_binding.dart';
import '../../lead/controllers/lead_controller.dart';
import '../../lead/views/lead_detail_screen.dart';
import '../../lead/widgets/lead_card.dart';
import '../controller/contact_controller.dart';
import '../widget/contact_overview_card.dart';

//
class ContactDetailScreen extends StatefulWidget {
  final String? id;
  final bool isFromCompanyScreen;

  const ContactDetailScreen({
    super.key,
    this.id,
    this.isFromCompanyScreen = false,
  });

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}
//
// class _ContactDetailScreenState extends State<ContactDetailScreen> {
//   final controller = Get.put(ContactController());
//   ContactModel? contact;
//   @override
//   void initState() async {
//     final contact = await controller.getContactById(widget.id!);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('''
// id: ${contact!.id}
// contactOwner: ${contact!.contactOwner}
// firstName: ${contact!.firstName}
// lastName: ${contact!.lastName}
// companyId: ${contact!.companyId}
// ''');
//
//     DealBinding().dependencies();
//
//     final tabBarController = Get.find<TabBarController>();
//     final dealController = Get.find<DealController>();
//     final contactController = Get.find<ContactController>();
//
//     dealController.getAllUsers();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Contact Overview"),
//         leading: CrmBackButton(),
//         bottom: CrmTabBar(
//           items: [
//             TabBarModel(iconPath: ICRes.attach, label: "Overview"),
//             TabBarModel(iconPath: ICRes.attach, label: "Contact Leads"),
//             TabBarModel(iconPath: ICRes.attach, label: "Contact Deals"),
//           ],
//         ),
//       ),
//       body: Obx(() {
//         if (dealController.deal.isEmpty) {
//           contactController.refreshData();
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final deal = dealController.deal.first;
//
//         List<Widget> widgets = [
//           //  _buildOverviewTab(contactController,),
//
//           //other tab add here
//         ];
//
//         return PageView.builder(
//           itemCount: widgets.length,
//           controller: tabBarController.pageController,
//           onPageChanged: tabBarController.onPageChanged,
//           itemBuilder: (context, i) => widgets[i],
//         );
//       }),
//     );
//   }
//
//   Widget _buildOverviewTab(
//     ContactModel contact,
//     ContactController dealController,
//     String sourceName,
//     String statusName,
//     String pipelineName,
//   ) {
//     return ContactOverviewCard(
//       color: Colors.blue,
//       id: contact.id.toString(),
//       firstName: contact.firstName.toString(),
//       lastName: contact.lastName.toString(),
//       email: contact.email.toString(),
//       phone: contact.phone.toString(),
//       source: sourceName,
//       companyName: contact.companyId.toString(),
//       website: contact.website.toString(),
//       address: contact.address.toString(),
//       createdBy: contact.createdBy.toString(),
//       createdAt: contact.createdAt.toString(),
//       onDelete:
//           () => CrmDeleteDialog(
//             // entityType: contact.dealTitle.toString(),
//             //  onConfirm: () {
//             //    contactController.deleteContact(contact.id.toString());
//             //    Get.back();
//             //  },
//           ),
//       //onEdit: () => _handleEdit(deal, dealController),
//     );
//   }
//
//   Future<void> _handleEdit(
//     DealModel deal,
//     DealController dealController,
//   ) async {
//     dealController.dealTitle.text = deal.dealTitle ?? '';
//     dealController.dealValue.text = deal.value?.toString() ?? '';
//     dealController.firstName.text = deal.firstName ?? '';
//     dealController.lastName.text = deal.lastName ?? '';
//     dealController.email.text = deal.email ?? '';
//     dealController.phoneNumber.text = deal.phone ?? '';
//     dealController.companyName.text = deal.companyName ?? '';
//     dealController.address.text = deal.address ?? '';
//
//     dealController.selectedPipeline.value = deal.pipeline ?? '';
//     dealController.selectedSource.value = deal.source ?? '';
//     dealController.selectedStatus.value = deal.status ?? '';
//     dealController.selectedStage.value = deal.stage ?? '';
//
//     await Get.to(() => DealEditScreen(dealId: deal.id.toString()));
//     await dealController.getDealById(deal.id.toString());
//     await dealController.refreshData();
//   }
// }

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  final controller = Get.put(ContactController());
  ContactModel? contact;

  @override
  void initState() {
    super.initState();
    _loadContact();
  }

  Future<void> _loadContact() async {
    contact = await controller.getContactById(widget.id!);
    if (mounted) setState(() {});
    if (contact != null) {}
  }

  @override
  Widget build(BuildContext context) {
    DealBinding().dependencies();

    final tabBarController = Get.find<TabBarController>();
    final dealController = Get.find<DealController>();
    final contactController = Get.find<ContactController>();
    Get.put(UsersController());
    Get.lazyPut<LeadController>(() => LeadController());
    final leadController = Get.find<LeadController>();

    dealController.getAllUsers();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Overview"),
        leading: CrmBackButton(
          onTap: () {
            if (widget.isFromCompanyScreen) {
              final matchedContact = contactController.contacts
                  .firstWhereOrNull((contact) => contact.id == widget.id);
              if (matchedContact != null) {
                Get.off(
                  () => CompanyDetailScreen(id: matchedContact.companyId),
                );
              }
            } else {
              Get.back();
            }
          },
        ),
        bottom: CrmTabBar(
          items: [
            TabBarModel(iconPath: ICRes.attach, label: "Overview"),
            TabBarModel(iconPath: ICRes.attach, label: "Contact Leads"),
            TabBarModel(iconPath: ICRes.attach, label: "Contact Deals"),
          ],
        ),
      ),
      body: Obx(() {
        if (dealController.deal.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            contactController.refreshData();
          });
          return const Center(child: CircularProgressIndicator());
        }

        final deal = dealController.deal.first;

        List<Widget> widgets = [
          if (contact != null)
            _buildOverviewTab(
              contact!,
              contactController,
              "Source",
              "Status",
              "Pipeline",
            ),
          _buildContactLeadsTab(contact, leadController),
          _buildContactDealsTab(contact, dealController),
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
    ContactModel contact,
    ContactController dealController,
    String sourceName,
    String statusName,
    String pipelineName,
  ) {
    return ContactOverviewCard(
      color: Colors.blue,
      id: contact.id.toString(),
      firstName: contact.firstName.toString(),
      lastName: contact.lastName.toString(),
      email: contact.email.toString(),
      phone: contact.phone.toString(),
      source: sourceName,
      companyName: contact.companyId.toString(),
      website: contact.website.toString(),
      address: contact.address.toString(),
      createdBy: contact.createdBy.toString(),
      createdAt: contact.createdAt.toString(),
      onDelete:
          () => Get.dialog(
            CrmDeleteDialog(
              entityType:
                  '${contact.firstName.toString()} ${contact.lastName.toString()}',
              onConfirm: () {
                controller.deleteContact(contact.id.toString());
                Get.back();
              },
            ),
          ),
      onEdit:
          () => Get.to(
            () => ContactAddScreen(isFromEdit: true, contactModel: contact),
          ),
    );
  }

  Widget _buildContactLeadsTab(
    ContactModel? contact,
    LeadController leadController,
  ) {
    // Safely handle null contact or id
    final contactId = contact?.id;
    if (contactId == null) {
      return const Center(child: Text("No contact information"));
    }

    final leads = leadController.getLeadsByCustomerId(contactId);
    if (leads.isEmpty) {
      return const Center(child: Text("No leads available"));
    }

    return Stack(
      children: [
        Obx(() {
          if (leadController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // return ViewScreen(
          //   itemCount: leads.length,
          //   itemBuilder: (context, index) {
          //     final lead = leads[index];
          //     return LeadCard(
          //       id: lead.id ?? '',
          //       color: Colors.green,
          //       inquiryId: lead.inquiryId ?? '',
          //       leadTitle: lead.leadTitle ?? '',
          //       currency: lead.currency ?? '',
          //       leadValue: lead.leadValue?.toString() ?? '',
          //       leadMembers:
          //           lead.leadMembers?.leadMembers?.isNotEmpty == true
          //               ? lead.leadMembers!.leadMembers!.length.toString()
          //               : '',
          //       status: lead.status ?? '',
          //
          //       interestLevel: lead.interestLevel ?? '',
          //       leadScore: lead.leadScore?.toString() ?? '',
          //       isConverted: lead.isConverted?.toString() ?? '',
          //       clientId: lead.clientId ?? '',
          //       createdBy: lead.createdBy ?? '',
          //       updatedBy: lead.updatedBy ?? '',
          //       createdAt: formatDate(lead.createdAt?.toString() ?? ''),
          //       updatedAt: formatDate(lead.updatedAt?.toString() ?? ''),
          //       onTap: () => _navigateToDetail(lead, leadController),
          //     );
          //   },
          // );
          return ViewScreen(
            itemCount: leads.length,
            itemBuilder: (context, i) {
              final data = leads[i];
              final status = leadController.statusOptions.firstWhereOrNull(
                    (element) => element['id'] == data.status,
              );

              final currency = leadController.currencies.firstWhereOrNull(
                    (element) => element.id == data.currency,
              );

              final source = leadController.sourceOptions.firstWhereOrNull(
                    (element) => element['id'] == data.source,
              );

              final category = leadController.categoryOptions.firstWhereOrNull(
                    (element) => element['id'] == data.category,
              );

              return LeadCard(
                id: data.id ?? '',
                color: Colors.green,
                inquiryId: data.inquiryId ?? '',
                leadTitle: data.leadTitle ?? '',
                leadStage: leadController.getStageName(data.leadStage ?? ''),
                pipeline: leadController.getPipelineName(data.pipeline ?? ''),
                currency: currency != null ? currency.currencyIcon : '',
                leadValue: data.leadValue?.toString() ?? '',
                source: source != null ? source['name'] ?? '' : '',
                // companyName: controller.getCompanyDisplayName(data),
                // firstName: data.firstName ?? '',
                // lastName: data.lastName ?? '',
                // phoneCode: data.phoneCode ?? '',
                // telephone: data.telephone ?? '',
                // email: data.email ?? '',
                // address: data.address ?? '',
                leadMembers:
                data.leadMembers?.leadMembers?.isNotEmpty == true
                    ? data.leadMembers!.leadMembers!.length.toString()
                    : '',
                category: category != null ? category['name'] ?? '' : '',
                // files: data.files.isNotEmpty ? data.files.length.toString() : '',
                // Use the status directly from the API instead of trying to map it
                status:
                status != null ? status['name']!.capitalize ?? '' : '',

                interestLevel: data.interestLevel ?? '',
                leadScore: data.leadScore?.toString() ?? '',
                isConverted: data.isConverted?.toString() ?? '',
                clientId: data.clientId ?? '',
                createdBy: data.createdBy ?? '',
                updatedBy: data.updatedBy ?? '',
                createdAt: formatDate(data.createdAt?.toString() ?? ''),
                updatedAt: formatDate(data.updatedAt?.toString() ?? ''),
                onTap: () => _navigateToDetail(data, leadController),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _buildContactDealsTab(
    ContactModel? contact,
    DealController dealController,
  ) {
    // Safely handle null contact or id
    final contactId = contact?.id;
    if (contactId == null) {
      return const Center(child: Text("No contact information"));
    }

    final deals = dealController.getDealsByCustomerId(contactId);
    if (deals.isEmpty) {
      return const Center(child: Text("No deals available"));
    }

    return Stack(
      children: [
        Obx(() {
          if (dealController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // return ViewScreen(
          //   itemCount: deals.length,
          //   itemBuilder: (context, index) {
          //     final deal = deals[index];
          //     return DealCard(
          //       id: deal.id.toString(),
          //       dealTitle: deal.dealTitle.toString(),
          //       currency: deal.currency.toString(),
          //       value: deal.value.toString(),
          //       pipeline: deal.pipeline.toString(),
          //       stage: deal.stage.toString(),
          //       status: deal.status.toString(),
          //       label: deal.label.toString(),
          //       closedDate: deal.closedDate.toString(),
          //       firstName: deal.firstName.toString(),
          //       lastName: deal.lastName.toString(),
          //       email: deal.email.toString(),
          //       phone: deal.phone.toString(),
          //       source: deal.source.toString(),
          //       companyName: deal.companyName.toString(),
          //       website: deal.website.toString(),
          //       address: deal.address.toString(),
          //       products: deal.products.toString(),
          //       files: deal.files.toString(),
          //       assignedTo: deal.assignedTo.toString(),
          //       clientId: deal.clientId.toString(),
          //       isWon: deal.isWon.toString(),
          //       companyId: deal.companyId.toString(),
          //       contactId: deal.contactId.toString(),
          //       createdBy: formatDate(deal.createdBy.toString()),
          //       updatedBy: formatDate(deal.updatedBy.toString()),
          //       createdAt: formatDate(deal.createdAt.toString()),
          //       updatedAt: formatDate(deal.updatedAt.toString()),
          //       color: Get.theme.colorScheme.error,
          //       onTap:
          //           () =>
          //               (deal.id != null)
          //                   ? Get.to(() => DealDetailScreen(id: deal.id!))
          //                   : Get.snackbar('Error', 'deal ID is missing'),
          //       onEdit: () {},
          //       onDelete: () {},
          //     );
          //   },
          // );

          return ViewScreen(
            itemCount: deals.length,
            itemBuilder: (context, i) {
              final data = deals[i];


              final source = dealController.sourceOptions
                  .firstWhereOrNull(
                    (element) => element['id'] == data.source,
              );

              final currency = dealController.currencies.firstWhereOrNull(
                    (element) => element.id == data.currency,
              );

              final category = dealController.categoryOptions.firstWhereOrNull((element) => element['id']==data.category,);

              return DealCard(
                id: data.id.toString(),
                dealTitle: data.dealTitle.toString(),
                currency: currency != null ? currency.currencyIcon : '',
                value: data.value.toString(),
                pipeline: dealController.getPipelineName(data.pipeline ?? ''),
                stage: dealController.getStageName(data.stage ?? ''),
                category: category!=null ? category['name'] ?? '' : '',
                status: data.status.toString(),
                label: data.label.toString(),
                closedDate: data.closedDate.toString(),
                firstName: data.firstName.toString(),
                lastName: data.lastName.toString(),
                email: data.email.toString(),
                phone: data.phone.toString(),
                source: source != null ? source['name'] ?? '' : '',
                companyName: data.companyName.toString(),
                website: data.website.toString(),
                address: data.address.toString(),
                products: data.products.toString(),
                files: data.files.toString(),
                assignedTo: data.assignedTo.toString(),
                clientId: data.clientId.toString(),
                isWon: data.isWon.toString(),
                companyId: data.companyId.toString(),
                contactId: data.contactId.toString(),
                createdBy: formatDate(data.createdBy.toString()),
                updatedBy: formatDate(data.updatedBy.toString()),
                createdAt: formatDate(data.createdAt.toString()),
                updatedAt: formatDate(data.updatedAt.toString()),
                color: Get.theme.colorScheme.error,
                onTap:
                    () =>
                (data.id != null)
                    ? Get.to(() => DealDetailScreen(id: data.id!))
                    : Get.snackbar('Error', 'deal ID is missing'),
                onEdit: () {},
                onDelete: () {},
              );
            },
          );
        }),
      ],
    );
  }

  Future<void> _navigateToDetail(
    LeadModel data,
    LeadController controller,
  ) async {
    if (data.id != null) {
      await Get.off(
        () => LeadDetailScreen(id: data.id!, isContactScreen: true),
        binding: LeadBinding(),
      );
      controller.refreshData();
    } else {
      Get.snackbar('Error', 'Lead ID is missing');
    }
  }
}
