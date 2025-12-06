import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:crm_flutter/app/care/constants/access_res.dart';
import 'package:crm_flutter/app/modules/access/controller/access_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/bindings/product_service_binding.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/controllers/product_service_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/views/add_product_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/widget/productcard.dart';
import 'package:crm_flutter/app/widgets/_screen/view_screen.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../care/constants/color_res.dart';
import '../../../../../care/constants/ic_res.dart';
import '../../../../../widgets/common/dialogs/crm_delete_dialog.dart';
import '../../../../../widgets/common/display/crm_ic.dart';
import '../../../../../widgets/common/messages/crm_snack_bar.dart';

class ProductsServicesScreen extends StatelessWidget {
  ProductsServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AccessController accessController = Get.find<AccessController>();
    Get.lazyPut<ProductsServicesController>(() => ProductsServicesController());
    final ProductsServicesController controller = Get.find();
    ProductServicesBinding().dependencies();

    void _deleteProduct(String id, String name) {
      Get.dialog(
        CrmDeleteDialog(
          entityType: name,
          onConfirm: () async {
            final success = await controller.deleteProduct(id);
            if (success) {
              Get.back();
              CrmSnackBar.showAwesomeSnackbar(
                title: "Success",
                message: "Product deleted successfully",
                contentType: ContentType.success,
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Products & Services")),
      floatingActionButton:
      accessController.can(
        AccessModule.productServices,
        AccessAction.create,
      )
          ? FloatingActionButton(
        onPressed: () {
          // Navigate to add product_service screen
          controller.resetForm();
          Get.to(
                () => AddProductScreen(),
            binding: ProductServicesBinding(),
          );
        },
        child: const Icon(Icons.add),
      )
          : null,
      body: FutureBuilder(
        future: controller.loadInitial(), // Load initial data
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
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Obx(() {
              if (!controller.isLoading.value && controller.items.isEmpty) {
                return const Center(child: Text("No products found."));
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
                    itemCount: controller.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.items.length) {
                        final product = controller.items[index];
                        return Stack(
                          children: [
                            ProductCard(product: product),

                            Positioned(
                              right: 26,
                              bottom: 8,
                              child: Row(
                                children: [
                                  // Uncomment when edit screen ready
                                  if (accessController.can(
                                    AccessModule.productServices,
                                    AccessAction.update,
                                  ))
                                    CrmIc(
                                        iconPath: ICRes.edit,
                                        color: ColorRes.success,
                                        onTap: () {
                                          Get.to(() {
                                            controller.resetForm();
                                            return AddProductScreen(
                                              isFromEdit: true,
                                              product: product,
                                            );
                                          }, binding: ProductServicesBinding());
                                        },
                                    ),

                                  const SizedBox(width: 16),
                                  if (accessController.can(
                                    AccessModule.productServices,
                                    AccessAction.delete,
                                  ))
                                    CrmIc(
                                      iconPath: ICRes.delete,
                                      color: ColorRes.error,
                                      onTap: () {
                                        _deleteProduct(
                                          product.id ?? '',
                                          product.name ?? 'Product',
                                        );
                                      },
                                    ),

                                ],
                              ),
                            ),
                          ],
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
