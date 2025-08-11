// import 'package:crm_flutter/app/data/network/file/model/file_model.dart';
//
// class LeadModel {
//   final String? id;
//   final String? inquiryId;
//   final String? leadTitle;
//   final String? leadStage;
//   final String? pipeline;
//   final String? currency;
//   final int? leadValue;
//   final String? companyName;
//   final String? contactId;
//   final String? firstName;
//   final String? lastName;
//   final String? phoneCode;
//   final String? telephone;
//   final String? email;
//   final String? address;
//   final List<LeadMember> leadMembers;
//   final String? source;
//   final String? category;
//   final List<FileModel> files;
//   final String? status;
//   final String? interestLevel;
//   final int? leadScore;
//   final bool? isConverted;
//   final String? clientId;
//   final String? createdBy;
//   final String? updatedBy;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   LeadModel({
//     this.id,
//     this.inquiryId,
//     this.leadTitle,
//     this.leadStage,
//     this.pipeline,
//     this.currency,
//     this.leadValue,
//     this.companyName,
//     this.contactId,
//     this.firstName,
//     this.lastName,
//     this.phoneCode,
//     this.telephone,
//     this.email,
//     this.address,
//     this.leadMembers = const [],
//     this.source,
//     this.category,
//     this.files = const [],
//     this.status,
//     this.interestLevel,
//     this.leadScore,
//     this.isConverted,
//     this.clientId,
//     this.createdBy,
//     this.updatedBy,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   // Create a new LeadModel with updated members
//   LeadModel copyWithUpdatedMembers(List<LeadMember> updatedMembers) {
//     return LeadModel(
//       id: id,
//       inquiryId: inquiryId,
//       leadTitle: leadTitle,
//       leadStage: leadStage,
//       pipeline: pipeline,
//       currency: currency,
//       leadValue: leadValue,
//       companyName: companyName,
//       contactId: contactId,
//       firstName: firstName,
//       lastName: lastName,
//       phoneCode: phoneCode,
//       telephone: telephone,
//       email: email,
//       address: address,
//       leadMembers: updatedMembers,
//       source: source,
//       category: category,
//       files: files,
//       status: status,
//       interestLevel: interestLevel,
//       leadScore: leadScore,
//       isConverted: isConverted,
//       clientId: clientId,
//       createdBy: createdBy,
//       updatedBy: updatedBy,
//       createdAt: createdAt,
//       updatedAt: updatedAt,
//     );
//   }
//
//   factory LeadModel.fromJson(Map<String, dynamic> json) {
//     // Debug the incoming JSON
//     print("Processing lead JSON: ${json.keys.toList()}");
//
//     List<LeadMember> members = [];
//     if (json['lead_members'] != null) {
//       if (json['lead_members'] is Map && json['lead_members']['lead_members'] is List) {
//         final memberIds = json['lead_members']['lead_members'] as List;
//         // Check if the list is empty
//         if (memberIds.isNotEmpty) {
//         members = memberIds.map((id) => LeadMember(
//           memberId: id.toString(),
//           name: '',
//           designation: '',
//           email: '',
//           phone: '',
//         )).toList();
//           print("Found ${members.length} lead members from map");
//         } else {
//           print("Lead members list is empty (map structure)");
//         }
//       } else if (json['lead_members'] is List) {
//         final memberIds = json['lead_members'] as List;
//         if (memberIds.isNotEmpty) {
//         members = memberIds.map((id) => LeadMember(
//           memberId: id.toString(),
//           name: '',
//           designation: '',
//           email: '',
//           phone: '',
//         )).toList();
//           print("Found ${members.length} lead members from list");
//         } else {
//           print("Lead members list is empty (list structure)");
//         }
//       } else {
//         print("Unsupported lead_members structure: ${json['lead_members']}");
//       }
//     } else {
//       print("No lead_members field found in JSON");
//     }
//
//     List<FileModel> leadFiles = [];
//     if (json['files'] != null && json['files'] is! String && json['files'] != "null") {
//       if (json['files'] is List) {
//         leadFiles = (json['files'] as List)
//             .map((e) => FileModel.fromJson(e as Map<String, dynamic>))
//             .toList();
//       }
//     }
//
//     // Get company name from either company_name or company_id
//     String? companyName;
//     if (json['company_name'] != null) {
//       companyName = json['company_name'].toString();
//     } else if (json['company_id'] != null) {
//       companyName = json['company_id'].toString();
//       print("Using company_id as companyName: $companyName");
//     } else if (json['company'] != null) {
//       companyName = json['company'].toString();
//     } else if (json['contact_id'] != null) {
//       // If no company info but contact_id exists, use that as company placeholder
//       companyName = 'Contact: ${json['contact_id']}';
//     }
//
//     // Ensure status is properly handled
//     String? status = json['status']?.toString();
//     print("Status from API: $status"); // Debug status value
//     if (status == "null" || status == null) {
//       status = ""; // Convert null or "null" string to empty string
//       print("Setting status to empty string");
//     }
//
//     // Convert boolean is_converted to string
//     bool isConverted = false;
//     if (json['is_converted'] != null) {
//       if (json['is_converted'] is bool) {
//         isConverted = json['is_converted'];
//       } else {
//         isConverted = json['is_converted'].toString().toLowerCase() == 'true';
//       }
//       print("is_converted value: $isConverted");
//     }
//
//     // Debug field extraction
//     print("leadTitle: ${json['leadTitle']}");
//     print("firstName: ${json['firstName']}");
//     print("lastName: ${json['lastName']}");
//     print("telephone: ${json['telephone']}");
//     print("phone: ${json['phone']}");
//
//     // Get phone number from either telephone or phone
//     String? telephone;
//     if (json['telephone'] != null) {
//       telephone = json['telephone'].toString();
//     } else if (json['phone'] != null) {
//       telephone = json['phone'].toString();
//     }
//
//     return LeadModel(
//       id: json['id']?.toString(),
//       inquiryId: json['inquiry_id']?.toString(),
//       leadTitle: json['leadTitle']?.toString(),
//       leadStage: json['leadStage']?.toString(),
//       pipeline: json['pipeline']?.toString(),
//       currency: json['currency']?.toString(),
//       leadValue: json['leadValue'] != null ? int.tryParse(json['leadValue'].toString()) : null,
//       companyName: companyName,
//       contactId: json['contact_id']?.toString(),
//       firstName: json['firstName']?.toString() ?? json['first_name']?.toString(),
//       lastName: json['lastName']?.toString() ?? json['last_name']?.toString(),
//       phoneCode: json['phoneCode']?.toString() ?? json['phone_code']?.toString(),
//       telephone: telephone,
//       email: json['email']?.toString(),
//       address: json['address']?.toString(),
//       leadMembers: members,
//       source: json['source']?.toString(),
//       category: json['category']?.toString(),
//       files: leadFiles,
//       status: status,
//       interestLevel: json['interest_level']?.toString(),
//       leadScore: json['lead_score'] != null ? int.tryParse(json['lead_score'].toString()) : null,
//       isConverted: isConverted,
//       clientId: json['client_id']?.toString(),
//       createdBy: json['created_by']?.toString(),
//       updatedBy: json['updated_by']?.toString(),
//       createdAt: json['createdAt'] != null
//           ? DateTime.tryParse(json['createdAt'].toString())
//           : null,
//       updatedAt: json['updatedAt'] != null
//           ? DateTime.tryParse(json['updatedAt'].toString())
//           : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'inquiry_id': inquiryId,
//       'leadTitle': leadTitle,
//       'leadStage': leadStage,
//       'pipeline': pipeline,
//       'currency': currency,
//       'leadValue': leadValue,
//       'company_name': companyName,
//       'contact_id': contactId,
//       'firstName': firstName,
//       'lastName': lastName,
//       'phoneCode': phoneCode,
//       'telephone': telephone,
//       'email': email,
//       'address': address,
//       'lead_members': {
//         'lead_members': leadMembers.map((e) => e.toJson()).toList(),
//       },
//       'source': source,
//       'category': category,
//       'files': files.map((e) => e.toJson()).toList(),
//       'status': status,
//       'interest_level': interestLevel,
//       'lead_score': leadScore,
//       'is_converted': isConverted,
//       'client_id': clientId,
//       'created_by': createdBy,
//       'updated_by': updatedBy,
//       'createdAt': createdAt?.toIso8601String(),
//       'updatedAt': updatedAt?.toIso8601String(),
//     };
//   }
// }
//
//
// class LeadMember {
//   final String memberId;
//   final String name;
//   final String designation;
//   final String email;
//   final String phone;
//
//   LeadMember({
//     required this.memberId,
//     required this.name,
//     required this.designation,
//     required this.email,
//     required this.phone,
//   });
//
//   factory LeadMember.fromJson(Map<String, dynamic> json) {
//     return LeadMember(
//       memberId: json['member_id'],
//       name: json['name'],
//       designation: json['designation'],
//       email: json['email'],
//       phone: json['phone'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'member_id': memberId,
//       'name': name,
//       'designation': designation,
//       'email': email,
//       'phone': phone,
//     };
//   }
//
//   @override
//   String toString() {
//     return 'LeadMember(memberId: $memberId, name: $name)';
//   }
// }
class LeadModel {
  final String? id;
  final dynamic inquiryId;
  final String? leadTitle;
  final String? leadStage;
  final String? pipeline;
  final String? currency;
  final int? leadValue;
  final String? companyId;
  final String? contactId;
  final LeadMembers? leadMembers;
  final String? source;
  final String? category;
  final List<Files>? files;
  final String? status;
  final String? interestLevel;
  final int? leadScore;
  final bool? isConverted;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final String? createdAt;
  final String? updatedAt;

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

