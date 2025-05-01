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
  final List<LeadFile> files;
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
    if (json['lead_members'] is Map &&
        json['lead_members']['lead_members'] is List) {
      members = (json['lead_members']['lead_members'] as List)
          .map((e) => LeadMember.fromJson(e))
          .toList();
    }

    List<LeadFile> leadFiles = [];
    if (json['files'] is List) {
      leadFiles = (json['files'] as List)
          .map((e) => LeadFile.fromJson(e))
          .toList();
    }

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
      leadMembers: members,
      source: json['source'],
      category: json['category'],
      files: leadFiles,
      status: json['status'],
      interestLevel: json['interest_level'],
      leadScore: json['lead_score'],
      isConverted: json['is_converted'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
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

class LeadFile {
  final String url;
  final String filename;

  LeadFile({required this.url, required this.filename});

  factory LeadFile.fromJson(Map<String, dynamic> json) {
    return LeadFile(url: json['url'], filename: json['filename']);
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'filename': filename};
  }
}
