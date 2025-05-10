class CompanyAccountModel {
  final String id;
  final String accountOwner;
  final String companyName;
  final String companySite;
  final String companyNumber;
  final String companyType;
  final String companyCategory;
  final String companyIndustry;
  final String companyRevenue;
  final String phoneNumber;
  final String website;
  final String fax;
  final String ownership;
  final int numberOfEmployees;
  final String billingAddress;
  final String billingCity;
  final String billingState;
  final String billingPincode;
  final String billingCountry;
  final String shippingAddress;
  final String shippingCity;
  final String shippingState;
  final String shippingPincode;
  final String shippingCountry;
  final String description;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  CompanyAccountModel({
    required this.id,
    required this.accountOwner,
    required this.companyName,
    required this.companySite,
    required this.companyNumber,
    required this.companyType,
    required this.companyCategory,
    required this.companyIndustry,
    required this.companyRevenue,
    required this.phoneNumber,
    required this.website,
    required this.fax,
    required this.ownership,
    required this.numberOfEmployees,
    required this.billingAddress,
    required this.billingCity,
    required this.billingState,
    required this.billingPincode,
    required this.billingCountry,
    required this.shippingAddress,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingPincode,
    required this.shippingCountry,
    required this.description,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CompanyAccountModel.fromJson(Map<String, dynamic> json) {
    return CompanyAccountModel(
      id: json['id'],
      accountOwner: json['account_owner'],
      companyName: json['company_name'],
      companySite: json['company_site'],
      companyNumber: json['company_number'],
      companyType: json['company_type'],
      companyCategory: json['company_category'],
      companyIndustry: json['company_industry'],
      companyRevenue: json['company_revenue'],
      phoneNumber: json['phone_number'],
      website: json['website'],
      fax: json['fax'],
      ownership: json['ownership'],
      numberOfEmployees: json['number_of_employees'],
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_owner': accountOwner,
      'company_name': companyName,
      'company_site': companySite,
      'company_number': companyNumber,
      'company_type': companyType,
      'company_category': companyCategory,
      'company_industry': companyIndustry,
      'company_revenue': companyRevenue,
      'phone_number': phoneNumber,
      'website': website,
      'fax': fax,
      'ownership': ownership,
      'number_of_employees': numberOfEmployees,
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
