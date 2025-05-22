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
    return SalesCustomer(
      id: json['id'] ?? '',
      relatedId: json['related_id'],
      customerNumber: json['customerNumber'],
      name: json['name'] ?? '',
      contact: json['contact'] ?? '',
      phonecode: json['phonecode'],
      email: json['email'],
      taxNumber: json['tax_number'],
      billingAddress: json['billing_address'],
      shippingAddress: json['shipping_address'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
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