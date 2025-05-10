import 'dart:convert';

class OrderModel {
  final String id;
  final String relatedId;
  final String? orderNumber;
  final String client;
  final String billingAddress;
  final String shippingAddress;
  final String project;
  final String generatedBy;
  final String status;
  final Map<String, dynamic> items;
  final double discount;
  final double tax;
  final double total;
  final String clientNote;
  final String clientId;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.relatedId,
    this.orderNumber,
    required this.client,
    required this.billingAddress,
    required this.shippingAddress,
    required this.project,
    required this.generatedBy,
    required this.status,
    required this.items,
    required this.discount,
    required this.tax,
    required this.total,
    required this.clientNote,
    required this.clientId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      relatedId: json['related_id'],
      orderNumber: json['orderNumber'],
      client: json['client'],
      billingAddress: json['billing_address'],
      shippingAddress: json['shipping_address'],
      project: json['project'],
      generatedBy: json['genratedBy'],
      status: json['status'],
      items: jsonDecode(json['items']),
      discount: json['discount'].toDouble(),
      tax: json['tax'].toDouble(),
      total: json['total'].toDouble(),
      clientNote: json['client_Note'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'related_id': relatedId,
      'orderNumber': orderNumber,
      'client': client,
      'billing_address': billingAddress,
      'shipping_address': shippingAddress,
      'project': project,
      'genratedBy': generatedBy,
      'status': status,
      'items': jsonEncode(items),
      'discount': discount,
      'tax': tax,
      'total': total,
      'client_Note': clientNote,
      'client_id': clientId,
      'created_by': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
