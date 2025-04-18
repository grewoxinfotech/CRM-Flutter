import 'dart:convert';

class SalesQuotationModel {
  final String id;
  final String salesQuotationNumber;
  final String relatedId;
  final String customer;
  final DateTime issueDate;
  final String category;
  final Map<String, dynamic> items;
  final double discount;
  final double tax;
  final double total;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  SalesQuotationModel({
    required this.id,
    required this.salesQuotationNumber,
    required this.relatedId,
    required this.customer,
    required this.issueDate,
    required this.category,
    required this.items,
    required this.discount,
    required this.tax,
    required this.total,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SalesQuotationModel.fromJson(Map<String, dynamic> json) {
    return SalesQuotationModel(
      id: json['id'],
      salesQuotationNumber: json['salesQuotationNumber'],
      relatedId: json['related_id'],
      customer: json['customer'],
      issueDate: DateTime.parse(json['issueDate']),
      category: json['category'],
      items: json['items'] != null && json['items'] is String
          ? Map<String, dynamic>.from(jsonDecode(json['items']))
          : {},
      discount: (json['discount'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'salesQuotationNumber': salesQuotationNumber,
      'related_id': relatedId,
      'customer': customer,
      'issueDate': issueDate.toIso8601String(),
      'category': category,
      'items': jsonEncode(items),
      'discount': discount,
      'tax': tax,
      'total': total,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
