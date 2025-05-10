class AnnouncementModel {
  final String id;
  final String title;
  final String description;
  final String? branch;
  final String time;
  final String date;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  AnnouncementModel({
    required this.id,
    this.branch,
    this.updatedBy,
    required this.title,
    required this.description,
    required this.time,
    required this.date,
    required this.clientId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'],
      branch: json['branch'],
      updatedBy: json['updated_by'],
      title: json['title'],
      description: json['description'],
      time: json['time'],
      date: json['date'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branch': branch,
      'updated_by': updatedBy,
      'title': title,
      'description': description,
      'time': time,
      'date': date,
      'client_id': clientId,
      'created_by': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
