class LeadModel {
  final String? id;
  final String? leadTitle;
  final String? interestLevel;
  final String? currency;
  final int? leadValue;
  final String? pipeline;
  final String? leadStage;
  final String? source;
  final String? status;
  final String? category;
  final List<String>? leadMembers;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneCode;
  final String? telephone;
  final String? companyName;
  final String? address;
  final String? files;
  final int? leadScore;
  final bool? isConverted;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LeadModel({
    this.id,
    this.leadTitle,
    this.interestLevel,
    this.currency,
    this.leadValue,
    this.pipeline,
    this.leadStage,
    this.source,
    this.status,
    this.category,
    this.leadMembers,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneCode,
    this.telephone,
    this.companyName,
    this.address,
    this.files,
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
        json['lead_members']['lead_members'] ?? [],
      ),
      source: json['source'],
      category: json['category'],
      files: json['files'],
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
      'id': id,
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
      'lead_members': leadMembers,
      'source': source,
      'category': category,
      'files': files,
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
