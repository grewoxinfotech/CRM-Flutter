class SalesCustomer {
  final String id;
  final String? relatedId;
  final String? customerNumber;
  final String name;
  final String contact;
  final String? phonecode;
  final String? email;
  final String? taxNumber;
  final String? billingAddress;
  final String? shippingAddress;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  SalesCustomer({
    required this.id,
    this.relatedId,
    this.customerNumber,
    required this.name,
    required this.contact,
    this.phonecode,
    this.email,
    this.taxNumber,
    this.billingAddress,
    this.shippingAddress,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SalesCustomer.fromJson(Map<String, dynamic> json) {
    // Helper function to safely extract string values
    String safeString(dynamic value) {
      if (value == null) return '';
      if (value is String) return value;
      return value.toString();
    }
    
    return SalesCustomer(
      id: safeString(json['id']),
      relatedId: json['related_id'] != null ? safeString(json['related_id']) : null,
      customerNumber: json['customerNumber'] != null ? safeString(json['customerNumber']) : null,
      name: safeString(json['name']),
      contact: safeString(json['contact']),
      phonecode: json['phonecode'] != null ? safeString(json['phonecode']) : null,
      email: json['email'] != null ? safeString(json['email']) : null,
      taxNumber: json['tax_number'] != null ? safeString(json['tax_number']) : null,
      billingAddress: json['billing_address'] != null ? safeString(json['billing_address']) : null,
      shippingAddress: json['shipping_address'] != null ? safeString(json['shipping_address']) : null,
      clientId: json['client_id'] != null ? safeString(json['client_id']) : null,
      createdBy: json['created_by'] != null ? safeString(json['created_by']) : null,
      updatedBy: json['updated_by'] != null ? safeString(json['updated_by']) : null,
      createdAt: DateTime.parse(safeString(json['createdAt']) != '' ? safeString(json['createdAt']) : DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(safeString(json['updatedAt']) != '' ? safeString(json['updatedAt']) : DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'related_id': relatedId,
      'customerNumber': customerNumber,
      'name': name,
      'contact': contact,
      'phonecode': phonecode,
      'email': email,
      'tax_number': taxNumber,
      'billing_address': billingAddress,
      'shipping_address': shippingAddress,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
} 