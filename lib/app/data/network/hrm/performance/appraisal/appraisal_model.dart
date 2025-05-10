class AppraisalModel {
  final String id;
  final String employee;
  final String branch;
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

  AppraisalModel({
    required this.id,
    required this.employee,
    required this.branch,
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

  factory AppraisalModel.fromJson(Map<String, dynamic> json) {
    return AppraisalModel(
      id: json['id'],
      employee: json['employee'],
      branch: json['branch'],
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
      'employee': employee,
      'branch': branch,
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
