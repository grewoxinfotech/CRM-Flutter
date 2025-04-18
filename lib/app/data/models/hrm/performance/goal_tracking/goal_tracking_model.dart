class GoalTrackingModel {
  final String id;
  final String branch;
  final String goalType;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String targetAchievement;
  final String description;
  final String rating;
  final String? progress;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  GoalTrackingModel({
    required this.id,
    required this.branch,
    required this.goalType,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.targetAchievement,
    required this.description,
    required this.rating,
    this.progress,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GoalTrackingModel.fromJson(Map<String, dynamic> json) {
    return GoalTrackingModel(
      id: json['id'],
      branch: json['branch'],
      goalType: json['goalType'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
      targetAchievement: json['target_achievement'],
      description: json['description'],
      rating: json['rating'],
      progress: json['progress'],
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
      'goalType': goalType,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'status': status,
      'target_achievement': targetAchievement,
      'description': description,
      'rating': rating,
      'progress': progress,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
