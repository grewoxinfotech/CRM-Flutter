import 'package:crm_flutter/app/modules/users/controllers/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/ic_res.dart';
import '../../../../../data/network/crm/company/model/company_model.dart';
import '../../../../../data/network/crm/lead/model/lead_model.dart';
import '../../../../../widgets/_screen/view_screen.dart';
import '../../../../../widgets/bar/tab_bar/controller/tab_bar_controller.dart';
import '../../../../../widgets/bar/tab_bar/model/tab_bar_model.dart';
import '../../../../../widgets/bar/tab_bar/view/crm_tab_bar.dart';
import '../../../../../widgets/button/crm_back_button.dart';
import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../../widgets/date_time/format_date.dart';
import '../../contact/controller/contact_controller.dart';
import '../../contact/views/contact_detail_screen.dart';
import '../../contact/widget/contact_card.dart';
import '../../deal/bindings.dart';
import '../../deal/controllers/deal_controller.dart';
import '../../deal/views/deal_detail_screen.dart';
import '../../lead/bindings/lead_binding.dart';
import '../../lead/controllers/lead_controller.dart';
import '../../lead/views/lead_detail_screen.dart';
import '../../lead/widgets/lead_card.dart';
import '../../deal/widget/deal_card.dart';
import '../controller/company_controller.dart';
import '../widget/company_overview_card.dart';

class CompanyDetailScreen extends StatefulWidget {
  final String? id;

