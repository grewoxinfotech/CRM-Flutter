class LeadModel {
  String? id;
  String? leadTitle;
  String? leadStage;
  String? currency;
  String? leadValue;
  String? firstName;
  String? lastName;
  String? phoneCode;
  String? telephone;
  String? email;
  String? assigned;
  String? leadMembers;
  String? source;
  String? category;
  String? files;
  String? status;
  String? tag;
  String? companyName;
  String? clientId;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;

  LeadModel({
    this.id,
    this.leadTitle,
    this.leadStage,
    this.currency,
    this.leadValue,
    this.firstName,
    this.lastName,
    this.phoneCode,
    this.telephone,
    this.email,
    this.assigned,
    this.leadMembers,
    this.source,
    this.category,
    this.files,
    this.status,
    this.tag,
    this.companyName,
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
      currency: json['currency'],
      leadValue: json['leadValue'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneCode: json['phoneCode'],
      telephone: json['telephone'],
      email: json['email'],
      assigned: json['assigned'],
      leadMembers: json['lead_members'],
      source: json['source'],
      category: json['category'],
      files: json['files'],
      status: json['status'],
      tag: json['tag'],
      companyName: json['company_name'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leadTitle': leadTitle,
      'leadStage': leadStage,
      'currency': currency,
      'leadValue': leadValue,
      'firstName': firstName,
      'lastName': lastName,
      'phoneCode': phoneCode,
      'telephone': telephone,
      'email': email,
      'assigned': assigned,
      'lead_members': leadMembers,
      'source': source,
      'category': category,
      'files': files,
      'status': status,
      'tag': tag,
      'company_name': companyName,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
