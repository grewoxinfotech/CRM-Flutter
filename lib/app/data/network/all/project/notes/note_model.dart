class NoteModel {
  final String? id;
  final String? relatedId;
  final String? noteTitle;
  final String? noteType;
  final List<String>? employees;
  final String? description;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NoteModel({
    this.id,
    this.relatedId,
    this.noteTitle,
    this.noteType,
    this.employees,
    this.description,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      relatedId: json['related_id'],
      noteTitle: json['note_title'],
      noteType: json['notetype'],
      employees: (json['employees'] as List?)?.map((e) => e.toString()).toList(),
      description: json['description'],
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'related_id': relatedId,
      'note_title': noteTitle,
      'notetype': noteType,
      'employees': employees,
      'description': description,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
