class LabelModel {
  final String id;
  final String relatedId;
  final String labelType;
  final String name;
  final String color;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final String createdAt;
  final String updatedAt;

  LabelModel({
    required this.id,
    required this.relatedId,
    required this.labelType,
    required this.name,
    required this.color,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LabelModel.fromJson(Map<String, dynamic> json) {
    return LabelModel(
      id: json['id'] ?? '',
      relatedId: json['related_id'] ?? '',
      labelType: json['label_type'] ?? json['lableType'] ?? '',
      name: json['name'] ?? '',
      color: json['color'] ?? '',
      clientId: json['client_id'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'related_id': relatedId,
      'label_type': labelType,
      'name': name,
      'color': color,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
} 