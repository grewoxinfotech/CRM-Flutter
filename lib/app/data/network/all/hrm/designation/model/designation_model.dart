class DesignationModel {
  final String id;
  final String branch;
  final String designationName;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String key;

  DesignationModel({
    required this.id,
    required this.branch,
    required this.designationName,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.key,
  });

  factory DesignationModel.fromJson(Map<String, dynamic> json) {
    return DesignationModel(
      id: json['id'] ?? '',
      branch: json['branch'] ?? '',
      designationName: json['designation_name'] ?? '',
      clientId: json['client_id'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      key: json['key'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branch': branch,
      'designation_name': designationName,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'key': key,
    };
  }
}



