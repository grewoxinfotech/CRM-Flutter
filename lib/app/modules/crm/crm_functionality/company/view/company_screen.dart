
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/button/crm_back_button.dart';
import '../../deal/views/deal_add_screen.dart';
import '../controller/company_controller.dart';
import '../widget/company_card.dart';

class CompanyScreen extends StatelessWidget {
  CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<CompanyController>(() => CompanyController());
    final CompanyController companyController = Get.put(CompanyController());

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Contacts'),
      //   actions: [IconButton(
      //     icon: const Icon(Icons.refresh),
      //     onPressed: contactController.fetchContacts,
      //   )],
      // ),
      appBar: AppBar(
        leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
        title: const Text("Companies"),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      // floatingActionButton: CrmButton(
      //   title: "Add Company",
      //   onTap: () => Get.to(ContactAddScreen()),
      // ),
      body: Obx(() {
        if (companyController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (companyController.error.isNotEmpty) {
          return Center(child: Text(companyController.error.value));
        }
        if (companyController.companies.isEmpty) {
          return const Center(child: Text('No contacts found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: companyController.companies.length,
          itemBuilder: (context, index) {
            final company = companyController.companies[index];
            return CompanyCard(company: company);
          },
        );
      }),
    );
  }
}