  factory LeadModel.fromJson(Map<String, dynamic> json) => LeadModel(
    id: json['id']?.toString(),
    inquiryId: json['inquiry_id'],
    leadTitle: json['leadTitle']?.toString(),
    leadStage: json['leadStage']?.toString(),
    pipeline: json['pipeline']?.toString(),
    currency: json['currency']?.toString(),
    leadValue:
        json['leadValue'] != null
            ? int.tryParse(json['leadValue'].toString())
            : null,
    companyId: json['company_id']?.toString(),
    contactId: json['contact_id']?.toString(),
    leadMembers:
        json['lead_members'] != null
            ? LeadMembers.fromJson(json['lead_members'])
            : null,
    source: json['source']?.toString(),
    category: json['category']?.toString(),
    files:
        json['files'] != null
            ? List<Files>.from(json['files'].map((x) => Files.fromJson(x)))
            : null,
    status: json['status']?.toString(),
    interestLevel: json['interest_level']?.toString(),
    leadScore:
        json['lead_score'] != null
            ? int.tryParse(json['lead_score'].toString())
            : null,
    isConverted: json['is_converted']?.toString().toLowerCase() == 'true',
    clientId: json['client_id']?.toString(),
    createdBy: json['created_by']?.toString(),
    updatedBy: json['updated_by']?.toString(),
    createdAt: json['createdAt']?.toString(),
    updatedAt: json['updatedAt']?.toString(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'inquiry_id': inquiryId,
    'leadTitle': leadTitle,
    'leadStage': leadStage,
    'pipeline': pipeline,
    'currency': currency,
    'leadValue': leadValue,
    'company_id': companyId,
    'contact_id': contactId,
    'lead_members': leadMembers?.toJson(),
    'source': source,
    'category': category,
    'files': files?.map((x) => x.toJson()).toList(),
    'status': status,
    'interest_level': interestLevel,
    'lead_score': leadScore,
    'is_converted': isConverted,
    'client_id': clientId,
    'created_by': createdBy,
    'updated_by': updatedBy,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
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

  // Add this convenience getter for null safety
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
