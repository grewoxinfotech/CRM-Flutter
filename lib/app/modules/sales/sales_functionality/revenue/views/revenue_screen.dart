// import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controllers/revenue_controller.dart';
// import '../widget/reevenue_card.dart';
//
// class RevenueScreen extends StatelessWidget {
//   RevenueScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut<RevenueController>(() => RevenueController());
//     final RevenueController controller = Get.find();
//
//     return Scaffold(
//       appBar: AppBar(title: const Text("Revenue")),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     Get.to(() => AddRevenueScreen());
//       //   },
//       //   child: const Icon(Icons.add, color: Colors.white),
//       // ),
//       body: FutureBuilder(
//         future: controller.loadInitial(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CrmLoadingCircle());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: SizedBox(
//                 width: 250,
//                 child: Text(
//                   'Server Error:\n${snapshot.error}',
//                   style: const TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             );
//           } else if (snapshot.connectionState == ConnectionState.done) {
//             return Obx(() {
//               if (!controller.isLoading.value && controller.items.isEmpty) {
//                 return const Center(child: Text("No Revenue records found."));
//               }
//               return NotificationListener<ScrollEndNotification>(
//                 onNotification: (scrollEnd) {
//                   final metrics = scrollEnd.metrics;
//                   if (metrics.atEdge && metrics.pixels != 0) {
//                     controller.loadMore();
//                   }
//                   return false;
//                 },
//                 child: RefreshIndicator(
//                   onRefresh: controller.refreshList,
//                   child: ListView.builder(
//                     itemCount: controller.items.length + 1,
//                     itemBuilder: (context, index) {
//                       if (index < controller.items.length) {
//                         final revenue = controller.items[index];
//                         return GestureDetector(
//                           // onTap: () => Get.to(() => RevenueDetailScreen(revenue: revenue)),
//                           child: RevenueCard(revenue: revenue),
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
//                   ),
//                 ),
//               );
//             });
//           } else {
//             return const Center(child: Text("Something went wrong."));
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:crm_flutter/app/widgets/common/indicators/crm_loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/revenue_controller.dart';
import '../widget/reevenue_card.dart';

class RevenueScreen extends StatelessWidget {
  RevenueScreen({Key? key}) : super(key: key);

  String _formatWithCommas(num value) {
    final formatter = NumberFormat('#,##,###');
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<RevenueController>(() => RevenueController());
    final RevenueController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: const Text("Revenue")),
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
              if (!controller.isLoading.value && controller.items.isEmpty) {
                return const Center(child: Text("No Revenue records found."));
              }

              double totalRevenue = controller.items.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (double.tryParse(item.amount.toString() ?? '0') ?? 0.0),
              );

              double totalProfit = controller.items.fold(
                0.0,
                (sum, item) =>
                    sum +
                    (double.tryParse(item.profit.toString() ?? '0') ?? 0.0),
              );

              double profitMargin =
                  totalRevenue != 0 ? (totalProfit / totalRevenue) * 100 : 0;

              int productsSold = controller.items.fold(
                0,
                (sum, item) => sum + (item.products!.length ?? 0),
              );

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
                    itemCount:
                        controller.items.length + 2, // +2 for grid + spacing
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.5,
                            children: [
                              _buildStatCard(
                                "Total Revenue",
                                _formatWithCommas(totalRevenue),
                                Colors.blue,
                              ),
                              _buildStatCard(
                                "Total Profit",
                                _formatWithCommas(totalProfit),

                                Colors.green,
                              ),
                              _buildStatCard(
                                "Profit Margin",
                                "${profitMargin.toStringAsFixed(2)}%",
                                Colors.orange,
                              ),
                              _buildStatCard(
                                "Products Sold",
                                productsSold.toString(),
                                Colors.purple,
                              ),
                            ],
                          ),
                        );
                      } else if (index > 0 &&
                          index <= controller.items.length) {
                        final revenue = controller.items[index - 1];
                        return GestureDetector(
                          child: RevenueCard(revenue: revenue),
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

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
