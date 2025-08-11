class ContactModel {
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
  dynamic relatedId; // Changed from Null? to dynamic
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? key;

  ContactModel({
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

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'],
      contactOwner: json['contact_owner'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      companyId: json['company_name'],
      website: json['website'],
      email: json['email'],
      phoneCode: json['phone_code'],
      phone: json['phone'],
      contactSource: json['contact_source'],
      description: json['description'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      relatedId: json['related_id'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      key: json['key'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contact_owner'] = contactOwner;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['company_name'] = companyId;
    data['website'] = website;
    data['email'] = email;
    data['phone_code'] = phoneCode;
    data['phone'] = phone;
    data['contact_source'] = contactSource;
    data['description'] = description;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['related_id'] = relatedId;
    data['client_id'] = clientId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['key'] = key;
    return data;
  }
}

class ContactResponse {
  final bool success;
  final ContactMessage? message;
  final dynamic data;
  final List<ContactModel>? contacts;

  ContactResponse({
    required this.success,
    this.message,
    this.data,
    this.contacts,
  });

  factory ContactResponse.fromJson(Map<String, dynamic> json) {
    return ContactResponse(
      success: json['success'],
      message:
          json['message'] != null
              ? ContactMessage.fromJson(json['message'])
              : null,
      data: json['data'],
      contacts:
          json['message'] != null && json['message']['data'] != null
              ? List<ContactModel>.from(
                json['message']['data'].map((x) => ContactModel.fromJson(x)),
              )
              : null,
    );
  }
}

class ContactMessage {
  final List<ContactModel> data;
  final ContactPagination pagination;

  ContactMessage({required this.data, required this.pagination});

  factory ContactMessage.fromJson(Map<String, dynamic> json) {
    return ContactMessage(
      data: List<ContactModel>.from(
        json['data'].map((x) => ContactModel.fromJson(x)),
      ),
      pagination: ContactPagination.fromJson(json['pagination']),
    );
  }
}

class ContactPagination {
  final int total;
  final int current;
  final int pageSize;
  final int totalPages;

  ContactPagination({
    required this.total,
    required this.current,
    required this.pageSize,
    required this.totalPages,
  });

  factory ContactPagination.fromJson(Map<String, dynamic> json) {
    return ContactPagination(
      total: json['total'],
      current: json['current'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
    );
  }
}
