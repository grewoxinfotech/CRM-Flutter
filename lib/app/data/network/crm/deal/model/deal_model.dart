class DealModel {
  final String? id;
  final String? dealTitle;
  final String? currency;
  final int? value;
  final String? pipeline;
  final String? stage;
  final String? status;
  final String? label;
  final DateTime? closedDate;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? source;
  final String? companyName;
  final String? website;
  final String? address;
  final List<Product>? products;
  final List<FileModel>? files;
  final String? assignedTo;
  final String? clientId;
  final bool? isWon;
  final String? companyId;
  final String? contactId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<DealMember> dealMembers;

  DealModel({
    this.id,
    this.dealTitle,
    this.currency,
    this.value,
    this.pipeline,
    this.stage,
    this.status,
    this.label,
    this.closedDate,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.source,
    this.companyName,
    this.website,
    this.address,
    this.products,
    this.files,
    this.assignedTo,
    this.clientId,
    this.isWon,
    this.companyId,
    this.contactId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.dealMembers = const [],
  });

  factory DealModel.fromJson(Map<String, dynamic> json) {
    List<DealMember> parseDealMembers() {
      // Handle different possible structures of deal_members
      if (json['deal_members'] != null) {
        // Case 1: deal_members is a map with a deal_members array inside
        if (json['deal_members'] is Map && json['deal_members']['deal_members'] != null) {
        return (json['deal_members']['deal_members'] as List<dynamic>)
            .map((memberId) => DealMember(memberId: memberId))
            .toList();
        }
        // Case 2: deal_members is directly an array
        else if (json['deal_members'] is List) {
          return (json['deal_members'] as List<dynamic>)
              .map((member) => member is String 
                  ? DealMember(memberId: member)
                  : DealMember.fromJson(member))
              .toList();
        }
      }
      return [];
    }

    return DealModel(
      id: json['id'] ?? '',
      dealTitle: json['dealTitle'] ?? '',
      currency: json['currency'] ?? '',
      value: json['value'] ?? 0,
      pipeline: json['pipeline'] ?? '',
      stage: json['stage'] ?? '',
      status: json['status'] ?? '',
      label: json['label'] ?? '',
      closedDate: json['closedDate'] != null ? DateTime.parse(json['closedDate']) : null,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      source: json['source'] ?? '',
      companyName: json['company_name'] ?? '',
      website: json['website'] ?? '',
      address: json['address'] ?? '',
      products: (json['products']?['products'] as List<dynamic>? ?? [])
              .map((e) => Product.fromJson(e))
              .toList(),
      files: (json['files'] as List<dynamic>? ?? [])
              .map((e) => FileModel.fromJson(e))
              .toList(),
      assignedTo: json['assigned_to'] ?? '',
      clientId: json['client_id'] ?? '',
      isWon: json['is_won'] ?? false,
      companyId: json['company_id'] ?? '',
      contactId: json['contact_id'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      dealMembers: parseDealMembers(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dealTitle': dealTitle,
      'currency': currency,
      'value': value,
      'pipeline': pipeline,
      'stage': stage,
      'status': status,
      'label': label,
      'closedDate': closedDate?.toIso8601String(),
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'source': source,
      'company_name': companyName,
      'website': website,
      'address': address,
      'products': {'products': products?.map((p) => p.toJson()).toList()},
      'files': files?.map((f) => f.toJson()).toList(),
      'assigned_to': assignedTo,
      'client_id': clientId,
      'is_won': isWon,
      'company_id': companyId,
      'contact_id': contactId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'dealMembers': dealMembers.map((m) => m.toJson()).toList(),
    };
  }
}

class DealMember {
  final String memberId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DealMember({
    required this.memberId,
    this.createdAt,
    this.updatedAt,
  });

  factory DealMember.fromJson(Map<String, dynamic> json) {
    return DealMember(
      memberId: json['memberId'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class Product {
  final String? productId;
  final String? name;
  final int? quantity;
  final int? price;

  Product({this.productId, this.name, this.quantity, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'] ?? '',
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}

class FileModel {
  final String? url;
  final String? filename;

  FileModel({this.url, this.filename});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(url: json['url'] ?? '', filename: json['filename'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'filename': filename};
  }
}
