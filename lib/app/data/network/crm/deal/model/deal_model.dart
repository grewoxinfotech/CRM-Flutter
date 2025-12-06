import 'package:crm_flutter/app/data/network/sales/product_service/model/product_model.dart';

class DealModel {
  bool? success;
  DealMessage? message;
  dynamic data;

  DealModel({this.success, this.message, this.data});

  DealModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? DealMessage.fromJson(json['message']) : null;
    data = json['message']['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (message != null) {
      map['message'] = message!.toJson();
    }
    map['message']['data'] = data;
    return map;
  }
}

class DealMessage {
  List<DealData>? data;
  Pagination? pagination;

  DealMessage({this.data, this.pagination});

  DealMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<DealData>.from(json['data'].map((x) => DealData.fromJson(x)));
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

class DealData {
  final String? id;
  final String? dealTitle;
  final String? currency;
  final String? leadId;
  final int? value;
  final String? pipeline;
  final String? stage;
  final String? status;
  final String? label;
  final String? category;
  final DateTime? closedDate;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? source;
  final String? companyName;
  final String? website;
  final String? address;
  final List<Data>? products;
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

  DealData({
    this.leadId,
    this.id,
    this.dealTitle,
    this.currency,
    this.value,
    this.pipeline,
    this.stage,
    this.status,
    this.label,
    this.category,
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

  factory DealData.fromJson(Map<String, dynamic> json) {
    List<DealMember> parseDealMembers() {
      // Handle different possible structures of deal_members
      if (json['deal_members'] != null) {
        // Case 1: deal_members is a map with a deal_members array inside
        if (json['deal_members'] is Map &&
            json['deal_members']['deal_members'] != null) {
          return (json['deal_members']['deal_members'] as List<dynamic>)
              .map((memberId) => DealMember(memberId: memberId))
              .toList();
        }
        // Case 2: deal_members is directly an array
        else if (json['deal_members'] is List) {
          return (json['deal_members'] as List<dynamic>)
              .map(
                (member) =>
                    member is String
                        ? DealMember(memberId: member)
                        : DealMember.fromJson(member),
              )
              .toList();
        }
      }
      return [];
    }

    return DealData(
      id: json['id'] ?? '',
      dealTitle: json['dealTitle'] ?? '',
      currency: json['currency'] ?? '',
      value: json['value'] ?? 0,
      pipeline: json['pipeline'] ?? '',
      stage: json['stage'] ?? '',
      status: json['status'] ?? '',
      label: json['label'] ?? '',
      category: json['category'] ?? '',
      closedDate:
          json['closedDate'] != null
              ? DateTime.parse(json['closedDate'])
              : null,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      source: json['source'] ?? '',
      companyName: json['company_name'] ?? '',
      website: json['website'] ?? '',
      address: json['address'] ?? '',
      products:
          (json['products']?['products'] as List<dynamic>? ?? [])
              .map((e) => Data.fromJson(e))
              .toList(),
      files:
          (json['files'] as List<dynamic>? ?? [])
              .map((e) => FileModel.fromJson(e))
              .toList(),
      assignedTo: json['assigned_to'] ?? '',
      clientId: json['client_id'] ?? '',
      isWon: json['is_won'] ?? false,
      companyId: json['company_id'] ?? '',
      contactId: json['contact_id'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'] ?? '',
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      dealMembers: parseDealMembers(),
      leadId: json['leadId'] ?? '',
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
      'category': category,
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
      'leadId': leadId,
    };
  }
}

class DealMember {
  final String memberId;
  final String? createdAt;
  final String? updatedAt;

  DealMember({required this.memberId, this.createdAt, this.updatedAt});

  factory DealMember.fromJson(Map<String, dynamic> json) {
    return DealMember(
      memberId: json['memberId'] ?? '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
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
    return {
      'total': total,
      'current': current,
      'pageSize': pageSize,
      'totalPages': totalPages,
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
