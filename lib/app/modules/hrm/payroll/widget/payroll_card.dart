import 'package:crm_flutter/app/data/network/system/currency/controller/currency_controller.dart';
import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../care/constants/size_manager.dart';
import '../../../../data/network/hrm/payroll/salary/salary_model.dart';


class PayslipCard extends StatelessWidget {
  final PayslipData payslip;

  const PayslipCard({Key? key, required this.payslip}) : super(key: key);

  // String formatCurrency(dynamic amount) {
  //   try {
  //     if (amount == null) return '';
  //     double value = (amount is String) ? double.tryParse(amount) ?? 0 : amount.toDouble();
  //     return NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(value);
  //   } catch (e) {
  //     return '';
  //   }
  // }

  String formatDate(String? date) {
    if (date != null && date.isNotEmpty) {
      try {
        return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
      } catch (e) {
        return '';
      }
    }
    return '';
  }
  
  String formatId(String id){
    return id.substring(id.length-6,id.length);
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CurrencyController());
    final currencyController = Get.find<CurrencyController>();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await currencyController.getCurrency();
    });
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
                      Icons.payment,
                      color: Colors.green[700],
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Payslip Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Employee ID



                      // Payslip Type & Status
                      Row(
                        mainAxisAlignment : MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Emp-${formatId(payslip.employeeId!) ?? ''}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (payslip.status != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: payslip.status == "paid"
                                    ? Colors.green[100]
                                    : Colors.red[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                payslip.status!.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: payslip.status == "paid"
                                      ? Colors.green[800]
                                      : Colors.red[800],
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (payslip.payslipType != null)
                            Text(
                              payslip.payslipType!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey,
                              ),
                            ),
                          const SizedBox(width: 10),
                          if(payslip.salary != null)
                            Obx(
                              () {
                                final currency = currencyController.currencyModel.firstWhereOrNull((element) => element.id == payslip.currency);
                                if (currency == null) {
                                  return SizedBox.shrink();
                                }
                                return Text(
                                'Salary: ${currency.currencyIcon} ${double.parse(payslip.salary!).toStringAsFixed(2)}',
                                style:  TextStyle(
                                  fontSize: 12,
                                  color: payslip.status == "paid"
                                      ? Colors.green[800]
                                      : Colors.red[800],
                                ),
                              );
                              },
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      // Payment Date
                      if (payslip.paymentDate != null)
                        Text(
                          'Payment Date: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(payslip.paymentDate!))}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),

                      // Net Salary
                      if (payslip.netSalary != null)
                        Obx(
                          () {
                            final currency = currencyController.currencyModel.firstWhereOrNull((element) => element.id == payslip.currency);
                            if (currency == null) {
                              return SizedBox.shrink();
                            }
                            return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              'Net Salary: ${currency.currencyIcon} ${double.parse(payslip.salary!).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.green[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                          },
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
