class CustomerModel {
  bool? success;
  Message? message;
  dynamic data;

  CustomerModel({this.success, this.message, this.data});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (message != null) {
      map['message'] = message!.toJson();
    }
    map['data'] = data;
    return map;
  }
}

class Message {
  List<CustomerData>? data;
  Pagination? pagination;

  Message({this.data, this.pagination});

  Message.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<CustomerData>.from(
        json['data'].map((x) => CustomerData.fromJson(x)),
      );
    }
    pagination =
        json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination!.toJson();
    }
    return map;
  }
}

class CustomerData {
  String? id;
  String? relatedId;
  String? customerNumber;
  String? name;
  String? contact;
  String? phonecode;
  String? email;
  String? taxNumber;
  String? alternateNumber;
  String? textNumber;
  String? company;
  String? status;
  Address? billingAddress;
  Address? shippingAddress;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;
  String? notes;

  CustomerData({
    this.id,
    this.relatedId,
    this.customerNumber,
    this.name,
    this.contact,
    this.phonecode,
    this.email,
    this.taxNumber,
    this.alternateNumber,
    this.textNumber,
    this.company,
    this.status,
    this.billingAddress,
    this.shippingAddress,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
    this.notes,
  });

  CustomerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    relatedId = json['related_id'];
    customerNumber = json['customerNumber'];
    name = json['name'];
    contact = json['contact'];
    phonecode = json['phonecode'];
    email = json['email'];
    taxNumber = json['tax_number'];
    alternateNumber = json['alternate_number'];
    textNumber = json['text_number'];
    company = json['company'];
    status = json['status'];
    billingAddress =
        json['billing_address'] != null
            ? Address.fromJson(json['billing_address'])
            : null;
    shippingAddress =
        json['shipping_address'] != null
            ? Address.fromJson(json['shipping_address'])
            : null;
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    key = json['key'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['related_id'] = relatedId;
    map['customerNumber'] = customerNumber;
    map['name'] = name;
    map['contact'] = contact;
    map['phonecode'] = phonecode;
    map['email'] = email;
    map['tax_number'] = taxNumber;
    map['alternate_number'] = alternateNumber;
    map['text_number'] = textNumber;
    map['company'] = company;
    map['status'] = status;
    map['billing_address'] = billingAddress?.toJson();
    map['shipping_address'] = shippingAddress?.toJson();
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['key'] = key;
    map['notes'] = notes;
    return map;
  }
}

class Address {
  String? street;
  String? city;
  String? state;
  String? country;
  String? postalCode;

  Address({this.street, this.city, this.state, this.country, this.postalCode});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'postal_code': postalCode,
    };
  }

  static String formatAddress(Address? address) {
    if (address == null) return '-';

    final parts =
        [
          address.street?.trim(),
          address.city?.trim(),
          address.state?.trim(),
          address.country?.trim(),
          address.postalCode?.trim(),
        ].where((e) => e != null && e.isNotEmpty).toList();

    return parts.isEmpty ? '-' : parts.join(', ');
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
    final Map<String, dynamic> map = {};
    map['total'] = total;
    map['current'] = current;
    map['pageSize'] = pageSize;
    map['totalPages'] = totalPages;
    return map;
  }
}
