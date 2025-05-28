class CompanyModel {
  String? id;
  String? accountOwner;
  String? companyName;
  String? companySource;
  String? email;
  String? companyNumber;
  String? companyType;
  String? companyCategory;
  String? companyRevenue;
  String? phoneCode;
  String? phoneNumber;
  String? website;
  String? billingAddress;
  String? billingCity;
  String? billingState;
  String? billingPinCode;
  String? billingCountry;
  String? shippingAddress;
  String? shippingCity;
  String? shippingState;
  String? shippingPinCode;
  String? shippingCountry;
  String? description;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

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
    this.billingPinCode,
    this.billingCountry,
    this.shippingAddress,
    this.shippingCity,
    this.shippingState,
    this.shippingPinCode,
    this.shippingCountry,
    this.description,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountOwner = json['account_owner'];
    companyName = json['company_name'];
    companySource = json['company_source'];
    email = json['email'];
    companyNumber = json['company_number'];
    companyType = json['company_type'];
    companyCategory = json['company_category'];
    companyRevenue = json['company_revenue'];
    phoneCode = json['phone_code'];
    phoneNumber = json['phone_number'];
    website = json['website'];
    billingAddress = json['billing_address'];
    billingCity = json['billing_city'];
    billingState = json['billing_state'];
    billingPinCode = json['billing_pincode'];
    billingCountry = json['billing_country'];
    shippingAddress = json['shipping_address'];
    shippingCity = json['shipping_city'];
    shippingState = json['shipping_state'];
    shippingPinCode = json['shipping_pincode'];
    shippingCountry = json['shipping_country'];
    description = json['description'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_owner'] = this.accountOwner;
    data['company_name'] = this.companyName;
    data['company_source'] = this.companySource;
    data['email'] = this.email;
    data['company_number'] = this.companyNumber;
    data['company_type'] = this.companyType;
    data['company_category'] = this.companyCategory;
    data['company_revenue'] = this.companyRevenue;
    data['phone_code'] = this.phoneCode;
    data['phone_number'] = this.phoneNumber;
    data['website'] = this.website;
    data['billing_address'] = this.billingAddress;
    data['billing_city'] = this.billingCity;
    data['billing_state'] = this.billingState;
    data['billing_pincode'] = this.billingPinCode;
    data['billing_country'] = this.billingCountry;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_city'] = this.shippingCity;
    data['shipping_state'] = this.shippingState;
    data['shipping_pincode'] = this.shippingPinCode;
    data['shipping_country'] = this.shippingCountry;
    data['description'] = this.description;
    data['client_id'] = this.clientId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
