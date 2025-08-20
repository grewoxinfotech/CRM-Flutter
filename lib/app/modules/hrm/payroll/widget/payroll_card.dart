import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/network/hrm/payroll/salary/salary_model.dart';


class PayslipCard extends StatelessWidget {
  final PayslipData payslip;

  const PayslipCard({Key? key, required this.payslip}) : super(key: key);

  String formatCurrency(dynamic amount) {
    try {
      if (amount == null) return '';
      double value = (amount is String) ? double.tryParse(amount) ?? 0 : amount.toDouble();
      return NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(value);
    } catch (e) {
      return '';
    }
  }

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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
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
                        Text(
                          'Salary: ${formatCurrency(payslip.salary)}',
                          style:  TextStyle(
                            fontSize: 12,
                            color: payslip.status == "paid"
                                ? Colors.green[800]
                                : Colors.red[800],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Payment Date
                  if (payslip.paymentDate != null)
                    Text(
                      'Payment Date: ${formatDate(payslip.paymentDate)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),

                  // Net Salary
                  if (payslip.netSalary != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        'Net Salary: ${formatCurrency(payslip.netSalary)}',
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
      ),
    );
  }
}
