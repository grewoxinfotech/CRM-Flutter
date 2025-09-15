class CompanyModel {
  bool? success;
  Message? message;
  CompanyData? data;

  CompanyModel({this.success, this.message, this.data});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    data['data'] = this.data;
    return data;
  }
}

class Message {
  List<CompanyData>? data;
  Pagination? pagination;

  Message({this.data, this.pagination});

  Message.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CompanyData>[];
      json['data'].forEach((v) {
        data!.add(new CompanyData.fromJson(v));
      });
    }
    pagination =
        json['pagination'] != null
            ? new Pagination.fromJson(json['pagination'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class CompanyData {
  String? id;
  String? accountOwner;
  String? companyName;
  Null? companySource;
  String? email;
  Null? companyNumber;
  String? companyType;
  String? companyCategory;
  String? companyRevenue;
  String? phoneCode;
  String? phoneNumber;
  String? website;
  String? billingAddress;
  String? billingCity;
  String? billingState;
  String? billingPincode;
  String? billingCountry;
  String? shippingAddress;
  String? shippingCity;
  String? shippingState;
  String? shippingPincode;
  String? shippingCountry;
  String? description;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  CompanyData({
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
    this.key,
  });

  CompanyData.fromJson(Map<String, dynamic> json) {
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
    billingPincode = json['billing_pincode'];
    billingCountry = json['billing_country'];
    shippingAddress = json['shipping_address'];
    shippingCity = json['shipping_city'];
    shippingState = json['shipping_state'];
    shippingPincode = json['shipping_pincode'];
    shippingCountry = json['shipping_country'];
    description = json['description'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    key = json['key'];
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
    data['billing_pincode'] = this.billingPincode;
    data['billing_country'] = this.billingCountry;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_city'] = this.shippingCity;
    data['shipping_state'] = this.shippingState;
    data['shipping_pincode'] = this.shippingPincode;
    data['shipping_country'] = this.shippingCountry;
    data['description'] = this.description;
    data['client_id'] = this.clientId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['key'] = this.key;
    return data;
  }
}

class Pagination {
  int? total;
  int? current;
  int? pageSize;
  int? totalPages;

  Pagination({this.total, this.current, this.pageSize, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    current = json['current'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['current'] = this.current;
    data['pageSize'] = this.pageSize;
    data['totalPages'] = this.totalPages;
    return data;
  }
}
