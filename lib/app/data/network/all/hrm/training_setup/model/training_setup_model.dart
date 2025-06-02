class TrainingModel {
  final String id;
  final String title;
  final String category;
  final TrainingLinks links;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String key;

  TrainingModel({
    required this.id,
    required this.title,
    required this.category,
    required this.links,
    required this.clientId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.key,
  });

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      links: TrainingLinks.fromJson(json['links']),
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
      'title': title,
      'category': category,
      'links': links.toJson(),
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'key': key,
    };
  }
}

class TrainingLinks {
  final List<String> urls;
  final List<String> titles;

  TrainingLinks({
    required this.urls,
    required this.titles,
  });

  factory TrainingLinks.fromJson(Map<String, dynamic> json) {
    return TrainingLinks(
      urls: List<String>.from(json['urls'] ?? []),
      titles: List<String>.from(json['titles'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'urls': urls,
      'titles': titles,
    };
  }
}
