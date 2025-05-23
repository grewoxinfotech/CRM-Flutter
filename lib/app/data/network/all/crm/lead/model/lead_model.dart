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

  LeadModel({
    this.id,
    this.inquiryId,
    this.leadTitle,
    this.leadStage,
    this.pipeline,
    this.currency,
    this.leadValue,
    this.companyId,
    this.contactId,
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
    // Safe parsing of leadMembers
    List<String>? parseLeadMembers(dynamic jsonData) {
      try {
        if (jsonData == null) return null;
        // If it is a Map with a key 'lead_members' holding a list
        if (jsonData is Map && jsonData['lead_members'] != null) {
          return List<String>.from(jsonData['lead_members']);
        }
        // If it is directly a List
        if (jsonData is List) {
          return List<String>.from(jsonData);
        }
      } catch (_) {}
      return null;
    }

    // Safe parsing of files
    List<LeadFile>? parseFiles(dynamic jsonData) {
      try {
        if (jsonData == null) return null;
        if (jsonData is List) {
          return jsonData.map((f) => LeadFile.fromJson(f)).toList();
        }
      } catch (_) {}
      return null;
    }

    // Safe parsing of DateTime
    DateTime? parseDate(String? dateString) {
      try {
        if (dateString == null || dateString.isEmpty) return null;
        return DateTime.parse(dateString);
      } catch (_) {
        return null;
      }
    }

    return LeadModel(
      id: json['id']?.toString(),
      inquiryId: json['inquiry_id']?.toString(),
      leadTitle: json['leadTitle']?.toString(),
      leadStage: json['leadStage']?.toString(),
      pipeline: json['pipeline']?.toString(),
      currency: json['currency']?.toString(),
      leadValue: json['leadValue'] is int ? json['leadValue'] : int.tryParse(json['leadValue']?.toString() ?? ''),
      companyId: json['company_id']?.toString(),
      contactId: json['contact_id']?.toString(),
      leadMembers: parseLeadMembers(json['lead_members']),
      source: json['source']?.toString(),
      category: json['category']?.toString(),
      files: parseFiles(json['files']),
      status: json['status']?.toString(),
      interestLevel: json['interest_level']?.toString(),
      leadScore: json['lead_score'] is int ? json['lead_score'] : int.tryParse(json['lead_score']?.toString() ?? ''),
      isConverted: json['is_converted'] == null ? null : (json['is_converted'] == true || json['is_converted'] == 1),
      clientId: json['client_id']?.toString(),
      createdBy: json['created_by']?.toString(),
      updatedBy: json['updated_by']?.toString(),
      createdAt: parseDate(json['createdAt']),
      updatedAt: parseDate(json['updatedAt']),
    );
  }
}

class LeadFile {
  final String url;
  final String filename;

  LeadFile({required this.url, required this.filename});

  factory LeadFile.fromJson(Map<String, dynamic> json) {
    return LeadFile(
      url: json['url']?.toString() ?? '',
      filename: json['filename']?.toString() ?? '',
    );
  }
}
