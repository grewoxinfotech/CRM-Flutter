// class ContactData {
//   String? id;
//   String? contactOwner;
//   String? firstName;
//   String? lastName;
//   String? companyId;
//   String? website;
//   String? email;
//   String? phoneCode;
//   String? phone;
//   String? contactSource;
//   String? description;
//   String? address;
//   String? city;
//   String? state;
//   String? country;
//   dynamic relatedId; // Changed from Null? to dynamic
//   String? clientId;
//   String? createdBy;
//   String? updatedBy;
//   String? createdAt;
//   String? updatedAt;
//   String? key;
//
//   ContactData({
//     this.id,
//     this.contactOwner,
//     this.firstName,
//     this.lastName,
//     this.companyId,
//     this.website,
//     this.email,
//     this.phoneCode,
//     this.phone,
//     this.contactSource,
//     this.description,
//     this.address,
//     this.city,
//     this.state,
//     this.country,
//     this.relatedId,
//     this.clientId,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//     this.key,
//   });
//
//   factory ContactData.fromJson(Map<String, dynamic> json) {
//     return ContactData(
//       id: json['id'],
//       contactOwner: json['contact_owner'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       companyId: json['company_name'],
//       website: json['website'],
//       email: json['email'],
//       phoneCode: json['phone_code'],
//       phone: json['phone'],
//       contactSource: json['contact_source'],
//       description: json['description'],
//       address: json['address'],
//       city: json['city'],
//       state: json['state'],
//       country: json['country'],
//       relatedId: json['related_id'],
//       clientId: json['client_id'],
//       createdBy: json['created_by'],
//       updatedBy: json['updated_by'],
//       createdAt: json['createdAt'],
//       updatedAt: json['updatedAt'],
//       key: json['key'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['contact_owner'] = contactOwner;
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['company_name'] = companyId;
//     data['website'] = website;
//     data['email'] = email;
//     data['phone_code'] = phoneCode;
//     data['phone'] = phone;
//     data['contact_source'] = contactSource;
//     data['description'] = description;
//     data['address'] = address;
//     data['city'] = city;
//     data['state'] = state;
//     data['country'] = country;
//     data['related_id'] = relatedId;
//     data['client_id'] = clientId;
//     data['created_by'] = createdBy;
//     data['updated_by'] = updatedBy;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['key'] = key;
//     return data;
//   }
// }
//
// class ContactModel {
//   final bool success;
//   final ContactMessage? message;
//   final dynamic data;
//   final List<ContactData>? contacts;
//
//   ContactModel({required this.success, this.message, this.data, this.contacts});
//
//   factory ContactModel.fromJson(Map<String, dynamic> json) {
//     return ContactModel(
//       success: json['success'],
//       message:
//           json['message'] != null
//               ? ContactMessage.fromJson(json['message'])
//               : null,
//       data: json['data'],
//       contacts:
//           json['message'] != null && json['message']['data'] != null
//               ? List<ContactData>.from(
//                 json['message']['data'].map((x) => ContactData.fromJson(x)),
//               )
//               : null,
//     );
//   }
// }
//
// class ContactMessage {
//   final List<ContactData> data;
//   final ContactPagination pagination;
//
//   ContactMessage({required this.data, required this.pagination});
//
//   factory ContactMessage.fromJson(Map<String, dynamic> json) {
//     return ContactMessage(
//       data: List<ContactData>.from(
//         json['data'].map((x) => ContactData.fromJson(x)),
//       ),
//       pagination: ContactPagination.fromJson(json['pagination']),
//     );
//   }
// }
//
// class ContactPagination {
//   final int total;
//   final int current;
//   final int pageSize;
//   final int totalPages;
//
//   ContactPagination({
//     required this.total,
//     required this.current,
//     required this.pageSize,
//     required this.totalPages,
//   });
//
//   factory ContactPagination.fromJson(Map<String, dynamic> json) {
//     return ContactPagination(
//       total: json['total'],
//       current: json['current'],
//       pageSize: json['pageSize'],
//       totalPages: json['totalPages'],
//     );
//   }
// }

class ContactModel {
  bool? success;
  ContactMessage? message;
  dynamic data;

  ContactModel({this.success, this.message, this.data});

  ContactModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null
            ? ContactMessage.fromJson(json['message'])
            : null;
    data = json['message']?['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (message != null) {
      map['message'] = message!.toJson();
    }
    map['message']?['data'] = data;
    return map;
  }
}

class ContactMessage {
  List<ContactData>? data;
  ContactPagination? pagination;

  ContactMessage({this.data, this.pagination});

  ContactMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<ContactData>.from(
        json['data'].map((x) => ContactData.fromJson(x)),
      );
    }
    pagination =
        json['pagination'] != null
            ? ContactPagination.fromJson(json['pagination'])
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

class ContactData {
  String? id;
  String? contactOwner;
  String? firstName;
  String? lastName;
  String? companyId;
  String? website;
  String? email;
  String? phoneCode;
  String? phone;
  String? contactSource;
  String? description;
  String? address;
  String? city;
  String? state;
  String? country;
  dynamic relatedId;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  ContactData({
    this.id,
    this.contactOwner,
    this.firstName,
    this.lastName,
    this.companyId,
    this.website,
    this.email,
    this.phoneCode,
    this.phone,
    this.contactSource,
    this.description,
    this.address,
    this.city,
    this.state,
    this.country,
    this.relatedId,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.key,
  });

  ContactData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactOwner = json['contact_owner'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    companyId = json['company_name'];
    website = json['website'];
    email = json['email'];
    phoneCode = json['phone_code'];
    phone = json['phone'];
    contactSource = json['contact_source'];
    description = json['description'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    relatedId = json['related_id'];
    clientId = json['client_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['contact_owner'] = contactOwner;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['company_name'] = companyId;
    map['website'] = website;
    map['email'] = email;
    map['phone_code'] = phoneCode;
    map['phone'] = phone;
    map['contact_source'] = contactSource;
    map['description'] = description;
    map['address'] = address;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    map['related_id'] = relatedId;
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['key'] = key;
    return map;
  }
}

class ContactPagination {
  int? total;
  int? current;
  int? pageSize;
  int? totalPages;

  ContactPagination({this.total, this.current, this.pageSize, this.totalPages});

  ContactPagination.fromJson(Map<String, dynamic> json) {
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