  const CompanyDetailScreen({super.key, this.id});

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen> {
  final companyController = Get.put(CompanyController());
  // CompanyModel? companyModel;
  Data? company;

  @override
  void initState() {
    super.initState();
    _loadCompany();
  }

  Future<void> _loadCompany() async {
    company = await companyController.getCompanyById(widget.id!);
    if (mounted) setState(() {});
    if (company != null) {}
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<UsersController>(() => UsersController());
    DealBinding().dependencies();
    Get.lazyPut<LeadController>(() => LeadController());

    final tabBarController = Get.find<TabBarController>();
    final dealController = Get.find<DealController>();
    Get.lazyPut<ContactController>(() => ContactController());
    final contactController = Get.find<ContactController>();
    Get.put(UsersController());
    Get.lazyPut<LeadController>(() => LeadController());
    final leadController = Get.find<LeadController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Overview"),
        leading: CrmBackButton(),
        bottom: CrmTabBar(
          items: [
            TabBarModel(iconPath: ICRes.attach, label: "Overview"),
            TabBarModel(iconPath: ICRes.attach, label: "Company Leads"),
            TabBarModel(iconPath: ICRes.attach, label: "Company Deals"),
            TabBarModel(iconPath: ICRes.attach, label: "Company Contacts"),
          ],
        ),
      ),
      body: Obx(() {
        if (companyController.companies.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            companyController.refreshData();
          });
          return const Center(child: CircularProgressIndicator());
        }

        List<Widget> widgets = [
          if (company != null) _buildOverviewTab(company!),
          if (company != null) _buildLeadsTab(company!, leadController),
          if (company != null) _buildDealsTab(company!, dealController),
          if (company != null) _buildContactTab(company!, contactController),
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

  Widget _buildOverviewTab(Data company) {
    // print("[DEBUG]=>:${company.companyName}");
    return CompanyOverviewCard(
      color: Colors.teal,
      id: company.id ?? '',
      companyName: company.companyName ?? '',
      // industry: company.industry ?? '',
      phoneNumber: company.phoneNumber ?? '',
      email: company.email ?? '',
      website: company.website ?? '',
      billingAddress: company.billingAddress ?? '',

      createdBy: company.createdBy ?? '',
      createdAt: company.createdAt ?? '',
      onDelete:
          () => CrmDeleteDialog(
            // Add delete logic here
            // onConfirm: () {
            //   companyController.deleteCompany(company.id!);
            //   Get.back();
            // },
          ),
    );
  }

  Widget _buildLeadsTab(Data company, LeadController leadController) {
    final companyId = company.id;
    final leads = leadController.getLeadsByCompanyId(companyId!);
    if (leads.isEmpty) {
      return const Center(child: Text("No leads available"));
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
    //       leadMembers: lead.leadMembers?.leadMembers?.length.toString() ?? '0',
    //       status: lead.status ?? '',
    //       interestLevel: lead.interestLevel ?? '',
    //       leadScore: lead.leadScore?.toString() ?? '',
    //       isConverted: lead.isConverted?.toString() ?? '',
    //       clientId: lead.clientId ?? '',
    //       createdBy: lead.createdBy ?? '',
    //       updatedBy: lead.updatedBy ?? '',
    //       createdAt: formatDate(lead.createdAt ?? ''),
    //       updatedAt: formatDate(lead.updatedAt ?? ''),
    //       onTap: () => _navigateToLeadDetail(lead, leadController),
    //     );
    //   },
    // );

    return ViewScreen(
      itemCount: leadController.leads.length,
      itemBuilder: (context, i) {
        final data = leadController.leads[i];
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
          onTap: () => _navigateToLeadDetail(data, leadController),
        );
      },
    );
  }

  Widget _buildDealsTab(Data company, DealController dealController) {
    final companyId = company.id;
    final deals = dealController.getDealsByCompanyId(companyId!);
    if (deals.isEmpty) {
      return const Center(child: Text("No deals available"));
    }

    // return ViewScreen(
    //   itemCount: deals.length,
    //   itemBuilder: (context, index) {
    //     final deal = deals[index];
    //     final source = dealController.sourceOptions.firstWhereOrNull(
    //       (element) => element['id'] == deal.source,
    //     );
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
    //       source: source != null ? source['name'] ?? '' : '',
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
    //       color: Colors.redAccent,
    //       onTap: () => Get.to(() => DealDetailScreen(id: deal.id!)),
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
  }

  Future<void> _navigateToLeadDetail(
    LeadModel lead,
    LeadController controller,
  ) async {
    if (lead.id != null) {
      await Get.off(
        () => LeadDetailScreen(id: lead.id!, isCompanyScreen: true),
        binding: LeadBinding(),
      );
      controller.refreshData();
    } else {
      Get.snackbar('Error', 'Lead ID is missing');
    }
  }

  // _buildContactTab(Data company, ContactController contactController) {
  //   final companyId = company.id;
  //   final contacts = contactController.getContactsByCompanyId(companyId!);
  //   if (contacts.isEmpty) {
  //     return const Center(child: Text("No Contact available"));
  //   }
  //   return Obx(() {
  //     if (contactController.isLoading.value) {
  //       return const Center(child: CircularProgressIndicator());
  //     }
  //     if (contactController.error.isNotEmpty) {
  //       return Center(child: Text(contactController.error.value));
  //     }
  //     if (contactController.contacts.isEmpty) {
  //       return const Center(child: Text('No contacts found'));
  //     }
  //
  //     return ListView.builder(
  //       padding: const EdgeInsets.symmetric(vertical: 8),
  //       itemCount: contactController.contacts.length,
  //       itemBuilder: (context, index) {
  //         final contact = contactController.contacts[index];
  //         return ContactCard(contact: contact);
  //       },
  //     );
  //   });
  // }
  Widget _buildContactTab(Data company, ContactController contactController) {
    final companyId = company.id;

    return Obx(() {
      if (contactController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (contactController.error.isNotEmpty) {
        return Center(child: Text(contactController.error.value));
      }

      final contacts = contactController.getContactsByCompanyId(companyId!);

      if (contacts.isEmpty) {
        return const Center(child: Text("No Contact available"));
      }

      return ViewScreen(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ContactCard(
            contact: contact,
            onTap: (contact) {
              return Get.off(ContactDetailScreen(id: contact.id));
            },
          );
        },
      );
    });
  }
}
