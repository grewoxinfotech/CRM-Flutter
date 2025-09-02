import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../care/constants/size_manager.dart';
import '../../../../../data/network/sales/revenue/model/revenue_menu.dart';
import '../controllers/revenue_controller.dart';

class RevenueCard extends StatefulWidget {
  final RevenueData revenue;

  const RevenueCard({Key? key, required this.revenue}) : super(key: key);

  @override
  State<RevenueCard> createState() => _RevenueCardState();
}

class _RevenueCardState extends State<RevenueCard> {
  final revenueController = Get.put(RevenueController());
  String? customerName;
  initState() {
    getName(widget.revenue.customer!);
    super.initState();
  }

  void getName(String id) async {
    final name = await revenueController.getCustomerById(id);
    setState(() {
      customerName = name;
    });
  }

  String formatRevenueId(String? id) {
    if (id != null && id.isNotEmpty) {
      return id.length <= 6 ? id : id.substring(id.length - 6);
    } else {
      return '';
    }
  }

  String formatCurrency(String? amount) {
    if (amount != null && amount.isNotEmpty) {
      final parsed = double.tryParse(amount);
      return parsed != null ? parsed.toStringAsFixed(2) : '';
    } else {
      return '';
    }
  }

  String formatDate(String? date) {
    if (date != null && date.isNotEmpty) {
      final parsedDate = DateTime.tryParse(date);
      return parsedDate != null
          ? DateFormat('dd-MM-yyyy').format(parsedDate)
          : '';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CrmCard(
        padding: const EdgeInsets.all(AppPadding.medium),
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.medium),
        borderRadius: BorderRadius.circular(AppRadius.large),
        child: Column(
          children: [
            Row(
              children: [
                // Icon Placeholder
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: Colors.green[100],
                    child: Icon(
                      Icons.attach_money,
                      color: Colors.green[700],
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Revenue Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Revenue ID
                      // Text(
                      //   "REV-${formatRevenueId(widget.revenue.id)}",
                      //   style: const TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      //   maxLines: 1,
                      //   overflow: TextOverflow.ellipsis,
                      // ),
                      // const SizedBox(height: 6),

                      // Customer Name
                      if (widget.revenue.description != null &&
                          widget.revenue.description!.isNotEmpty)
                        Text(
                          widget.revenue.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 4),
                      if (widget.revenue.customer != null &&
                          widget.revenue.customer!.isNotEmpty)
                        Text(
                          customerName.toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                      const SizedBox(height: 4),

                      // Date
                      if (widget.revenue.date != null &&
                          widget.revenue.date!.isNotEmpty)
                        Text(
                          'Date: ${formatDate(widget.revenue.date)}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),

                      // Amount
                      if (widget.revenue.amount != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            'Amount: ${formatCurrency(widget.revenue.amount.toString())}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
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
