class BranchModel {
  final String id;
  final String branchName;
  final String branchAddress;
  final String branchManager;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  BranchModel({
    required this.id,
    required this.branchName,
    required this.branchAddress,
    required this.branchManager,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      branchName: json['branchName'],
      branchAddress: json['branchAddress'],
      branchManager: json['branchManager'],
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
      'branchName': branchName,
      'branchAddress': branchAddress,
      'branchManager': branchManager,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
