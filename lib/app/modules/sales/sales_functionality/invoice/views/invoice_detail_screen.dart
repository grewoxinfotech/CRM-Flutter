// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../../data/network/sales_invoice/model/sales_invoice_model.dart';
//
// class InvoiceDetailPage extends StatelessWidget {
//   final SalesInvoice invoice;
//
//   const InvoiceDetailPage({super.key, required this.invoice});
//
//   String _formatDate(DateTime? date) {
//     if (date == null) return '-';
//     return DateFormat('dd MMM yyyy').format(date);
//   }
//
//   String _formatCurrency(double? amount) {
//     if (amount == null) return '-';
//     return "${invoice.currencyIcon ?? ''} ${amount.toStringAsFixed(2)}";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Invoice #${invoice.salesInvoiceNumber ?? ''}"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildSection(
//               title: "Basic Info",
//               children: [
//                 _buildRow("Customer", invoice.customer),
//                 _buildRow("Related Type", invoice.relatedType),
//                 _buildRow("Related ID", invoice.relatedId),
//                 _buildRow("GSTIN", invoice.gstin),
//                 _buildRow("Section", invoice.section),
//                 _buildRow("Category", invoice.category),
//                 _buildRow("Payment Status", invoice.paymentStatus),
//               ],
//             ),
//             _buildSection(
//               title: "Dates",
//               children: [
//                 _buildRow("Issue Date", _formatDate(invoice.issueDate)),
//                 _buildRow("Due Date", _formatDate(invoice.dueDate)),
//                 _buildRow("Created At", _formatDate(invoice.createdAt)),
//                 _buildRow("Updated At", _formatDate(invoice.updatedAt)),
//               ],
//             ),
//             _buildSection(
//               title: "Items",
//               children:
//                   invoice.items.isEmpty
//                       ? [_buildRow("No items", "—")]
//                       : invoice.items
//                           .map(
//                             (item) => ListTile(
//                               title: Text(item.name!),
//                               subtitle: Text(
//                                 "Qty: ${item.quantity} • Price: ${_formatCurrency(item.unitPrice)}",
//                               ),
//                               trailing: Text(_formatCurrency(item.total)),
//                             ),
//                           )
//                           .toList(),
//             ),
//             _buildSection(
//               title: "Financials",
//               children: [
//                 _buildRow("Subtotal", _formatCurrency(invoice.subtotal)),
//                 _buildRow("Discount", _formatCurrency(invoice.discount)),
//                 _buildRow("Tax", _formatCurrency(invoice.tax)),
//                 _buildRow("Total", _formatCurrency(invoice.total)),
//                 _buildRow(
//                   "Pending Amount",
//                   _formatCurrency(invoice.pendingAmount),
//                 ),
//                 _buildRow("Amount Paid", _formatCurrency(invoice.amount)),
//                 _buildRow(
//                   "Cost of Goods",
//                   _formatCurrency(invoice.costOfGoods),
//                 ),
//                 _buildRow("Profit", _formatCurrency(invoice.profit)),
//                 _buildRow(
//                   "Profit %",
//                   invoice.profitPercentage?.toStringAsFixed(2),
//                 ),
//               ],
//             ),
//             _buildSection(
//               title: "Additional Notes",
//               children: [
//                 Text(
//                   invoice.additionalNotes ?? "No notes available",
//                   style: const TextStyle(fontSize: 14),
//                 ),
//               ],
//             ),
//             if (invoice.upiLink != null && invoice.upiLink!.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(top: 12),
//                 child: ElevatedButton.icon(
//                   icon: const Icon(Icons.qr_code),
//                   label: const Text("Pay via UPI"),
//                   onPressed: () {
//                     // Launch UPI link
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSection({
//     required String title,
//     required List<Widget> children,
//   }) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             ...children,
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRow(String label, String? value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               label,
//               style: const TextStyle(fontWeight: FontWeight.w500),
//             ),
//           ),
//           Text(value ?? '-', style: const TextStyle(color: Colors.grey)),
//         ],
//       ),
//     );
//   }
// }

// --------------------------------------------------------------------------------

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../../../data/network/sales_invoice/model/sales_invoice_model.dart';
//
// class InvoiceDetailPage extends StatelessWidget {
//   final SalesInvoice invoice;
//   const InvoiceDetailPage({super.key, required this.invoice});
//
//   String _formatDate(DateTime? date) {
//     if (date == null) return '-';
//     return DateFormat('dd/MM/yyyy').format(date);
//   }
//
//   String _formatCurrency(double? amount) {
//     if (amount == null) return '-';
//     return "${invoice.currencyIcon ?? ''}${amount.toStringAsFixed(2)}";
//   }
//
//   TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
//     return TableRow(
//       decoration: BoxDecoration(
//         color: isHeader ? Colors.grey.shade200 : Colors.white,
//       ),
//       children:
//           cells
//               .map(
//                 (cell) => Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     cell,
//                     style: TextStyle(
//                       fontWeight:
//                           isHeader ? FontWeight.bold : FontWeight.normal,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//               )
//               .toList(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Invoice Detail")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Header
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Logo
//                 Container(
//                   height: 60,
//                   width: 60,
//                   color: Colors.grey.shade200,
//                   child: const Icon(Icons.apartment, size: 40),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         "GREWOX",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text("N/A", style: TextStyle(fontSize: 12)),
//                       Text("g@yopmail.com", style: TextStyle(fontSize: 12)),
//                       Text("N/A", style: TextStyle(fontSize: 12)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             // Tax Invoice title
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "TAX INVOICE",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "GSTIN: ${invoice.gstin ?? ''}",
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//
//             // Invoice meta table
//             Table(
//               border: TableBorder.all(color: Colors.grey.shade300),
//               columnWidths: const {
//                 0: FlexColumnWidth(1.5),
//                 1: FlexColumnWidth(2),
//                 2: FlexColumnWidth(1.5),
//                 3: FlexColumnWidth(2),
//               },
//               children: [
//                 _buildTableRow([
//                   "Invoice No",
//                   invoice.salesInvoiceNumber ?? '',
//                   "Issue Date",
//                   _formatDate(invoice.issueDate),
//                 ]),
//                 _buildTableRow([
//                   "Due Date",
//                   _formatDate(invoice.dueDate),
//                   "Customer No",
//                   invoice.clientId ?? '',
//                 ]),
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             // Customer details
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Customer Details",
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 6),
//             Table(
//               border: TableBorder.all(color: Colors.grey.shade300),
//               columnWidths: const {
//                 0: FlexColumnWidth(1.2),
//                 1: FlexColumnWidth(3),
//               },
//               children: [
//                 _buildTableRow(["Name", invoice.customer ?? '']),
//                 _buildTableRow(["Contact", "N/A"]),
//                 _buildTableRow(["GSTIN", invoice.gstin ?? '']),
//                 _buildTableRow(["Address", "N/A"]),
//               ],
//             ),
//             const SizedBox(height: 16),
//
//             // Items Table
//             Table(
//               border: TableBorder.all(color: Colors.grey.shade300),
//               columnWidths: const {
//                 0: FlexColumnWidth(1.5),
//                 1: FlexColumnWidth(1.2),
//                 2: FlexColumnWidth(0.8),
//                 3: FlexColumnWidth(1.2),
//                 4: FlexColumnWidth(0.8),
//                 5: FlexColumnWidth(1.2),
//                 6: FlexColumnWidth(1),
//                 7: FlexColumnWidth(1.2),
//               },
//               children: [
//                 _buildTableRow([
//                   "Item",
//                   "HSN/SAC",
//                   "Qty",
//                   "Rate",
//                   "Tax %",
//                   "Tax Amt",
//                   "Disc",
//                   "Amount",
//                 ], isHeader: true),
//                 ...invoice.items.map((item) {
//                   return _buildTableRow([
//                     item.name ?? '',
//                     item.hsnSac ?? '-',
//                     item.quantity.toString(),
//                     _formatCurrency(item.unitPrice),
//                     "${item.tax ?? '0'}%",
//                     _formatCurrency(item.taxAmount),
//                     "${item.discount}₹",
//                     _formatCurrency(item.total),
//                   ]);
//                 }),
//               ],
//             ),
//             const SizedBox(height: 8),
//
//             // Totals
//             // Align(
//             //   alignment: Alignment.centerRight,
//             //   child: Column(
//             //     crossAxisAlignment: CrossAxisAlignment.end,
//             //     children: [
//             //       _totalRow("Discount", _formatCurrency(invoice.discount)),
//             //       _totalRow("Total Amount", _formatCurrency(invoice.total)),
//             //       _totalRow("Credit Note", "-0.00"),
//             //       _totalRow("Final Amount", _formatCurrency(invoice.total)),
//             //     ],
//             //   ),
//             // ),
//             const SizedBox(height: 20),
//
//             // QR + Bank details
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.shade300),
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 150,
//                             width: 150,
//                             color: Colors.grey.shade200,
//                             child: const Icon(Icons.qr_code, size: 80),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "Scan to Pay",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           Text(_formatCurrency(invoice.total)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       _totalRow("Discount", _formatCurrency(invoice.discount)),
//                       _totalRow("Total Amount", _formatCurrency(invoice.total)),
//                       _totalRow("Credit Note", "-0.00"),
//                       _totalRow("Final Amount", _formatCurrency(invoice.total)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       const Expanded(
//                         child: Text(
//                           "Bank Details",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: const Text(
//                           "PAID",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   _bankRow("Bank", "N/A"),
//                   _bankRow("Account Type", "N/A"),
//                   _bankRow("Account No", "N/A"),
//                   _bankRow("IFSC", "N/A"),
//                   _bankRow("Branch", "N/A"),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _totalRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//           const SizedBox(width: 8),
//           Text(value),
//         ],
//       ),
//     );
//   }
//
//   Widget _bankRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(children: [Expanded(child: Text(label)), Text(value)]),
//     );
//   }
// }

// --------------------------------------------------------------

// import 'package:crm_flutter/app/widgets/common/display/crm_card.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../../../data/network/sales_invoice/model/sales_invoice_model.dart';
//
// class InvoiceDetailPage extends StatelessWidget {
//   final SalesInvoice invoice;
//   const InvoiceDetailPage({super.key, required this.invoice});
//
//   String _formatDate(DateTime? date) {
//     if (date == null) return '-';
//     return DateFormat('dd/MM/yyyy').format(date);
//   }
//
//   String _formatCurrency(double? amount) {
//     if (amount == null) return '-';
//     return "${invoice.currencyIcon ?? ''}${amount.toStringAsFixed(2)}";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Invoice Detail")),
//       backgroundColor: Colors.grey[100],
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: CrmCard(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 _buildHeader(),
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   color: Colors.white,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildTitleRow(),
//                       const SizedBox(height: 16),
//                       _buildInvoiceMetaTable(),
//                       const SizedBox(height: 16),
//                       _buildCustomerDetails(),
//                       const SizedBox(height: 16),
//                       _buildItemsTable(),
//                       const SizedBox(height: 16),
//                       _buildTotalsSection(),
//                       const SizedBox(height: 16),
//                       _buildBottomSection(context),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// HEADER
//   Widget _buildHeader() {
//     return Container(
//       color: const Color(0xFFE9F0F8),
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           const Icon(Icons.apartment, size: 40, color: Colors.black54),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: const [
//                 Text(
//                   "GREWOX",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: const [Text("N/A"), Text("g@yopmail.com"), Text("N/A")],
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// TITLE & GST
//   Widget _buildTitleRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           "TAX INVOICE",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           "GSTIN: ${invoice.gstin ?? '-'}",
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//       ],
//     );
//   }
//
//   /// INVOICE META TABLE
//   Widget _buildInvoiceMetaTable() {
//     return Table(
//       border: TableBorder.all(color: Colors.grey.shade300),
//       columnWidths: const {
//         0: FlexColumnWidth(2),
//         1: FlexColumnWidth(2),
//         2: FlexColumnWidth(2),
//         3: FlexColumnWidth(2),
//       },
//       children: [
//         _metaRow(
//           "Invoice No",
//           invoice.salesInvoiceNumber,
//           "Issue Date",
//           _formatDate(invoice.issueDate),
//         ),
//         _metaRow(
//           "Due Date",
//           _formatDate(invoice.dueDate),
//           "Customer No",
//           invoice.clientId,
//         ),
//       ],
//     );
//   }
//
//   TableRow _metaRow(String k1, String? v1, String k2, String? v2) {
//     return TableRow(
//       children: [
//         _cell(k1, isHeader: true),
//         _cell(v1),
//         _cell(k2, isHeader: true),
//         _cell(v2),
//       ],
//     );
//   }
//
//   /// CUSTOMER DETAILS
//   Widget _buildCustomerDetails() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           color: Colors.grey.shade200,
//           padding: const EdgeInsets.all(8),
//           child: const Text(
//             "Customer Details",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//         ),
//         Table(
//           border: TableBorder.all(color: Colors.grey.shade300),
//           columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
//           children: [
//             _metaRow("Name", invoice.customer, "Address", "[object Object]"),
//             _metaRow("Contact", "-", "GSTIN", invoice.gstin),
//           ],
//         ),
//       ],
//     );
//   }
//
//   /// ITEMS TABLE
//   Widget _buildItemsTable() {
//     return Table(
//       border: TableBorder.all(color: Colors.grey.shade300),
//       columnWidths: const {
//         0: FlexColumnWidth(2),
//         1: FlexColumnWidth(1.5),
//         2: FlexColumnWidth(1),
//         3: FlexColumnWidth(1.5),
//         4: FlexColumnWidth(1),
//         5: FlexColumnWidth(1.5),
//         6: FlexColumnWidth(1),
//         7: FlexColumnWidth(1.5),
//       },
//       children: [
//         TableRow(
//           decoration: BoxDecoration(color: Colors.grey.shade200),
//           children: [
//             _headerCell("Item"),
//             _headerCell("HSN/SAC"),
//             _headerCell("Qty"),
//             _headerCell("Rate"),
//             _headerCell("Tax %"),
//             _headerCell("Tax Amount"),
//             _headerCell("Discount"),
//             _headerCell("Amount"),
//           ],
//         ),
//         ...invoice.items.map(
//           (item) => TableRow(
//             children: [
//               _cell(item.name ?? '-'),
//               _cell(item.hsnSac ?? '-'),
//               _cell("${item.quantity}"),
//               _cell(_formatCurrency(item.unitPrice)),
//               _cell("${item.tax ?? 0}%"),
//               _cell(_formatCurrency(item.taxAmount)),
//               _cell("${item.discount}%"),
//               _cell(_formatCurrency(item.total)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   /// TOTALS
//   Widget _buildTotalsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         _totalRow("Discount", _formatCurrency(invoice.discount)),
//         _totalRow("Total Amount", _formatCurrency(invoice.total)),
//         _totalRow("Credit Note", _formatCurrency(0)),
//         _totalRow("Final Amount", _formatCurrency(invoice.total)),
//       ],
//     );
//   }
//
//   Widget _totalRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
//           const SizedBox(width: 12),
//           Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
//
//   /// QR + BANK DETAILS
//   Widget _buildBottomSection(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             children: [
//               Container(
//                 height: 120,
//                 width: 120,
//                 color: Colors.grey.shade300,
//                 child: const Icon(Icons.qr_code, size: 80),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 "Scan to Pay\n${_formatCurrency(invoice.total)}",
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 color: Colors.grey.shade200,
//                 padding: const EdgeInsets.all(8),
//                 child: const Text(
//                   "Bank Details",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 4),
//               _bankRow("Bank", "N/A"),
//               _bankRow("Account Type", "N/A"),
//               _bankRow("Account No", "N/A"),
//               _bankRow("IFSC", "N/A"),
//               _bankRow("Branch", "N/A"),
//             ],
//           ),
//         ),
//         const SizedBox(width: 16),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: Colors.green,
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: const Text(
//             "PAID",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _bankRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         children: [
//           Expanded(child: Text(label)),
//           Text(value, style: const TextStyle(color: Colors.grey)),
//         ],
//       ),
//     );
//   }
//
//   /// CELL HELPERS
//   static Widget _cell(String? text, {bool isHeader = false}) {
//     return Padding(
//       padding: const EdgeInsets.all(6),
//       child: Text(
//         text ?? '-',
//         style: TextStyle(
//           fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
//         ),
//       ),
//     );
//   }
//
//   static Widget _headerCell(String text) {
//     return Padding(
//       padding: const EdgeInsets.all(6),
//       child: Text(
//         text,
//         style: const TextStyle(fontWeight: FontWeight.bold),
//         textAlign: TextAlign.left,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../../data/network/sales_invoice/model/sales_invoice_model.dart'; // Your model file
//
// class InvoiceDetailScreen extends StatelessWidget {
//   final SalesInvoice invoice;
//
//   const InvoiceDetailScreen({super.key, required this.invoice});
//
//   String _formatDate(DateTime? date) {
//     if (date == null) return "-";
//     return DateFormat('dd MMM yyyy').format(date);
//   }
//
//   String _formatAmount(double? value) {
//     if (value == null) return "-";
//     return "${invoice.currencyIcon ?? ''}${value.toStringAsFixed(2)}";
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//           color: Colors.blueGrey,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
//           Flexible(
//             child: Text(
//               value,
//               textAlign: TextAlign.right,
//               style: const TextStyle(color: Colors.black87),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Invoice #${invoice.salesInvoiceNumber ?? '-'}"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // SECTION: Invoice Information
//             _buildSectionTitle("Invoice Information"),
//             _buildRow("Invoice ID", invoice.id ?? "-"),
//             _buildRow("Related Type", invoice.relatedType ?? "-"),
//             _buildRow("Section", invoice.section ?? "-"),
//             _buildRow("Category", invoice.category ?? "-"),
//             _buildRow("Payment Status", invoice.paymentStatus ?? "-"),
//
//             const Divider(height: 24),
//
//             // SECTION: Customer Information
//             _buildSectionTitle("Customer Information"),
//             _buildRow("Customer", invoice.customer ?? "-"),
//             _buildRow("GSTIN", invoice.gstin ?? "-"),
//             _buildRow("Client ID", invoice.clientId ?? "-"),
//
//             const Divider(height: 24),
//
//             // SECTION: Dates
//             _buildSectionTitle("Dates"),
//             _buildRow("Issue Date", _formatDate(invoice.issueDate)),
//             _buildRow("Due Date", _formatDate(invoice.dueDate)),
//             _buildRow("Created At", _formatDate(invoice.createdAt)),
//             _buildRow("Updated At", _formatDate(invoice.updatedAt)),
//
//             const Divider(height: 24),
//
//             // SECTION: Amounts
//             _buildSectionTitle("Amounts"),
//             _buildRow("Subtotal", _formatAmount(invoice.subtotal)),
//             _buildRow("Discount", _formatAmount(invoice.discount)),
//             _buildRow("Tax", _formatAmount(invoice.tax)),
//             _buildRow("Total", _formatAmount(invoice.total)),
//             _buildRow("Pending Amount", _formatAmount(invoice.pendingAmount)),
//             _buildRow("Amount Paid", _formatAmount(invoice.amount)),
//             _buildRow("Cost of Goods", _formatAmount(invoice.costOfGoods)),
//             _buildRow("Profit", _formatAmount(invoice.profit)),
//             _buildRow(
//               "Profit %",
//               "${invoice.profitPercentage?.toStringAsFixed(2) ?? '-'}%",
//             ),
//
//             const Divider(height: 24),
//
//             // SECTION: Items List
//             _buildSectionTitle("Invoice Items"),
//             Table(
//               border: TableBorder.all(color: Colors.grey.shade300),
//               columnWidths: const {
//                 0: FlexColumnWidth(3),
//                 1: FlexColumnWidth(1),
//                 2: FlexColumnWidth(2),
//               },
//               children: [
//                 const TableRow(
//                   decoration: BoxDecoration(color: Colors.grey),
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         "Item",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         "Qty",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                         "Total",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//                 ...invoice.items.map((item) {
//                   return TableRow(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(item.name!),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(item.quantity.toString()),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(_formatAmount(item.total)),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               ],
//             ),
//
//             const Divider(height: 24),
//
//             // SECTION: Additional Notes
//             _buildSectionTitle("Additional Notes"),
//             Text(invoice.additionalNotes ?? "-"),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:crm_flutter/app/data/network/sales/customer/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../data/network/sales_invoice/model/sales_invoice_model.dart';
import '../../../../../widgets/date_time/format_date.dart';
import '../../customer/controllers/customer_controller.dart'; // Your model file

class InvoiceDetailScreen extends StatelessWidget {
  final SalesInvoice invoice;
  final CustomerData? customer;

  const InvoiceDetailScreen({super.key, required this.invoice, this.customer});

  String _formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('dd MMM yyyy').format(date);
  }

  String _formatAmount(double? value) {
    if (value == null) return "-";
    return "${invoice.currencyIcon ?? ''}${value.toStringAsFixed(2)}";
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey,
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Invoice #${invoice.salesInvoiceNumber ?? '-'}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // _generatePdf(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SECTION: Invoice Information
            _buildSectionTitle("Invoice Information"),
            _buildRow("Invoice ID", invoice.salesInvoiceNumber ?? "-"),
            _buildRow("Issue Date", formatDate(invoice.issueDate.toString())),
            _buildRow("Due Date", formatDate(invoice.dueDate.toString())),
            _buildRow("Customer Name", customer?.customerNumber ?? "-"),

            const Divider(height: 24),

            // SECTION: Customer Information
            _buildSectionTitle("Customer Information"),
            _buildRow("Customer Name", customer?.name ?? "-"),
            _buildRow("GSTIN", customer?.taxNumber ?? "-"),
            _buildRow("Contact", customer?.contact ?? "-"),
            _buildRow(
              "Address",
              Address.formatAddress(customer?.billingAddress) ?? "-",
            ),

            const Divider(height: 24),

            // // SECTION: Dates
            // _buildSectionTitle("Dates"),
            // _buildRow("Issue Date", _formatDate(invoice.issueDate)),
            // _buildRow("Due Date", _formatDate(invoice.dueDate)),
            // _buildRow("Created At", _formatDate(invoice.createdAt)),
            // _buildRow("Updated At", _formatDate(invoice.updatedAt)),
            //
            // const Divider(height: 24),

            // SECTION: Amounts
            _buildSectionTitle("Amounts"),
            _buildRow("Subtotal", _formatAmount(invoice.subtotal)),
            _buildRow("Discount", _formatAmount(invoice.discount)),
            _buildRow("Tax", _formatAmount(invoice.tax)),
            _buildRow("Total", _formatAmount(invoice.total)),
            _buildRow("Pending Amount", _formatAmount(invoice.pendingAmount)),
            _buildRow("Amount Paid", _formatAmount(invoice.amount)),
            // _buildRow("Cost of Goods", _formatAmount(invoice.costOfGoods)),

            // _buildRow("Profit", _formatAmount(invoice.profit)),
            // _buildRow(
            //   "Profit %",
            //   "${invoice.profitPercentage?.toStringAsFixed(2) ?? '-'}%",
            // ),
            const Divider(height: 24),

            // SECTION: Items List
            _buildSectionTitle("Invoice Items"),
            Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(2),
              },
              children: [
                const TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Item",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Qty",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Total",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                ...invoice.items.map((item) {
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item.name!),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item.quantity.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_formatAmount(item.total)),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),

            const Divider(height: 24),

            // SECTION: Additional Notes
            // _buildSectionTitle("Additional Notes"),
            // Text(invoice.additionalNotes ?? "-"),
            //
            // const Divider(height: 24),

            // SECTION: QR Code
            _buildSectionTitle("Scan to Pay / View Invoice"),
            Center(
              child: QrImageView(
                data:
                    invoice.upiLink ?? invoice.salesInvoiceNumber ?? "No data",
                version: QrVersions.auto,
                size: 180,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
