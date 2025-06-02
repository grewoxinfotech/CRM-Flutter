class LeadModel {
  final String? id;
  final String? inquiryId;
  final String? leadTitle;
  final String? leadStage;
  final String? pipeline;
  final String? currency;
  final int? leadValue;
  final String? companyId;
  final String? contactId;
  final List<String>? leadMembers;
  final String? source;
  final String? category;
  final List<LeadFile>? files;
  final String? status;
  final String? interestLevel;
  final int? leadScore;
  final bool? isConverted;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? key;

  LeadModel({
    required this.id,
    required this.inquiryId,
    required this.leadTitle,
    required this.leadStage,
    required this.pipeline,
    required this.currency,
    required this.leadValue,
    required this.companyId,
    required this.contactId,
    required this.leadMembers,
    required this.source,
    required this.category,
    required this.files,
    required this.status,
    required this.interestLevel,
    required this.leadScore,
    required this.isConverted,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.key,
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
      companyId: json['company_id'],
      contactId: json['contact_id'],
      leadMembers:
          (json['lead_members']?['lead_members'] as List?)
              ?.map((e) => e.toString())
              .toList(),
      source: json['source'],
      category: json['category'],
      files:
          (json['files'] as List?)?.map((e) => LeadFile.fromJson(e)).toList(),
      status: json['status'],
      interestLevel: json['interest_level'],
      leadScore: json['lead_score'],
      isConverted: json['is_converted'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
      key: json['key'],
    );
  }
}

class LeadFile {
  final String url;
  final String filename;

  LeadFile({required this.url, required this.filename});

  factory LeadFile.fromJson(Map<String, dynamic> json) {
    return LeadFile(url: json['url'] ?? '', filename: json['filename'] ?? '');
  }
}
