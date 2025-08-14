class VendorModel {
  bool? success;
  Message? message;
  dynamic data; // Keep dynamic if data can be anything, else use specific type

  VendorModel({this.success, this.message, this.data});

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      success: json['success'],
      message: json['message'] != null ? Message.fromJson(json['message']) : null,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (message != null) 'message': message!.toJson(),
      'data': data,
    };
  }
}

class Message {
  List<VendorData> data;
  Pagination? pagination;

  Message({List<VendorData>? data, this.pagination}) : data = data ?? [];

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      data: json['data'] != null
          ? (json['data'] as List).map((v) => VendorData.fromJson(v)).toList()
          : [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((v) => v.toJson()).toList(),
      if (pagination != null) 'pagination': pagination!.toJson(),
    };
  }
}

class VendorData {
  String? id;
  String? name;
  String? contact;
  String? phonecode;
  String? email;
  String? taxNumber;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  VendorData({
    this.id,
    this.name,
    this.contact,
    this.phonecode,
    this.email,
    this.taxNumber,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  factory VendorData.fromJson(Map<String, dynamic> json) {
    return VendorData(
      id: json['id'],
      name: json['name'],
      contact: json['contact'],
      phonecode: json['phonecode'],
      email: json['email'],
      taxNumber: json['taxNumber'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      zipcode: json['zipcode'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      key: json['key'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null && id!.isNotEmpty) data['id'] = id;
    if (name != null && name!.isNotEmpty) data['name'] = name;
    if (contact != null && contact!.isNotEmpty) data['contact'] = contact;
    if (phonecode != null && phonecode!.isNotEmpty) data['phonecode'] = phonecode;
    if (email != null && email!.isNotEmpty) data['email'] = email; // omit if null/empty
    if (taxNumber != null && taxNumber!.isNotEmpty) data['taxNumber'] = taxNumber;
    if (address != null && address!.isNotEmpty) data['address'] = address;
    if (city != null && city!.isNotEmpty) data['city'] = city;
    if (state != null && state!.isNotEmpty) data['state'] = state;
    if (country != null && country!.isNotEmpty) data['country'] = country;
    if (zipcode != null && zipcode!.isNotEmpty) data['zipcode'] = zipcode;
    if (clientId != null && clientId!.isNotEmpty) data['client_id'] = clientId;
    if (createdBy != null && createdBy!.isNotEmpty) data['created_by'] = createdBy;
    if (updatedBy != null && updatedBy!.isNotEmpty) data['updated_by'] = updatedBy;
    if (createdAt != null && createdAt!.isNotEmpty) data['createdAt'] = createdAt;
    if (updatedAt != null && updatedAt!.isNotEmpty) data['updatedAt'] = updatedAt;
    if (key != null && key!.isNotEmpty) data['key'] = key;
    return data;
  }
}

class Pagination {
  int? total;
  int? current;
  int? pageSize;
  int? totalPages;

  Pagination({this.total, this.current, this.pageSize, this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      current: json['current'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (total != null) data['total'] = total;
    if (current != null) data['current'] = current;
    if (pageSize != null) data['pageSize'] = pageSize;
    if (totalPages != null) data['totalPages'] = totalPages;
    return data;
  }
}
