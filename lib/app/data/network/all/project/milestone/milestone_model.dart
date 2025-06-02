class MilestoneModel {
  final String id;
  final String relatedId;
  final String milestoneTitle;
  final String milestoneStatus;
  final String milestoneCost;
  final String milestoneSummary;
  final DateTime milestoneStartDate;
  final DateTime milestoneEndDate;
  final String addCostToProjectBudget;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  MilestoneModel({
    required this.id,
    required this.relatedId,
    required this.milestoneTitle,
    required this.milestoneStatus,
    required this.milestoneCost,
    required this.milestoneSummary,
    required this.milestoneStartDate,
    required this.milestoneEndDate,
    required this.addCostToProjectBudget,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MilestoneModel.fromJson(Map<String, dynamic> json) {
    return MilestoneModel(
      id: json['id'],
      relatedId: json['related_id'],
      milestoneTitle: json['milestone_title'],
      milestoneStatus: json['milestone_status'],
      milestoneCost: json['milestone_cost'],
      milestoneSummary: json['milestone_summary'],
      milestoneStartDate: DateTime.parse(json['milestone_start_date']),
      milestoneEndDate: DateTime.parse(json['milestone_end_date']),
      addCostToProjectBudget: json['add_cost_to_project_budget'],
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
      'related_id': relatedId,
      'milestone_title': milestoneTitle,
      'milestone_status': milestoneStatus,
      'milestone_cost': milestoneCost,
      'milestone_summary': milestoneSummary,
      'milestone_start_date': milestoneStartDate.toIso8601String(),
      'milestone_end_date': milestoneEndDate.toIso8601String(),
      'add_cost_to_project_budget': addCostToProjectBudget,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
