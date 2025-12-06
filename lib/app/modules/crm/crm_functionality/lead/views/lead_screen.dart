import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/data/network/crm/lead/model/lead_model.dart';
import 'package:crm_flutter/app/data/network/user/role/service/roles_service.dart';
import 'package:crm_flutter/app/modules/access/controller/access_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/bindings/lead_binding.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/controllers/lead_controller.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/views/lead_detail_screen.dart';
import 'package:crm_flutter/app/modules/crm/crm_functionality/lead/widgets/lead_card.dart';
import 'package:crm_flutter/app/modules/role/controllers/role_controller.dart';
import 'package:crm_flutter/app/modules/users/controllers/users_controller.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/button/crm_back_button.dart';
import 'package:crm_flutter/app/widgets/button/crm_button.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:crm_flutter/app/widgets/date_time/format_date.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'lead_add_screen.dart';

class LeadScreen extends StatelessWidget {
  const LeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accessController = Get.find<AccessController>();

    // Initialize required controllers
    Get.put(UsersController());
    Get.put(RolesService());
    Get.put(RoleController());

    // Initialize the LabelController first
    Get.put(LabelController());

    // Then initialize the LeadController which depends on LabelController
    Get.lazyPut<LeadController>(() => LeadController());
    final controller = Get.find<LeadController>();

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        leading: CrmBackButton(color: Get.theme.colorScheme.onPrimary),
        title: const Text("Leads"),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_rounded, color: Colors.white),
        onPressed: () async {
          await Get.to(() => LeadCreateScreen());
          controller.refreshData();
        },
      ),
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
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          } else {
            return Obx(() {
              if (controller.items.isEmpty) {
                return const Center(child: Text("No leads available."));
              }

              return NotificationListener<ScrollNotification>(
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
                    itemBuilder: (context, i) {
                      final data = controller.items[i];
                      final status = controller.statusOptions.firstWhereOrNull(
                        (element) => element['id'] == data.status,
                      );

                      final currency = controller.currencies.firstWhereOrNull(
                        (element) => element.id == data.currency,
                      );

                      final source = controller.sourceOptions.firstWhereOrNull(
                        (element) => element['id'] == data.source,
                      );

                      final category = controller.categoryOptions.firstWhereOrNull(
                        (element) => element['id'] == data.category,
                      );

                      return LeadCard(
                        id: data.id ?? '',
                        color: Colors.green,
                        inquiryId: data.inquiryId ?? '',
                        leadTitle: data.leadTitle ?? '',
                        leadStage: controller.getStageName(data.leadStage ?? ''),
                        pipeline: controller.getPipelineName(data.pipeline ?? ''),
                        currency: currency != null ? currency.currencyIcon : '',
                        leadValue: data.leadValue?.toString() ?? '',
                        source: source != null ? source['name'] ?? '' : '',

                        leadMembers:
                            data.leadMembers?.leadMembers?.isNotEmpty == true
                                ? data.leadMembers!.leadMembers!.length.toString()
                                : '',
                        category: category != null ? category['name'] ?? '' : '',

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
                        onTap: () => _navigateToDetail(data, controller),
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

  Future<void> _navigateToDetail(
      LeadData data,
    LeadController controller,
  ) async {
    if (data.id != null) {
      await Get.to(
        () => LeadDetailScreen(id: data.id!),
        binding: LeadBinding(),
      );
      controller.refreshData();
    } else {
      Get.snackbar('Error', 'Lead ID is missing');
    }
  }
}
