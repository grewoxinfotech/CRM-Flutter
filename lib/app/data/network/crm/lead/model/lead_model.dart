class LeadModel {
  bool? success;
  LeadMessage? message;
  dynamic data;

  LeadModel({this.success, this.message, this.data});

  LeadModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message =
        json['message'] != null ? LeadMessage.fromJson(json['message']) : null;
    data = json['message']?['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    if (message != null) {
      map['message'] = message!.toJson();
    }
    map['message']?['data'] = data;
    return map;
  }
}

class LeadMessage {
  List<LeadData>? data;
  Pagination? pagination;

  LeadMessage({this.data, this.pagination});

  LeadMessage.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = List<LeadData>.from(json['data'].map((x) => LeadData.fromJson(x)));
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

class LeadData {
  String? id;
  dynamic inquiryId;
  String? leadTitle;
  String? dealId;
  String? leadStage;
  String? pipeline;
  String? currency;
  int? leadValue;
  String? companyId;
  String? contactId;
  LeadMembers? leadMembers;
  String? source;
  String? category;
  List<Files>? files;
  String? status;
  String? interestLevel;
  int? leadScore;
  bool? isConverted;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  LeadData({
    this.id,
    this.inquiryId,
    this.leadTitle,
    this.dealId,
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

  LeadData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    inquiryId = json['inquiry_id'];
    leadTitle = json['leadTitle']?.toString();
    leadStage = json['leadStage']?.toString();
    pipeline = json['pipeline']?.toString();
    currency = json['currency']?.toString();
    leadValue =
        json['leadValue'] != null
            ? int.tryParse(json['leadValue'].toString())
            : null;
    companyId = json['company_id']?.toString();
    contactId = json['contact_id']?.toString();
    leadMembers =
        json['lead_members'] != null
            ? LeadMembers.fromJson(json['lead_members'])
            : null;
    source = json['source']?.toString();
    category = json['category']?.toString();
    files =
        json['files'] != null
            ? List<Files>.from(json['files'].map((x) => Files.fromJson(x)))
            : null;
    status = json['status']?.toString();
    interestLevel = json['interest_level']?.toString();
    leadScore =
        json['lead_score'] != null
            ? int.tryParse(json['lead_score'].toString())
            : null;
    isConverted = json['is_converted']?.toString().toLowerCase() == 'true';
    clientId = json['client_id']?.toString();
    createdBy = json['created_by']?.toString();
    updatedBy = json['updated_by']?.toString();
    createdAt = json['createdAt']?.toString();
    updatedAt = json['updatedAt']?.toString();
    dealId = json['dealId']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['inquiry_id'] = inquiryId;
    map['leadTitle'] = leadTitle;
    map['leadStage'] = leadStage;
    map['pipeline'] = pipeline;
    map['currency'] = currency;
    map['leadValue'] = leadValue;
    map['company_id'] = companyId;
    map['contact_id'] = contactId;
    map['lead_members'] = leadMembers?.toJson();
    map['source'] = source;
    map['category'] = category;
    map['files'] = files?.map((x) => x.toJson()).toList();
    map['status'] = status;
    map['interest_level'] = interestLevel;
    map['lead_score'] = leadScore;
    map['is_converted'] = isConverted;
    map['client_id'] = clientId;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['dealId'] = dealId;
    return map;
  }
}

class LeadMembers {
  List<String>? leadMembers;

  LeadMembers({this.leadMembers});

  factory LeadMembers.fromJson(Map<String, dynamic> json) {
    return LeadMembers(
      leadMembers:
          json['lead_members'] != null
              ? List<String>.from(json['lead_members'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'lead_members': leadMembers};
  }

  bool get isEmpty => leadMembers == null || leadMembers!.isEmpty;
}

class Files {
  final String? url;
  final String? filename;

  Files({this.url, this.filename});

  factory Files.fromJson(Map<String, dynamic> json) => Files(
    url: json['url']?.toString(),
    filename: json['filename']?.toString(),
  );

  Map<String, dynamic> toJson() => {'url': url, 'filename': filename};
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
    final Map<String, dynamic> map = {};
    map['total'] = total;
    map['current'] = current;
    map['pageSize'] = pageSize;
    map['totalPages'] = totalPages;
    return map;
  }
}
