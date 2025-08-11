// class NoteModel {
//   final String id;
//   final String relatedId;
//   final String noteTitle;
//   final String notetype;
//   final String? employees;
//   final String description;
//   final String clientId;
//   final String createdBy;
//   final String? updatedBy;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   NoteModel({
//     required this.id,
//     required this.relatedId,
//     required this.noteTitle,
//     required this.notetype,
//     this.employees,
//     required this.description,
//     required this.clientId,
//     required this.createdBy,
//     this.updatedBy,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory NoteModel.fromJson(Map<String, dynamic> json) {
//     return NoteModel(
//       id: json['id'] ?? '',
//       relatedId: json['related_id'] ?? '',
//       noteTitle: json['note_title'] ?? '',
//       notetype: json['notetype'] ?? '',
//       employees: json['employees'],
//       description: json['description'] ?? '',

//       clientId: json['client_id'] ?? '',
//       createdBy: json['created_by'] ?? '',
//       updatedBy: json['updated_by'],

//       createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
//       updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'related_id': relatedId,
//       'note_title': noteTitle,
//       'notetype': notetype,
//       'employees': employees,
//       'description': description,
//       'client_id': clientId,
//       'created_by': createdBy,
//       'updated_by': updatedBy,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//     };
//   }
// }


class NoteModel {
  final String id;
  final String relatedId;
  final String noteTitle;
  final String notetype;
  final String? employees;
  final String description;
  final String? clientId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteModel({
    required this.id,
    required this.relatedId,
    required this.noteTitle,
    required this.notetype,
    this.employees,
    required this.description,
    this.clientId,
    this.createdBy,
    this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] ?? '',
      relatedId: json['related_id'] ?? '',
      noteTitle: json['note_title'] ?? '',
      notetype: json['notetype'] ?? '',
      employees: json['employees'],
      description: json['description'] ?? '',
      clientId: json['client_id'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'related_id': relatedId,
      'note_title': noteTitle,
      'notetype': notetype,
      'employees': employees,
      'description': description,
      'client_id': clientId,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
