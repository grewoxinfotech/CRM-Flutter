class IndicatorModel {
  final String id;
  final String branch;
  final String department;
  final String designation;
  final int businessProcess;
  final int oralCommunication;
  final int leadership;
  final int projectManagement;
  final int allocatingResources;
  final int overallRating;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  IndicatorModel({
    required this.id,
    required this.branch,
    required this.department,
    required this.designation,
    required this.businessProcess,
    required this.oralCommunication,
    required this.leadership,
    required this.projectManagement,
    required this.allocatingResources,
    required this.overallRating,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IndicatorModel.fromJson(Map<String, dynamic> json) {
    return IndicatorModel(
      id: json['id'],
      branch: json['branch'],
      department: json['department'],
      designation: json['designation'],
      businessProcess: json['businessProcess'],
      oralCommunication: json['oralCommunication'],
      leadership: json['leadership'],
      projectManagement: json['projectManagement'],
      allocatingResources: json['allocatingResources'],
      overallRating: json['overallRating'],
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
      'branch': branch,
      'department': department,
      'designation': designation,
      'businessProcess': businessProcess,
      'oralCommunication': oralCommunication,
      'leadership': leadership,
      'projectManagement': projectManagement,
      'allocatingResources': allocatingResources,
      'overallRating': overallRating,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
