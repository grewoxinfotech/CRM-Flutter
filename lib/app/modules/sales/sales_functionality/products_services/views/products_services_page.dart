
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/bindings/product_service_binding.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/controllers/product_service_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/views/add_product_screen.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/widget/productcard.dart';
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductsServicesScreen extends StatelessWidget {
  ProductsServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ProductsServicesController>(() => ProductsServicesController());
    final ProductsServicesController controller = Get.find();
    ProductServicesBinding().dependencies();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products & Services"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add product_service screen
          Get.to(() => const AddProductScreen(), binding: ProductServicesBinding());
        },
        child: const Icon(Icons.add),
      ),
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
                  child: ListView.builder(
                    itemCount: controller.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.items.length) {
                        final product = controller.items[index];
                        return ProductCard(product: product);
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
