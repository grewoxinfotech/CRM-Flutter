//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../../../widgets/button/crm_back_button.dart';
// import '../../deal/views/deal_add_screen.dart';
// import '../controller/company_controller.dart';
// import '../widget/company_card.dart';
// import 'company_detail_screen.dart';
//
// class CompanyScreen extends StatelessWidget {
//   CompanyScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut<CompanyController>(() => CompanyController());
//     final CompanyController companyController = Get.put(CompanyController());
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
//         title: const Text("Companies"),
//         centerTitle: false,
//         backgroundColor: Colors.transparent,
//       ),
//       // floatingActionButton: CrmButton(
//       //   title: "Add Company",
//       //   onTap: () => Get.to(ContactAddScreen()),
//       // ),
//       body: Obx(() {
//         if (companyController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (companyController.error.isNotEmpty) {
//           return Center(child: Text(companyController.error.value));
//         }
//         if (companyController.companies.isEmpty) {
//           return const Center(child: Text('No contacts found'));
//         }
//
//         return ListView.builder(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           itemCount: companyController.companies.length,
//           itemBuilder: (context, index) {
//             final company = companyController.companies[index];
//             return GestureDetector(
//               onTap: (){
//                 Get.to(()=>CompanyDetailScreen(id: company.id!));
//               },
//                 child: CompanyCard(company: company));
//           },
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/button/crm_back_button.dart';
import '../../../../../widgets/common/indicators/crm_loading_circle.dart';
import '../../../../../widgets/_screen/view_screen.dart';
import '../controller/company_controller.dart';
import '../widget/company_card.dart';
import 'company_detail_screen.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.lazyPut<CompanyController>(() => CompanyController());
    final controller = Get.find<CompanyController>();

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
        title: const Text("Companies"),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add_rounded, color: Colors.white),
      //   onPressed: () async {
      //     await Get.to(() => const CompanyAddScreen());
      //     controller.refreshData();
      //   },
      // ),
      body: FutureBuilder(
        future: controller.refreshData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CrmLoadingCircle();
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                width: 250,
                child: Text(
                  'Server Error : \n${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else {
            return Obx(() {
              if (controller.companies.isEmpty) {
                return const Center(child: Text("No companies available."));
              }

              return ViewScreen(
                itemCount: controller.companies.length,
                itemBuilder: (context, index) {
                  final company = controller.companies[index];
                  return GestureDetector(
                    onTap: () async {
                      if (company.id != null) {
                        await Get.to(
                              () => CompanyDetailScreen(id: company.id!),
                        );
                        controller.refreshData();
                      } else {
                        Get.snackbar("Error", "Company ID is missing");
                      }
                    },
                    child: CompanyCard(company: company),
                  );
                },
              );
            });
          }
        },
      ),
    );
  }
}
