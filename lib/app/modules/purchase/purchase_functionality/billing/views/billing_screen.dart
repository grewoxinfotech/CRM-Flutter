import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/care/utils/format.dart';
import 'package:crm_flutter/app/data/network/sales/customer/model/customer_model.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/billing/views/bill_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/database/storage/secure_storage_service.dart';
import '../../../../../widgets/common/indicators/crm_loading_circle.dart';
import '../../../../access/controller/access_controller.dart';
import '../../../../sales/sales_functionality/customer/controllers/customer_controller.dart';
import '../controllers/billing_controller.dart';
import '../widget/billing_card.dart';
import 'billing_add_screen.dart';

class BillingScreen extends StatelessWidget {
  BillingScreen({super.key});

  String? customerId;

  /// Retrieve the customer/user ID from secure storage
  void getCustomerId() async {
    customerId = (await SecureStorage.getUserData())?.id;
  }

  @override
  Widget build(BuildContext context) {
    final AccessController accessController = Get.find<AccessController>();
    getCustomerId();

    // Controllers
    Get.lazyPut<BillingController>(() => BillingController());
    final BillingController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text("Billings")),
      floatingActionButton:
          accessController.can(
                AccessModule.purchaseBilling,
                AccessAction.create,
              )
              ? FloatingActionButton(
                onPressed: () {
                  if (customerId != null) {
                    Get.to(() => BillingCreatePage());
                  }
                },
                child: const Icon(Icons.add, color: Colors.white),
              )
              : null,
      body: FutureBuilder(
        future: controller.loadInitial(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CrmLoadingCircle());
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                width: 250,
                child: Text(
                  'Server Error:\n${snapshot.error}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() {
              Get.lazyPut<CustomerController>(() => CustomerController());
              final CustomerController customerController = Get.find();

              if (!controller.isLoading.value && controller.items.isEmpty) {
                return const Center(child: Text("No Billings found."));
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
                  child: ListView.builder(
                    itemCount: controller.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.items.length) {
                        final billing = controller.items[index];

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            child: BillingCard(
                              id: billing.id,
                              billNumber: billing.billNumber ?? "Billing",
                              totalAmount: billing.total.toString(),
                              currency: billing.currency,
                              status: billing.status,
                              issuedDate: formatDateString(
                                billing.createdAt.toString(),
                              ),
                              onTap: () {
                                Get.to(() => BillDetailScreen(bill: billing));
                              },
                            ),
                          ),
                        );
                      } else if (controller.isPaging.value) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              );
            });
          } else {
            return const Center(child: Text("Something went wrong."));
          }
        },
      ),
    );
  }
}
