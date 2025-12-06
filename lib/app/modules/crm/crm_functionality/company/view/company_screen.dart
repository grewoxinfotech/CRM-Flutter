
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

      body: FutureBuilder(
        future: controller.loadInitial(),
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
              if (controller.items.isEmpty) {
                return const Center(child: Text("No companies available."));
              }

              return NotificationListener<ScrollEndNotification>(
                onNotification: (scrollEnd) {
                  final metrics = scrollEnd.metrics;
                  if (metrics.atEdge && metrics.pixels != 0) {
                    controller.loadMore();
                  }
                  return false;
                },
                child: RefreshIndicator(
                  onRefresh: controller.refreshList,
                  child: ViewScreen(
                    itemCount: controller.items.length,
                    itemBuilder: (context, index) {
                      final company = controller.items[index];
                      return GestureDetector(
                        onTap: () async {
                          if (company.id != null) {
                            await Get.to(
                              () => CompanyDetailScreen(id: company.id!),
                            );
                            controller.refreshList();
                          } else {
                            Get.snackbar("Error", "Company ID is missing");
                          }
                        },
                        child: CompanyCard(company: company),
                      );
                    },
                  ),
                ),
              );
            });
          }
        },
      ),
    );
  }
}
