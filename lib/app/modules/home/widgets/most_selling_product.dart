import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/widget/productcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/common/indicators/crm_loading_circle.dart';
import '../../sales/sales_functionality/products_services/bindings/product_service_binding.dart';
import '../../sales/sales_functionality/products_services/controllers/product_service_controller.dart';

class MostSellingProductScreen extends StatelessWidget {
  MostSellingProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<ProductsServicesController>(() => ProductsServicesController());
    final ProductsServicesController controller = Get.find();
    ProductServicesBinding().dependencies();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
          child: Text(
            "Most Sold",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.small),
        FutureBuilder(
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
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Obx(() {
                if (!controller.isLoading.value && controller.items.isEmpty) {
                  return const Center(child: Text("No products found."));
                }
                

                return SizedBox(
                  height: 250, // Adjust based on 2 rows
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 rows
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.4,
                        ),
                    itemBuilder: (context, index) {
                      if (index < controller.items.length) {
                        final product = controller.items[index];
                        return ProductCard(
                          product: product,
                          isNotPadding: true,
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
                    padding: const EdgeInsets.all(10),
                  ),
                );
              });
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
