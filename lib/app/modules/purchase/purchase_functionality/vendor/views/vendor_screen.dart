import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/vendor/Widget/vendor_card.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/vendor/contoller/vendor_controller.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/vendor/views/add_vendor_screen.dart';
import 'package:crm_flutter/app/modules/purchase/purchase_functionality/vendor/views/vendor_detail_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../access/controller/access_controller.dart';
import '../binding/vendorbinding.dart';

class VendorsScreen extends StatelessWidget {
  const VendorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccessController accessController = Get.find<AccessController>();
    Get.lazyPut(() => VendorController());
    final VendorController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text("Vendors")),
      floatingActionButton:
          accessController.can(AccessModule.purchaseVendor, AccessAction.create)
              ? FloatingActionButton(
                onPressed:
                    () => Get.to(
                      () => AddVendorScreen(),
                      binding: VendorBinding(),
                    ),
                child: const Icon(Icons.add),
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
                ),
              ),
            );
          } else {
            return Obx(() {
              if (!controller.isLoading.value && controller.items.isEmpty) {
                return const Center(child: Text("No vendors found."));
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
                  onRefresh: controller.refreshVendors,
                  child: ListView.builder(
                    itemCount: controller.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.items.length) {
                        final vendor = controller.items[index];
                        return InkWell(
                          onTap: () {
                            Get.to(() => VendorDetailScreen(vendor: vendor));
                          },
                          child: VendorCard(vendor: vendor),
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
          }
        },
      ),
    );
  }
}
