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
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'phonecode': phonecode,
      'email': email,
      'taxNumber': taxNumber,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipcode,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'key': key,
    };
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
    return {
      'total': total,
      'current': current,
      'pageSize': pageSize,
      'totalPages': totalPages,
    };
  }
}
