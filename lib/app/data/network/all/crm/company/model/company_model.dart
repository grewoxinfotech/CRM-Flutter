class CompanyModel {
  final String? id;
  final String? accountOwner;
  final String? companyName;
  final String? companySource;
  final String? email;
  final String? companyNumber;
  final String? companyType;
  final String? companyCategory;
  final String? companyRevenue;
  final String? phoneCode;
  final String? phoneNumber;
  final String? website;
  final String? billingAddress;
  final String? billingCity;
  final String? billingState;
  final String? billingPincode;
  final String? billingCountry;
  final String? shippingAddress;
  final String? shippingCity;
  final String? shippingState;
  final String? shippingPincode;
  final String? shippingCountry;
  final String? description;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CompanyModel({
    this.id,
    this.accountOwner,
    this.companyName,
    this.companySource,
    this.email,
    this.companyNumber,
    this.companyType,
    this.companyCategory,
    this.companyRevenue,
    this.phoneCode,
    this.phoneNumber,
    this.website,
    this.billingAddress,
    this.billingCity,
    this.billingState,
    this.billingPincode,
    this.billingCountry,
    this.shippingAddress,
    this.shippingCity,
    this.shippingState,
    this.shippingPincode,
    this.shippingCountry,
    this.description,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      accountOwner: json['account_owner'],
      companyName: json['company_name'],
      companySource: json['company_source'],
      email: json['email'],
      companyNumber: json['company_number'],
      companyType: json['company_type'],
      companyCategory: json['company_category'],
      companyRevenue: json['company_revenue'],
      phoneCode: json['phone_code'],
      phoneNumber: json['phone_number'],
      website: json['website'],
      billingAddress: json['billing_address'],
      billingCity: json['billing_city'],
      billingState: json['billing_state'],
      billingPincode: json['billing_pincode'],
      billingCountry: json['billing_country'],
      shippingAddress: json['shipping_address'],
      shippingCity: json['shipping_city'],
      shippingState: json['shipping_state'],
      shippingPincode: json['shipping_pincode'],
      shippingCountry: json['shipping_country'],
      description: json['description'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_owner': accountOwner,
      'company_name': companyName,
      'company_source': companySource,
      'email': email,
      'company_number': companyNumber,
      'company_type': companyType,
      'company_category': companyCategory,
      'company_revenue': companyRevenue,
      'phone_code': phoneCode,
      'phone_number': phoneNumber,
      'website': website,
      'billing_address': billingAddress,
      'billing_city': billingCity,
      'billing_state': billingState,
      'billing_pincode': billingPincode,
      'billing_country': billingCountry,
      'shipping_address': shippingAddress,
      'shipping_city': shippingCity,
      'shipping_state': shippingState,
      'shipping_pincode': shippingPincode,
      'shipping_country': shippingCountry,
      'description': description,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
