import 'dart:convert';

import 'package:crm_flutter/app/data/network/all/crm/deal/model/deal_model.dart';

class InvoiceModel {
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
  final List<String> leadMembers;
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

  InvoiceModel({
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

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    List<String> decodedMembers = [];
    if (json['lead_members'] is String) {
      try {
        final decoded = jsonDecode(json['lead_members']);
        if (decoded is Map && decoded['lead_members'] is List) {
          decodedMembers = List<String>.from(decoded['lead_members']);
        }
      } catch (_) {}
    }

    List<FileModel> decodedFiles = [];
    if (json['files'] is String) {
      try {
        final fileList = jsonDecode(json['files']);
        if (fileList is List) {
          decodedFiles = fileList.map((e) => FileModel.fromJson(e)).toList();
        }
      } catch (_) {}
    }

    return InvoiceModel(
      id: json['id'],
      inquiryId: json['inquiry_id'],
      leadTitle: json['leadTitle'],
      leadStage: json['leadStage'],
      pipeline: json['pipeline'],
      currency: json['currency'],
      leadValue: json['leadValue'],
      companyName: json['company_name'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneCode: json['phoneCode'],
      telephone: json['telephone'],
      email: json['email'],
      address: json['address'],
      leadMembers: decodedMembers,
      source: json['source'],
      category: json['category'],
      files: decodedFiles,
      status: json['status'],
      interestLevel: json['interest_level'],
      leadScore: json['lead_score'],
      isConverted: json['is_converted'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt:
          json['createdAt'] != null
              ? DateTime.tryParse(json['createdAt'])
              : null,
      updatedAt:
          json['updatedAt'] != null
              ? DateTime.tryParse(json['updatedAt'])
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
      'lead_members': jsonEncode({'lead_members': leadMembers}),
      'source': source,
      'category': category,
      'files': jsonEncode(files.map((e) => e.toJson()).toList()),
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
