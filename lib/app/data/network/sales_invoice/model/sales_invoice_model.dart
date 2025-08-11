// import 'sales_invoice_item_model.dart';
//
// class SalesInvoice {
//   final String id;
//   final String salesInvoiceNumber;
//   final String relatedId;
//   final String customer;
//   final DateTime issueDate;
//   final DateTime dueDate;
//   final String? category;
//   final String upiLink;
//   final List<SalesInvoiceItem> items;
//   final double discount;
//   final double tax;
//   final double subtotal;
//   final double total;
//   final double? pendingAmount;
//   final double amount;
//   final String paymentStatus;
//   final String currency;
//   final double costOfGoods;
//   final double profit;
//   final double profitPercentage;
//   final String? additionalNotes;
//   final String clientId;
//   final String createdBy;
//   final String? updatedBy;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   SalesInvoice({
//     required this.id,
//     required this.salesInvoiceNumber,
//     required this.relatedId,
//     required this.customer,
//     required this.issueDate,
//     required this.dueDate,
//     this.category,
//     required this.upiLink,
//     required this.items,
//     required this.discount,
//     required this.tax,
//     required this.subtotal,
//     required this.total,
//     this.pendingAmount,
//     required this.amount,
//     required this.paymentStatus,
//     required this.currency,
//     required this.costOfGoods,
//     required this.profit,
//     required this.profitPercentage,
//     this.additionalNotes,
//     required this.clientId,
//     required this.createdBy,
//     this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory SalesInvoice.fromJson(Map<String, dynamic> json) {
//     return SalesInvoice(
//       id: json['id']?.toString() ?? '',
//       salesInvoiceNumber: json['salesInvoiceNumber']?.toString() ?? '',
//       relatedId: json['related_id']?.toString() ?? '',
//       customer: json['customer']?.toString() ?? '',
//       issueDate: DateTime.parse(json['issueDate'] ?? DateTime.now().toIso8601String()),
//       dueDate: DateTime.parse(json['dueDate'] ?? DateTime.now().toIso8601String()),
//       category: json['category']?.toString(),
//       upiLink: json['upiLink']?.toString() ?? '',
//       items: (json['items'] as List<dynamic>?)
//           ?.map((item) => SalesInvoiceItem.fromJson(item))
//           .toList() ?? [],
//       discount: (json['discount'] ?? 0).toDouble(),
//       tax: (json['tax'] ?? 0).toDouble(),
//       subtotal: (json['subtotal'] ?? 0).toDouble(),
//       total: (json['total'] ?? 0).toDouble(),
//       pendingAmount: (json['pendingAmount'] ?? 0).toDouble(),
//       amount: (json['amount'] ?? 0).toDouble(),
//       paymentStatus: json['payment_status']?.toString() ?? 'unpaid',
//       currency: json['currency']?.toString() ?? '',
//       costOfGoods: (json['cost_of_goods'] ?? 0).toDouble(),
//       profit: (json['profit'] ?? 0).toDouble(),
//       profitPercentage: (json['profit_percentage'] ?? 0).toDouble(),
//       additionalNotes: json['additional_notes']?.toString(),
//       clientId: json['client_id']?.toString() ?? '',
//       createdBy: json['created_by']?.toString() ?? '',
//       updatedBy: json['updated_by']?.toString(),
//       createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
//       updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'salesInvoiceNumber': salesInvoiceNumber,
//       'related_id': relatedId,
//       'customer': customer,
//       'issueDate': issueDate.toIso8601String(),
//       'dueDate': dueDate.toIso8601String(),
//       'category': category,
//       'upiLink': upiLink,
//       'items': items.map((item) => item.toJson()).toList(),
//       'discount': discount,
//       'tax': tax,
//       'subtotal': subtotal,
//       'total': total,
//       'pendingAmount': pendingAmount,
//       'amount': amount,
//       'payment_status': paymentStatus,
//       'currency': currency,
//       'cost_of_goods': costOfGoods,
//       'profit': profit,
//       'profit_percentage': profitPercentage,
//       'additional_notes': additionalNotes,
//       'client_id': clientId,
//       'created_by': createdBy,
//       'updated_by': updatedBy,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }

