import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../data/network/sales/product_service/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Data product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  // Map backend stock_status to label and colors
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

  // Helper: Decide if image is URL or local file
  Widget _buildProductImage(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return Container(
        width: 60,
        height: 60,
        color: Colors.grey[300],
        child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
      );
    }

    if (imagePath.startsWith('http')) {
      return Image.network(imagePath, width: 60, height: 60, fit: BoxFit.cover);
    } else {
      return Image.file(
        File(imagePath),
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stockData = getStockStatusData(product.stockStatus);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Product Image or Placeholder
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(8),
            //   child:
            //       product.image != null && product.image!.isNotEmpty
            //           ? Image.network(
            //             product.image!,
            //             width: 60,
            //             height: 60,
            //             fit: BoxFit.cover,
            //           )
            //           : Container(
            //             width: 60,
            //             height: 60,
            //             color: Colors.grey[300],
            //             child: Icon(
            //               Icons.image_not_supported,
            //               color: Colors.grey[600],
            //             ),
            //           ),
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildProductImage(product.image),
            ),
            const SizedBox(width: 12),

            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name + Stock Status Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name ?? 'Unnamed Product',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: stockData["bgColor"],
                          borderRadius: BorderRadius.circular(8),
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
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Prices Row (Buy & Sell)
                  Row(
                    children: [
                      Text(
                        "Buy: ₹${product.buyingPrice ?? 'N/A'}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "Sell: ₹${product.sellingPrice ?? 'N/A'}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Stock Quantity
                  Text(
                    "Stock Qty: ${product.stockQuantity ?? '0'}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // // Optional Category
                  // if (product.category != null && product.category!.isNotEmpty)
                  //   Padding(
                  //     padding: const EdgeInsets.only(top: 6),
                  //     child: Text(
                  //       'Category: ${product.category}',
                  //       style: TextStyle(
                  //         fontSize: 13,
                  //         color: Colors.grey[700],
                  //         fontStyle: FontStyle.normal,
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
