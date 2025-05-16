import 'dart:convert';

class NoteModel {
  final String id;
  final String relatedId;
  final String noteTitle;
  final String noteType;
  final List<String> employees;
  final String description;
  final String clientId;
  final String createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteModel({
    required this.id,
    required this.relatedId,
    required this.noteTitle,
    required this.noteType,
    required this.employees,
    required this.description,
    required this.clientId,
    required this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    final employeesJson = jsonDecode(json['employees']);
    return NoteModel(
      id: json['id'],
      relatedId: json['related_id'],
      noteTitle: json['note_title'],
      noteType: json['notetype'],
      employees: List<String>.from(employeesJson['employee']),
      description: json['description'],
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
      'note_title': noteTitle,
      'notetype': noteType,
      'employees': jsonEncode({'employee': employees}),
      'description': description,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