import 'sales_invoice_item_model.dart';

class SalesInvoice {
  final String? id;
  final String? salesInvoiceNumber;
  final String? relatedId;
  final String? relatedType; // NEW
  final String? customer;
  final String? gstin; // NEW
  final String? section; // NEW
  final DateTime? issueDate;
  final DateTime? dueDate;
  final String? category;
  final String? upiLink;
  final List<SalesInvoiceItem> items;
  final double? discount;
  final double? tax;
  final double? subtotal;
  final double? total;
  final double? pendingAmount;
  final double? amount;
  final String? paymentStatus;
  final String? currency;
  final String? currencyCode; // NEW
  final String? currencyIcon; // NEW
  final double? costOfGoods;
  final double? profit;
  final double? profitPercentage;
  final String? additionalNotes;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SalesInvoice({
    this.id,
    this.salesInvoiceNumber,
    this.relatedId,
    this.relatedType, // NEW
    this.customer,
    this.gstin, // NEW
    this.section, // NEW
    this.issueDate,
    this.dueDate,
    this.category,
    this.upiLink,
    required this.items,
    this.discount,
    this.tax,
    this.subtotal,
    this.total,
    this.pendingAmount,
    this.amount,
    this.paymentStatus,
    this.currency,
    this.currencyCode, // NEW
    this.currencyIcon, // NEW
    this.costOfGoods,
    this.profit,
    this.profitPercentage,
    this.additionalNotes,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory SalesInvoice.fromJson(Map<String, dynamic> json) {
    return SalesInvoice(
      id: json['id']?.toString() ?? '',
      salesInvoiceNumber: json['salesInvoiceNumber']?.toString() ?? '',
      relatedId: json['related_id']?.toString() ?? '',
      relatedType: json['related_type']?.toString(),
      customer: json['customer']?.toString() ?? '',
      gstin: json['gstin']?.toString(),
      section: json['section']?.toString(),
      issueDate: DateTime.parse(
        json['issueDate'] ?? DateTime.now().toIso8601String(),
      ),
      dueDate: DateTime.parse(
        json['dueDate'] ?? DateTime.now().toIso8601String(),
      ),
      category: json['category']?.toString(),
      upiLink: json['upiLink']?.toString() ?? '',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((item) => SalesInvoiceItem.fromJson(item))
              .toList() ??
          [],
      discount: (json['discount'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      pendingAmount: (json['pendingAmount'] ?? 0).toDouble(),
      amount: (json['amount'] ?? 0).toDouble(),
      paymentStatus: json['payment_status']?.toString() ?? 'unpaid',
      currency: json['currency']?.toString() ?? '',
      currencyCode: json['currency_code']?.toString(),
      currencyIcon: json['currency_icon']?.toString(),
      costOfGoods: (json['cost_of_goods'] ?? 0).toDouble(),
      profit: (json['profit'] ?? 0).toDouble(),
      profitPercentage: (json['profit_percentage'] ?? 0).toDouble(),
      additionalNotes: json['additional_notes']?.toString(),
      clientId: json['client_id']?.toString() ?? '',
      createdBy: json['created_by']?.toString() ?? '',
      updatedBy: json['updated_by']?.toString(),
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'salesInvoiceNumber': salesInvoiceNumber,
      'related_id': relatedId,
      'related_type': relatedType,
      'customer': customer,
      'gstin': gstin,
      'section': section,
      'issueDate': issueDate!.toIso8601String(),
      'dueDate': dueDate!.toIso8601String(),
      'category': category,
      'upiLink': upiLink,
      'items': items.map((item) => item.toJson()).toList(),
      'discount': discount,
      'tax': tax,
      'subtotal': subtotal,
      'total': total,
      'pendingAmount': pendingAmount,
      'amount': amount,
      'payment_status': paymentStatus,
      'currency': currency,
      'currency_code': currencyCode,
      'currency_icon': currencyIcon,
      'cost_of_goods': costOfGoods,
      'profit': profit,
      'profit_percentage': profitPercentage,
      'additional_notes': additionalNotes,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
