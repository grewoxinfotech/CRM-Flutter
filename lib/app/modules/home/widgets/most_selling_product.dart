import 'dart:io';
import 'package:crm_flutter/app/care/constants/size_manager.dart';
import 'package:crm_flutter/app/data/network/crm/crm_system/label/controller/label_controller.dart';
import 'package:crm_flutter/app/modules/sales/sales_functionality/products_services/widget/productcard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/network/sales/product_service/model/product_model.dart';
import '../../../widgets/common/display/crm_card.dart';
import '../../../widgets/common/indicators/crm_loading_circle.dart';
import '../../sales/sales_functionality/products_services/bindings/product_service_binding.dart';
import '../../sales/sales_functionality/products_services/controllers/product_service_controller.dart';
import '../../sales/sales_functionality/revenue/controllers/revenue_controller.dart';
import '../../sales/sales_functionality/revenue/views/revenue_screen.dart';

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

                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: sortedProducts.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final product = sortedProducts[index];
                    final sold = salesMap[product!.id.toString()] ?? 0;
                    return ProductCard(product: product, isNotPadding: true);
                  },
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

class VerticalProductCard extends StatefulWidget {
  final Data product;
  final int sold;
  final bool isNotPadding;

  VerticalProductCard({
    Key? key,
    required this.product,
    this.isNotPadding = false,
    required this.sold,
  }) : super(key: key);

  @override
  State<VerticalProductCard> createState() => _VerticalProductCardState();
}

class _VerticalProductCardState extends State<VerticalProductCard> {
  final LabelController labelController = Get.put(LabelController());

  RxMap<String, String> categoryOptions = <String, String>{}.obs;

  Map<String, dynamic> getStockStatusData(String? status) {
    switch (status) {
      case "in_stock":
        return {
          "label": "In Stock",
          "textColor": Colors.white,
          "bgColor": Colors.green,
        };
      case "low_stock":
        return {
          "label": "Low Stock",
          "textColor": Colors.black,
          "bgColor": Colors.orange[200],
        };
      case "out_of_stock":
        return {
          "label": "Out of Stock",
          "textColor": Colors.white,
          "bgColor": Colors.red,
        };
      default:
        return {
          "label": "Unknown",
          "textColor": Colors.grey[700],
          "bgColor": Colors.grey[300],
        };
    }
  }

  Widget _buildProductImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return Container(
        width: double.infinity,
        height: 250,
        color: Colors.grey[300],
        child: Icon(
          Icons.image_not_supported,
          color: Colors.grey[600],
          size: 40,
        ),
      );
    }

    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imagePath),
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCategories();
    });
  }

  Future<void> _loadCategories() async {
    final categories = await labelController.getCategories();
    if (!mounted) return;

    final Map<String, String> newMap = {
      for (var c in categories) c.id.toString(): c.name.toString(),
    };

    categoryOptions.assignAll(newMap);
  }

  @override
  Widget build(BuildContext context) {
    final stockData = getStockStatusData(widget.product.stockStatus);

    return GestureDetector(
      onTap: () => Get.to(() => RevenueScreen(id: widget.product.id)),
      child: CrmCard(
        padding: EdgeInsets.all(AppPadding.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _buildProductImage(widget.product.image),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: stockData["bgColor"],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 4),
                      ],
                    ),
                    child: Text(
                      stockData["label"],
                      style: TextStyle(
                        color: stockData["textColor"],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 4),
                      ],
                    ),
                    child: Text(
                      'Sold: ${widget.sold}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.small),
            Text(
              widget.product.name ?? 'Unnamed Product',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppSpacing.xSmall),
            if (widget.product.description != null &&
                widget.product.description!.isNotEmpty) ...[
              Text(
                widget.product.description ?? 'No description available.',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppSpacing.xSmall),
            ],
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Stock: ${widget.product.stockQuantity ?? '0'}",
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.xSmall),

                Expanded(
                  child: Text(
                    "SKU: ${widget.product.sku ?? 'N/A'}",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSpacing.xSmall),
            Obx(() {
              final categoryId = widget.product.category;
              final categoryName = categoryOptions[categoryId] ?? 'N/A';

              return Text(
                "Category: $categoryName",
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                overflow: TextOverflow.ellipsis,
              );
            }),

            // Prices Row (Buy & Sell)
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Buy: ${PriceFormatter.format(widget.product.buyingPrice) ?? 'N/A'}",
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: AppSpacing.xSmall),
                Expanded(
                  child: Text(
                    "Sell: ${PriceFormatter.format(widget.product.sellingPrice) ?? 'N/A'}",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PriceFormatter {
  /// Formats large numbers into short human-readable format (K, M, B)
  static String format(num? price) {
    if (price == null) return 'N/A';
    if (price < 1000) return '₹$price';

    if (price < 1000000) {
      return '₹${(price / 1000).toStringAsFixed(1)}K';
    } else if (price < 1000000000) {
      return '₹${(price / 1000000).toStringAsFixed(1)}M';
    } else {
      return '₹${(price / 1000000000).toStringAsFixed(1)}B';
    }
  }
}
