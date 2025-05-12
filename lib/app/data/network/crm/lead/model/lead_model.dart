import 'package:crm_flutter/app/data/network/file/model/file_model.dart';

class LeadModel {
  final String? id;
  final String? inquiryId;
  final String? leadTitle;
  final String? leadStage;
  final String? pipeline;
  final String? currency;
  final int? leadValue;
  final String? companyName;
  final String? firstName;
  final String? lastName;
  final String? phoneCode;
  final String? telephone;
  final String? email;
  final String? address;
  final List<LeadMember> leadMembers;
  final String? source;
  final String? category;
  final List<FileModel> files;
  final String? status;
  final String? interestLevel;
  final int? leadScore;
  final bool? isConverted;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LeadModel({
    this.id,
    this.inquiryId,
    this.leadTitle,
    this.leadStage,
    this.pipeline,
    this.currency,
    this.leadValue,
    this.companyName,
    this.firstName,
    this.lastName,
    this.phoneCode,
    this.telephone,
    this.email,
    this.address,
    this.leadMembers = const [],
    this.source,
    this.category,
    this.files = const [],
    this.status,
    this.interestLevel,
    this.leadScore,
    this.isConverted,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) {
    List<LeadMember> members = [];
    if (json['lead_members'] != null) {
      if (json['lead_members'] is Map && json['lead_members']['lead_members'] is List) {
        final memberIds = json['lead_members']['lead_members'] as List;
        members = memberIds.map((id) => LeadMember(
          memberId: id.toString(),
          name: '',
          designation: '',
          email: '',
          phone: '',
        )).toList();
      } else if (json['lead_members'] is List) {
        final memberIds = json['lead_members'] as List;
        members = memberIds.map((id) => LeadMember(
          memberId: id.toString(),
          name: '',
          designation: '',
          email: '',
          phone: '',
        )).toList();
      }
    }

    List<FileModel> leadFiles = [];
    if (json['files'] != null) {
      if (json['files'] is List) {
        leadFiles = (json['files'] as List)
            .map((e) => FileModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }

    return LeadModel(
      id: json['id']?.toString(),
      inquiryId: json['inquiry_id']?.toString(),
      leadTitle: json['leadTitle']?.toString(),
      leadStage: json['leadStage']?.toString(),
      pipeline: json['pipeline']?.toString(),
      currency: json['currency']?.toString(),
      leadValue: json['leadValue'] != null ? int.tryParse(json['leadValue'].toString()) : null,
      companyName: json['company_name']?.toString(),
      firstName: json['firstName']?.toString(),
      lastName: json['lastName']?.toString(),
      phoneCode: json['phoneCode']?.toString(),
      telephone: json['telephone']?.toString(),
      email: json['email']?.toString(),
      address: json['address']?.toString(),
      leadMembers: members,
      source: json['source']?.toString(),
      category: json['category']?.toString(),
      files: leadFiles,
      status: json['status']?.toString(),
      interestLevel: json['interest_level']?.toString(),
      leadScore: json['lead_score'] != null ? int.tryParse(json['lead_score'].toString()) : null,
      isConverted: json['is_converted']?.toString().toLowerCase() == 'true',
      clientId: json['client_id']?.toString(),
      createdBy: json['created_by']?.toString(),
      updatedBy: json['updated_by']?.toString(),
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'inquiry_id': inquiryId,
      'leadTitle': leadTitle,
      'leadStage': leadStage,
      'pipeline': pipeline,
      'currency': currency,
      'leadValue': leadValue,
      'company_name': companyName,
      'firstName': firstName,
      'lastName': lastName,
      'phoneCode': phoneCode,
      'telephone': telephone,
      'email': email,
      'address': address,
      'lead_members': {
        'lead_members': leadMembers.map((e) => e.toJson()).toList(),
      },
      'source': source,
      'category': category,
      'files': files.map((e) => e.toJson()).toList(),
      'status': status,
      'interest_level': interestLevel,
      'lead_score': leadScore,
      'is_converted': isConverted,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}


class LeadMember {
  final String memberId;
  final String name;
  final String designation;
  final String email;
  final String phone;

  LeadMember({
    required this.memberId,
    required this.name,
    required this.designation,
    required this.email,
    required this.phone,
  });

  factory LeadMember.fromJson(Map<String, dynamic> json) {
    return LeadMember(
      memberId: json['member_id'],
      name: json['name'],
      designation: json['designation'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
      'name': name,
      'designation': designation,
      'email': email,
      'phone': phone,
    };
  }
}
