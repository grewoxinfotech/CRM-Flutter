import 'dart:convert';

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
  final List<String>? leadMembers;
  final String? source;
  final String? category;
  final List<FileModel>? files;
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
    this.leadMembers,
    this.source,
    this.category,
    this.files,
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
    return LeadModel(
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
      leadMembers: List<String>.from(
        jsonDecode(json['lead_members'])['lead_members'],
      ),
      source: json['source'],
      category: json['category'],
      files:
          (jsonDecode(json['files']) as List)
              .map((e) => FileModel.fromJson(e))
              .toList(),
      status: json['status'],
      interestLevel: json['interest_level'],
      leadScore: json['lead_score'],
      isConverted: json['is_converted'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "inquiry_id": inquiryId,
      "leadTitle": leadTitle,
      "leadStage": leadStage,
      "pipeline": pipeline,
      "currency": currency,
      "leadValue": leadValue,
      "company_name": companyName,
      "firstName": firstName,
      "lastName": lastName,
      "phoneCode": phoneCode,
      "telephone": telephone,
      "email": email,
      "address": address,
      "lead_members": jsonEncode({"lead_members": leadMembers}),
      "source": source,
      "category": category,
      "files": jsonEncode(files!.map((e) => e.toJson()).toList()),
      "status": status,
      "interest_level": interestLevel,
      "lead_score": leadScore,
      "is_converted": isConverted,
      "client_id": clientId,
      "created_by": createdBy,
      "updated_by": updatedBy,
      "createdAt": createdAt!.toIso8601String(),
      "updatedAt": updatedAt!.toIso8601String(),
    };
  }
}

class FileModel {
  final String filename;
  final String url;

  FileModel({required this.filename, required this.url});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(filename: json['filename'], url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {"filename": filename, "url": url};
  }
}
