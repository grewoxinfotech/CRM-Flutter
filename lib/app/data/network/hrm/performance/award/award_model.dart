class AwardModel {
  final String id;
  final String employee;
  final String awardType;
  final DateTime date;
  final String gift;
  final String description;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  AwardModel({
    required this.id,
    required this.employee,
    required this.awardType,
    required this.date,
    required this.gift,
    required this.description,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AwardModel.fromJson(Map<String, dynamic> json) {
    return AwardModel(
      id: json['id'],
      employee: json['employee'],
      awardType: json['awardType'],
      date: DateTime.parse(json['date']),
      gift: json['gift'],
      description: json['description'],
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
      'awardType': awardType,
      'date': date.toIso8601String(),
      'gift': gift,
      'description': description,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
