class CustomerModel {
  final String? id;
  final String? relatedId;
  final String? customerNumber;
  final String? name;
  final String? contact;
  final String? phoneCode;
  final String? email;
  final String? taxNumber;
  final Address? billingAddress;
  final Address? shippingAddress;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CustomerModel({
   required this.id,
   required this.relatedId,
   required this.customerNumber,
   required this.name,
   required this.contact,
   required this.phoneCode,
   required this.email,
   required this.taxNumber,
   required this.billingAddress,
   required this.shippingAddress,
   required this.clientId,
   required this.createdBy,
   required this.updatedBy,
   required this.createdAt,
   required this.updatedAt,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      relatedId: json['related_id'],
      customerNumber: json['customerNumber'],
      name: json['name'],
      contact: json['contact'],
      phoneCode: json['phonecode'],
      email: json['email'],
      taxNumber: json['tax_number'],
      billingAddress: Address.fromJson(json['billing_address']),
      shippingAddress: Address.fromJson(json['shipping_address']),
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
      'related_id': relatedId,
      'customerNumber': customerNumber,
      'name': name,
      'contact': contact,
      'phonecode': phoneCode,
      'email': email,
      'tax_number': taxNumber,
      'billing_address': billingAddress!.toJson(),
      'shipping_address': shippingAddress!.toJson(),
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}

class Address {
  final String city;
  final String state;
  final String street;
  final String country;
  final String postalCode;

  Address({
    required this.city,
    required this.state,
    required this.street,
    required this.country,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      state: json['state'],
      street: json['street'],
      country: json['country'],
      postalCode: json['postal_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'state': state,
      'street': street,
      'country': country,
      'postal_code': postalCode,
    };
  }
}
