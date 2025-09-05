import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/widget/productcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/network/sales/product_service/model/product_model.dart';
import '../../../widgets/common/indicators/crm_loading_circle.dart';
import '../../sales/sales_functionality/products_services/bindings/product_service_binding.dart';
import '../../sales/sales_functionality/products_services/controllers/product_service_controller.dart';
import '../../sales/sales_functionality/revenue/controllers/revenue_controller.dart';
//
// class MostSellingProductScreen extends StatelessWidget {
//   MostSellingProductScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut<ProductsServicesController>(() => ProductsServicesController());
//     final ProductsServicesController controller = Get.find();
//     ProductServicesBinding().dependencies();
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
//           child: Text(
//             "Most Sold",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         SizedBox(height: AppSpacing.small),
//         FutureBuilder(
//           future: controller.loadInitial(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CrmLoadingCircle());
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: SizedBox(
//                   width: 250,
//                   child: Text(
//                     'Server Error:\n${snapshot.error}',
//                     style: const TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               );
//             } else if (snapshot.connectionState == ConnectionState.done) {
//               return Obx(() {
//                 if (!controller.isLoading.value && controller.items.isEmpty) {
//                   return const Center(child: Text("No products found."));
//                 }
//
//
//                 return SizedBox(
//                   height: 250, // Adjust based on 2 rows
//                   child: GridView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 10,
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2, // 2 rows
//                           mainAxisSpacing: 10,
//                           crossAxisSpacing: 10,
//                           childAspectRatio: 0.4,
//                         ),
//                     itemBuilder: (context, index) {
//                       if (index < controller.items.length) {
//                         final product = controller.items[index];
//                         return ProductCard(
//                           product: product,
//                           isNotPadding: true,
//                         );
//                       } else if (controller.isPaging.value) {
//                         return const Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Center(child: CircularProgressIndicator()),
//                         );
//                       } else {
//                         return const SizedBox.shrink();
//                       }
//                     },
//                     padding: const EdgeInsets.all(10),
//                   ),
//                 );
//               });
//             } else {
//               return const SizedBox.shrink();
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/sales/product_service/model/product_model.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/widget/productcard.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/revenue/controllers/revenue_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/common/indicators/crm_loading_circle.dart';
import '../../sales/sales_functionality/products_services/bindings/product_service_binding.dart';
import '../../sales/sales_functionality/products_services/controllers/product_service_controller.dart';

class MostSellingProductScreen extends StatelessWidget {
  MostSellingProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    Get.lazyPut<ProductsServicesController>(() => ProductsServicesController());
    final ProductsServicesController controller = Get.find();
    Get.lazyPut<RevenueController>(() => RevenueController());
    final RevenueController revenueController = Get.find();
    ProductServicesBinding().dependencies();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: AppMargin.medium),
          child: const Text(
            "Most Sold",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.small),
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

                // 1️⃣ Aggregate sales from revenue data
                final Map<String, int> salesMap = {};
                for (var revenue in revenueController.items) {
                  for (var p in revenue.products ?? []) {
                    final productId = p.productId.toString(); // ID from revenue
                    final int qty = (p.quantity ?? 0).toInt();
                    salesMap[productId] = (salesMap[productId] ?? 0) + qty;
                  }
                }

                // 2️⃣ Sort product IDs by quantity sold (descending)
                final sortedProductIds =
                    salesMap.entries.toList()
                      ..sort((a, b) => b.value.compareTo(a.value));

                // 3️⃣ Map sorted IDs to Product objects
                final List<Data?> sortedProducts =
                    sortedProductIds
                        .map((entry) {
                          return controller.items.firstWhereOrNull(
                            (p) =>
                                p.id.toString() ==
                                entry.key, // use correct field
                          );
                        })
                        .whereType<Data>()
                        .toList(); // filter out nulls

                // 4️⃣ Debug print
                for (var product in sortedProducts) {
                  final sold = salesMap[product!.id.toString()] ?? 0;
                  print("Product: ${product.name}, Sold: $sold");
                }

                // 5️⃣ Build horizontal grid
                return SizedBox(
                  height: 250,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: sortedProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.4,
                        ),
                    itemBuilder: (context, index) {
                      final product = sortedProducts[index];
                      return ProductCard(product: product!, isNotPadding: true);
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
